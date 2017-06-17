macroScript Tik_Voxel_Animater
category: "Tik Works"
tooltip: "Tik Voxel Animater"
buttonText: "Voxel Animater"


(
escapeEnable = true
global arr = #()
global parallelchunk = #()
global RD
global z_line
global theChunkArray
global b
global renk

---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------FUNCTIONS--------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------


fn anima t vxlmh =
		(
		for y = 1 to RD.height do
		(
		RD.frame = t
		z_line = getpixels RD [0,y-1] RD.width
		theChunkArray = for i = (parallelchunk[y]) to ((parallelchunk[y] + RD.width) - 1) collect arr[i]

		for x = 1 to RD.width do
			(
			theChunkArray[x].height = ((z_line[x].value/2)+vxlmh.value)
			)
		)
		)

fn voxmate vox_type_ddl rnd theColor vxlsize vxlbh vxlmh ofs = 
(
	undo off
	delete $VoxelBox* -- Deletes all previous Voxels
	
	progressstart "Creating Voxels..." -- Start Progressbar

	for y = 1 to RD.height do
		(
		if not progressupdate (100.0 * y / RD.height) then exit --Update Progressbar
		z_line = getpixels RD [0,y-1] RD.width --Get parallel lines
			for x = 1 to RD.width do
----------------------------------------------------------------------------------------------------------------

			
--------------------------------------------------------------------------------------------
				(
					 -- create boxes as voxels
					if vox_type_ddl.selection == 1 do  										
						(																					
						b = box width:vxlsize.value length:vxlsize.value height:vxlbh.value
						)																					
					-- creates chamferboxes as voxels
					if vox_type_ddl.selection == 2 do
						(
						b = chamferbox width:vxlsize.value length:vxlsize.value height:vxlbh.value fillet:2
						)
					-- creates capsules as voxels
					if vox_type_ddl.selection == 3 do
						(
						b = capsule radius:(vxlsize.value /2) sides:8 height:vxlbh.value
						)
					--creates spindles as voxels
					if vox_type_ddl.selection == 4 do
						(
						b = spindle radius:(vxlsize.value /2) sides:8 height:20 cap_height:vxlbh.value
						)
					/*	
					arg = getprogressCancel ()
						if arg == true then
						(
							break
						)
						else ()
					*/
					b.pos = [x*(vxlsize.value+ofs.value),-y*(vxlsize.value+ofs.value),0]
					if rnd.checked == true then 
					(
						b.wirecolor = color (random 0 255) (random 0 255) (random 0 255) 
					)
					else
					(
						b.wirecolor = theColor.color
					)
					b.name = uniquename "VoxelBox"

				)--end x loop
		)--end y loop
	
		progressEnd ()
	
		arr = $voxelbox* as array --Makes all VoxelBox objects Array
		if arr.count == (RD.width * RD.height) then 
		
		(
		
				progressStart "Tik Taki Tok Tokking"

				
				parallelchunk = #(1) 
				for i = 1 to RD.width do
				(
					append parallelchunk ((i*RD.width)+1)
				)
				

				animate on
				   
				for i in 0 to RD.numframes do
				(
					--if arr.count != RD.count then exit
					progressupdate (100*i/RD.numframes)
					at time i
					(   
						anima i vxlmh
					)
				)
				progressend ()
		)
		else ()
)


---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------ROLLOUTS----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

if RO != undefined then (closeRolloutFloater RO)
RO = NewRolloutFloater "TIK Voxel Animater" 200 350
(
	rollout voxelprops "Voxel Properties"
	(
	button choosemap "Select Image" tooltip:"Select Video or Image" width:120
		group "Voxel Type"
	(
	dropdownlist vox_type_ddl  items:#("Box", "Chamferbox", "Capsule", "Spindle") tooltip: "Select Voxel Type"
	)
		group "Properties"
	(
	spinner vxlsize "Voxel Size" range:[0,9999,10] tooltip: "Determine size of each Voxel" fieldwidth: 40 align:#right
	spinner vxlbh "Voxel Base Height" range:[0,999,20] tooltip: "Determine height of each Voxel" fieldwidth: 40 align:#right
	spinner vxlmh "Voxel Maximum Height" range:[0,999,40] tooltip: "Determine Maximum height of each Voxel" fieldwidth: 40 align:#right
	spinner ofs "Kerning" range: [0,9999,0] tooltip: "Determine space between two Voxels" fieldwidth: 40 align:#right
	)
		group "Color"
	(
	colorpicker theColor "Wireframe color:" modal:false align:#center
	checkbox rnd "Random Color" align:#center
	)	
	
	button yuru_bak "Execute" enabled: false
	
		on rnd changed state do 
		(
		if rnd.state == true then	theColor.enabled = false
		else (theColor.enabled = true)
		)

		on vxlbh changed value do
		(
		if vxlmh.value < vxlbh.value then vxlmh.value = vxlbh.value
		)
		on vxlmh changed value do
		(
		if vxlbh.value > vxlmh.value then vxlbh.value = vxlmh.value
		)
		
		on choosemap pressed do
		(
		RD = selectbitmap ()
		try choosemap.text=classof RD as string
			catch (choosemap.text="<<none>>")		
		if RD != unidentified then
		(yuru_bak.enabled = true)
		else
		(yuru_bak.enabled = false)
		)
		
		on yuru_bak pressed do
		(
			if RD.height + RD.width > 40 then
qb = queryBox "Relatively high resolutions and long sequences may take too much time or cause a crash. Are you sure you want to continue? " beep:false
if qb == true then 		
			(
			voxmate vox_type_ddl rnd theColor vxlsize vxlbh vxlmh ofs
			)
			else
			()
		)
	)--End of Voxel Properties Rollout
)--end of rollouts
		

addRollout voxelprops RO 

rollout about_roll "About"
(
	label script1 "Tik Works "
	label script2 "Voxel Animater v1.7"
	label author "Arda Kutlu"
	label year  "2008"
	label web "ardakutlu@gmail.com"
)
addRollout about_roll RO rolledUp:true

)--end of script
	

