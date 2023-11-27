macroScript randomize
category: "Tik Works"
toolTip: "Mass Randomizer"
buttonText: "Mass Randomizer"

(
global posMinX=0
global posMaxX=0
global posMinY=0
global posMaxY=0
global posMinZ=0
global posMaxZ=0
global rotMinX=-360
global rotMaxX=360
global rotMinY=-360
global rotMaxY=360
global rotMinZ=-360
global rotMaxZ=360
global scaMinX=50
global scaMaxX=150
global scaMinY=50
global scaMaxY=150
global scaMinZ=50
global scaMaxZ=150

	local MMaterial
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---FUNCTIONS------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fn randomizeR xa xb ya yb za zb iflocalRot rotgroupchkb= --function for random Rotation 
	undo "randomize rotation" on
(
	local filteredselectArr
	if rotgroupchkb == true then filteredselectArr = for obj in selection where isgrouphead obj == true or isOpenGroupMember obj == true or isgroupmember obj == false collect obj 
	else filteredselectArr = selection as array
	
	for i in filteredselectArr do
	(
	if iflocalRot == true then
		(
		in coordsys local i.rotation  = eulerangles  (random xa xb)  (random ya yb) (random za zb)
		)
	else
		(
		rotate i (eulerangles  (random xa xb)  (random ya yb) (random za zb)))
		)
	filteredselectArr=#()
)

fn randomizeP xpa xpb ypa ypb zpa zpb iflocalPos Posgroupchkb= --function for random Position
	undo "randomize position"on
(
	
	local filteredselectArr
	if Posgroupchkb == true then filteredselectArr = for obj in selection where isgrouphead obj == true or isOpenGroupMember obj == true or isgroupmember obj == false collect obj 
	
	else filteredselectArr = selection as array
	
	for i in filteredselectArr do
	(
		if iflocalPos == true then
		(
		in coordsys local  i.pos =  [(random xpa xpb),  (random ypa ypb), (random zpa zpb)]
		)
		else
		(
		move i [(random xpa xpb),  (random ypa ypb), (random zpa zpb)]
		)
	)
	filteredselectArr=#()
)

fn randomizeS xmin xmax ymin ymax zmin zmax prop Scalegroupchkb= --function for random Scale
	undo "randomize scale"on
(
		local filteredselectArr
		if Scalegroupchkb == true then filteredselectArr = for obj in selection where isgrouphead obj == true or isOpenGroupMember obj == true or isgroupmember obj == false collect obj 
		else filteredselectArr = selection as array
	
		for i in filteredselectArr do
		(
			
			x =  (random xmin xmax) /100
			y =  (random ymin ymax) /100
			z =  (random zmin zmax) /100
			if prop.checked == false then
			(
			i.scale = [x, y, z]
			)
			else
			(
			i.scale = [x, x, x]
			)
		)
		filteredselectArr=#()
)

fn rndID = --function for random G-Buffer ID
	undo "random G-Buffer" on
(
	for i in 1 to selection.count do selection[i].gbufferchannel = i
	messagebox "G-Buffer ID's are randomized"
)
				
fn randomParamL lmin lmax= --function for random Length
	undo "random Length" on
(
		for i in selection do
		(
				try i.length = (random lmin lmax) 
			catch ()
		)
)
	
fn randomParamW wmin wmax= --function for random Width
	undo "random Width" on
(
		for i in selection do
		(
				try i.width = (random wmin wmax) 
			catch ()
		)
)
	
fn randomParamH hmin hmax= --function for random Height
	undo "random Height" on
(
		for i in selection do
		(
				try i.height = (random hmin hmax) 
			catch ()
		)
)
	
fn randomParamR rmin rmax= --function for random Radius 
	undo "random Radius"on
(
		for i in selection do
		(
				try i.radius = (random rmin rmax) 
			catch ()
				try i.radius1 = (random rmin rmax) 
			catch ()
				try i.radius2 = (random rmin rmax) 
			catch ()
		)
)

fn rndUVW Uoffmin Uoffmax Voffmin Voffmax Rotoffmin Rotoffmax MapOrVertex Map_Channel= --function for random UV offsets
	undo "random UV"on
(
		sel = for obj in selection where not isgrouphead obj collect obj
		for i in sel do 
		(
			rndU=random Uoffmin Uoffmax --random U value
			rndV=random Voffmin Voffmax --random V value
			rndR=random Rotoffmin Rotoffmax -- random Rotation Value
			
			if i.modifiers[#UVW_Xform] != undefined then -- looks if the object has or has not the xform modifier
			(
				i.modifiers[#UVW_Xform].u_offset = rndU
				i.modifiers[#UVW_Xform].v_offset = rndV
				i.modifiers[#UVW_Xform].Rotation_Center = 1
				i.modifiers[#UVW_Xform].Rotation_Angle = rndR
				i.modifiers[#UVW_Xform].Map_or_Vertex_Color = MapOrVertex
				i.modifiers[#UVW_Xform].Map_Channel = Map_Channel
			)
			else
			(
				b = uvw_Xform ()
				b.u_offset = rndU
				b.v_offset = rndV
				b.Rotation_Center = 1
				b.Rotation_Angle = rndR
				b.Map_or_Vertex_Color = MapOrVertex
				b.Map_Channel = Map_Channel
				addModifier i b
			)
		)
)
	
fn selectrandomVerts apr = 
	undo "Select Random Vertices" on
(
	if classof (modpanel.getCurrentObject ()) != (Edit_Mesh) then 
	(
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) then 
	(
current_modifier = ( try(modpanel.getModifierIndex $ (modpanel.getCurrentObject()))catch(0) )

		sel_array = ($.modifiers[current_modifier].getSelection #currentlevel as array) --polyop.getVertSelection $
		count = sel_array.count
		new_sel_array = #{}
		for i =1 to (((count as float/100)*apr) as integer) do
		(
			rnd = random 1 sel_array.count
			append new_sel_array sel_array[rnd]
			deleteItem sel_array rnd
		)
		$.modifiers[current_modifier].setselection #currentlevel #{}
		$.modifiers[current_modifier].select #currentlevel new_sel_array
	)
	else 
	(
		sel_array = getvertSelection $ as array
		count=sel_array.count
		new_sel_array=#{}
		for i =1 to (((count as float/100)*apr) as integer) do
		(
			rnd = random 1 sel_array.count
			append new_sel_array sel_array[rnd]
			deleteItem sel_array rnd
		)
		try (polyop.setvertselection $ new_sel_array) catch (setvertselection $ new_sel_array)
		redrawviews()
	)
)
else (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier" beep:off)
)--end of random verts
------------------------------------------------------------------------------------------------------------------------------------
fn selectrandomFaces apr = 
	undo "Select Random Faces" on
(
	if classof (modpanel.getCurrentObject ()) != (Edit_Mesh) then 
	(
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) then 
	(
current_modifier = ( try(modpanel.getModifierIndex $ (modpanel.getCurrentObject()))catch(0) )

		sel_array = ($.modifiers[current_modifier].getSelection #currentlevel as array) 
		count = sel_array.count
		new_sel_array = #{}
		for i =1 to (((count as float/100)*apr) as integer) do
		(
			rnd = random 1 sel_array.count
			append new_sel_array sel_array[rnd]
			deleteItem sel_array rnd
		)
		$.modifiers[current_modifier].setselection #currentlevel #{}
		$.modifiers[current_modifier].select #currentlevel new_sel_array
	)
	else 
	(
		sel_array = getfaceSelection $ as array
		count=sel_array.count
		new_sel_array=#{}
		for i =1 to (((count as float/100)*apr) as integer) do
		(
			rnd = random 1 sel_array.count
			append new_sel_array sel_array[rnd]
			deleteItem sel_array rnd
		)
		setfaceselection $ new_sel_array
	)
)
else (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier" beep:off)
)--end of random faces
------------------------------------------------------------------------------------------------------------------------------------
fn selectrandomEdges apr = 
	undo "Select Random Edges" on
(
	if classof (modpanel.getCurrentObject ()) != (Edit_Mesh) then 
	(
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) then 
	(
current_modifier = ( try(modpanel.getModifierIndex $ (modpanel.getCurrentObject()))catch(0) )
		sel_array=($.modifiers[1].getSelection #currentlevel as array)
		count = sel_array.count
		new_sel_array = #{}
		for i =1 to (((count as float/100)*apr) as integer) do
		(
			rnd = random 1 sel_array.count
			append new_sel_array sel_array[rnd]
			deleteItem sel_array rnd
		)
		$.modifiers[current_modifier].setselection #currentlevel #{}
		$.modifiers[current_modifier].select #currentlevel new_sel_array

	)
	else 
	(
		sel_array = getedgeSelection $ as array
		count=sel_array.count
		new_sel_array=#{}
		for i =1 to (((count as float/100)*apr) as integer) do
		(
			rnd = random 1 sel_array.count
			append new_sel_array sel_array[rnd]
			deleteItem sel_array rnd
		)
		setedgeselection $ new_sel_array
	)
)
else (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier" beep:off)
)--end of random edges

------------------------------------------------------------------------------------------------------------------------------------

fn selectRandom apr groupchkb =
	undo "Select Random Objects" on
(
		if selection.count >=2 then
(	
	if groupchkb == true then Sel_array= for o in selection where isgrouphead o == true or isOpenGroupHead o ==true or isgroupmember o == false collect o
	else Sel_array = for o in selection where isgrouphead o == false or isOpenGroupHead o ==false collect o
		
	New_sel_array=#()
	
for i = 1 to (((Sel_array.count as float/100)*apr) as integer) do
	(

		rnd = random 1 sel_array.count
		append new_sel_array sel_array[rnd]
		deleteItem sel_array rnd
	)
select New_sel_array

free Sel_array
free new_sel_array
)
else
(messagebox "Select at least 2 groups, 2 objects, 2 edges, 2 vertices or two faces" beep:off) 
)--end of random objects


------------------------------------------------------------------------------------------------------------------------------------
fn returnElems obj sel_faces=
(
	(
		local elem_arr=#()
		local done=#() 

		for f in sel_faces do
			(
				if(findItem done f)==0 then
				(	
					local faces
					if iskindof obj Editable_poly do faces=(polyop.getElementsUsingFace obj f)as BitArray
					if iskindof obj Editable_mesh do faces=(meshop.getElementsUsingFace obj f)as BitArray
					append elem_arr faces
					join done faces
				)
			)
			free done
		)
		elem_arr
)
							
fn selectrandomElements apr =
	undo "Select Random Elements" on
(
	if classof (modpanel.getCurrentObject ()) == (Edit_Mesh) do (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier" beep:off ;return undefined)
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) do (messagebox "Selection Randomizer currently cannot work with Edit_Poly Modifier" beep:off ;return undefined)
	
	for obj in selection where iskindof obj Editable_poly or iskindof obj Editable_mesh do
	(
	
		local randSeed = random 1 99999
		local sel_faces=#{}
		
		if iskindof obj Editable_mesh do sel_faces = getFaceSelection obj
		if iskindof obj Editable_poly do sel_faces = polyop.getFaceSelection obj
		
		local elements = returnElems obj sel_faces
			
		if elements.count > 1 then
		(
			seed randSeed
			local rands = #()
			
			local TargetObjNum = floor(elements.count * (apr/100))
			local shuffledIndices = for i = 1 to elements.count collect i
			for i = shuffledIndices.count to 2 by -1 do
			(
				local j = random i elements.count
				swap shuffledIndices[i] shuffledIndices[j]
			)
			
			local HashTbl = #()  -- Create a hash table to store selected indices
			
			for r = 1 to TargetObjNum do
			(
				local index = shuffledIndices[r]
				
				while HashTbl[index] != undefined do
				(
					index = random 1 elements.count
				)
				
				HashTbl[index] = true
				append rands elements[index]
			)
		)
		else rands = elements

		local flat =#()
		for i in rands do join flat i
		
		if iskindof obj Editable_poly do
		(		
		polyop.setFaceSelection obj #none
		polyop.setFaceSelection obj (flat as BitArray)
		)
		if iskindof obj Editable_mesh do
		(		
		setFaceSelection obj (flat as BitArray)
		)
		
		max modify mode
		modPanel.setCurrentObject obj
		subobjectlevel = 5
		if iskindof obj Editable_poly do polyop.getElementsUsingFace obj flat
		if iskindof obj Editable_mesh do meshop.getElementsUsingFace obj flat
	)
)	
	
fn randommatmod matcount = 
	undo "Random Material Modifier" on
(
for i in selection do
(		
	rndMat = random 1 matcount


	if i.modifiers[#Material] != undefined then --checks if the object already have Material modifier
	(
	i.modifiers[#Material].materialID = rndMat
	)
	else
	(
	matmod = materialmodifier ()
	matmod.materialID = rndMat
	addmodifier i matmod --assigns material modifier to the object
	)
)
)--end of random material ID function

----------------------------------------------------------------------------------
fn rndwirecolor rmv_material =
	undo " Random Wire Colors" on
(
	if rmv_material == true do
	($.material = undefined)
	for i in selection do i.wirecolor = color (random 50 255) (random 50 255) (random 50 255)
)--end of random wirecolor
----------------------------------------------------------------------------------

fn rndmaterial Material_count= 
	undo "Random Material ID" on
(
		for i in selection do
		(
		rndMat = random 1 Material_count


		if i.modifiers[#Material] != undefined then --checks if the object already have Material modifier
		(
		i.modifiers[#Material].materialID = rndMat
		)
		else
		(
		matmod = materialmodifier ()
		matmod.materialID = rndMat
		addmodifier i matmod --assigns material modifier to the object
		)
			i.material = MMaterial
		)
	
)--end of random material
----------------------------------------------------------------------------------
(
	
global Mass_RAND
try(destroyDialog Mass_RAND )catch()

local LastSubRollout = 1

rollout randomR "Rotation Randomizer"
(
		checkbox rotgroupchkb "Group As One Object" checked:true
	
        group "X Rotation"
		(
        spinner x1 "Min:" range: [-360, 360, rotMinX] type:#float across:2
        spinner x2 "Max:" range: [-360, 360, rotMaxX] type:#float
		)
		group "Y Rotation"
		( 
		spinner y1 "Min:" range: [-360, 360, rotMinY] type:#float across:2
        spinner y2 "Max:" range: [-360, 360, rotMaxY] type:#float
		)			
		group "Z Rotation"        
		(
		spinner z1 "Min:" range: [-360, 360, rotMinZ] type:#float across:2
        spinner z2 "Max:" range: [-360, 360, rotMaxZ] type:#float
		)
		button rndR "Randomize Rotations"
		checkbox IfLocalRot "Local Coordinate System" checked:true
		
on x1 changed value do
(
	rotMinX=x1.value
)
	on x2 changed value do
(
	rotMaxX=x2.value
)
	on y1 changed value do
(
	rotMinY=y1.value
)	
on y2 changed value do
(
	rotMaxY=y2.value
)
on z1 changed value do
(
	rotMinZ=z1.value
)
on z2 changed value do
(
	rotMaxZ=z2.value
)
        on rndR pressed do
        (
        if selection.count > 0 then
        (
            randomizeR x1.value x2.value y1.value y2.value z1.value z2.value iflocalRot.state rotgroupchkb.state
        )
        else (messagebox "select at least one object")
        )
)
rollout randomP "Position Randomizer"
(
		checkbox Posgroupchkb "Group As One Object" checked:true
	
        group "X Position"
		(
        spinner xp1 "Min:" range: [-9999,9999, posMinX] type:#float across:2
        spinner xp2 "Max:" range: [-9999, 9999, posMaxX] type:#float
		)
		group "Y Position"
		( 
		spinner yp1 "Min:" range: [-9999, 9999, posMinY] type:#float across:2
        spinner yp2 "Max:" range: [-9999, 9999, posMaxY] type:#float
		)			
		group "Z Position"        
		(
		spinner zp1 "Min:" range: [-9999, 9999, posMinZ] type:#float across:2
        spinner zp2 "Max:" range: [-9999, 9999, posMaxZ] type:#float
		)
		button rndP "Randomize Positions"
		checkbox iflocalPos "Local Coordinate System" checked:true

on xp1 changed value do
(
	posMinX=xp1.value
)
	on xp2 changed value do
(
	posMaxX=xp2.value
)
	on yp1 changed value do
(
	posMinY=yp1.value
)	
on yp2 changed value do
(
	posMaxY=yp2.value
)
on zp1 changed value do
(
	posMinZ=zp1.value
)
on zp2 changed value do
(
	posMaxZ=zp2.value
)
        on rndP pressed do
        (
        if selection.count > 0 then
        (
            randomizeP xp1.value xp2.value yp1.value yp2.value zp1.value zp2.value iflocalPos.state Posgroupchkb.state
        )
        else (messagebox "select at least one object")
        )
)
rollout randomS "Scale Randomizer"
(
		checkbox Scalegroupchkb "Group As One Object" checked:true
	
		group "X Scale"
		(
		spinner x1 "Min:" range: [-1000, 1000, scaMinX] type:#float across:2
        spinner x2 "Max:" range: [-1000, 1000, scaMaxX] type:#float
		)
		group "Y Scale"
		(
		spinner y1 "Min:" range: [-1000, 1000, scaMinY] type:#float across:2
        spinner y2 "Max:" range: [-1000, 1000, scaMaxY] type:#float
		)
		group "Z Scale"
		(
		spinner z1 "Min:" range: [-1000, 1000, scaMinZ] type:#float across:2
        spinner z2 "Max:" range: [-1000, 1000, scaMaxZ] type:#float
		)
		checkbox propor "Proportional"
		
		on x1 changed value do
		(
			scaMinX=x1.value
		)
			on x2 changed value do
		(
			scaMaxX=x2.value
		)
			on y1 changed value do
		(
			scaMinY=y1.value
		)	
		on y2 changed value do
		(
			scaMaxY=y2.value
		)
		on z1 changed value do
		(
			scaMinZ=z1.value
		)
		on z2 changed value do
		(
			scaMaxZ=z2.value
		)
		
		
			on propor changed state do
			(
				if propor.state == true then
				(
				y1.enabled = false
				y2.enabled = false
				z1.enabled = false
				z2.enabled = false
				)  
				else 
				(
				y1.enabled = true
				y2.enabled = true
				z1.enabled = true
				z2.enabled = true
				)
			)
		
		button rndS "Randomize Scale"
			on rndS pressed do
			if selection.count > 0 then
			(
				randomizeS x1.value x2.value y1.value y2.value z1.value z2.value propor Scalegroupchkb.state
			)
			else (messagebox "select at least one object")
)
rollout rndparam "Parameters Randomizer"
(	
			group "Length"
			(
			spinner Length1 "Min:" range: [-1000, 1000, 50] type:#float across:2
			spinner Length2 "Max:" range: [-1000, 1000, 150] type:#float
			)
			group "Width"
			(
			spinner Width1 "Min:" range: [-1000, 1000, 50] type:#float across:2
			spinner Width2 "Max:" range: [-1000, 1000, 150] type:#float
			)
			group "Heigth"
			(
			spinner Height1 "Min:" range: [-1000, 1000, 50] type:#float across:2
			spinner Height2 "Max:" range: [-1000, 1000, 150] type:#float
			)
			group "Radius"
			(
			spinner Radius1 "Min:" range: [-1000, 1000, 50] type:#float across:2
			spinner Radius2 "Max:" range: [-1000, 1000, 150] type:#float
			)
			
			button rndParams "Random Parameters" tooltip:"Assigns random valuee to the length, width, height and radius parameters (if there is any) of selected objects"
			on rndParams pressed do
						(
							if selection.count > 0 then
								(
								randomParamL Length1.value Length2.value
									randomParamW Width1.value Width2.value
									randomParamH Height1.value Height2.value
									randomParamR Radius1.value Radius2.value
								)
							else (messagebox "select at least one object")
						)



)	
rollout OBJID "Object ID Randomizer" rolledup:false
(
			group "Assign"
			(
			button r_ID "Randomize ID's"  tooltip:"Assigns random ID's to selected objects"
			)
			on r_ID pressed do
			(
			if selection.count > 0 then
			(
			rndID ()
			)
			else (messagebox "select at least one object")
			)
)
rollout MATID "Material ID Randomizer" rolledup:false
(
			group "Assign"
			(
			button r_matID "Randomize Mat ID's"  tooltip:"Assigns random Material ID's to selected objects"
			spinner maxMatID "Total Material ID's: " range: [1, 1000, 10] type:#integer fieldwidth: 40 align:#right
			)
			on r_matID pressed do
			(
			if selection.count > 0 then
			(
			randommatmod maxMatID.value
			)
			else (messagebox "select at least one object")
			)
)
rollout randomUV "UV offset Randomizer"
(
        group "U value"
		(
        spinner u1 "Min:" range: [-100, 100, -1] type:#float across:2
        spinner u2 "Max:" range: [-100, 100, 1] type:#float
		)
		group "V value"
		( 
		spinner v1 "Min:" range: [-100, 100, -1] type:#float across:2
        spinner v2 "Max:" range: [-100, 100, 1] type:#float
		)			
		group "Rotation"        
		(
		spinner r1 "Min:" range: [-360, 360, -360] type:#float across:2
        spinner r2 "Max:" range: [-360, 360, 360] type:#float
		)
		groupbox group4 "Channel" offset:[-10,0]  width:180 height:50

		radiobuttons chan labels:#("Map Channel:", "Vertex Color Channel") align:#left offset:[0,-40]
		spinner Mapchan range:[1,9999,1] type:#integer fieldwidth:35 offset:[-25,-35]
		
		
		button rndUV "Randomize UV Offset" tooltip: "Assigns a randomly tiled and rotated UVW Xform modifier to each selected object." offset:[0,20]

        on rndUV pressed do
        (
        if selection.count > 0 then
        (
            rndUVW u1.value u2.value v1.value v2.value r1.value r2.value (chan.state-1) Mapchan.value
        )
        else (messagebox "select at least one object")
        )
)
rollout SelectionAPR "Selection Randomizer"
(
	checkbox  groupchkb "Group As One Object" checked:true
	spinner apr "Select %" type:#float range:[0,100,50] fieldwidth:30 offset:[-85,0]
	label l1 "of current selection" offset:[42,-20]
	button selapr "Randomize Selection"
	label spac ""
	label def1 "Works with objects and sub-objects"
	label def2 "Select at least 2 objects" align:#center
	label def3 "or 2 sub-objects" align:#center

	on selapr pressed do 
	(
		sel_array=#()
		new_sel_array=#()
		count=undefined
	(
			if subobjectLevel == 1 do
			(
				selectrandomVerts apr.value
			)
			if subobjectLevel == 2 do
			(
				selectrandomEdges apr.value
			)
			if subobjectLevel == 3 do
			(
				selectrandomEdges apr.value
			)
			if subobjectLevel == 4 do
			(	
				selectrandomFaces apr.value
			)
			
			if subobjectLevel == 5 do
			(	
				selectrandomElements apr.value
			)
			if subobjectLevel == undefined or subobjectLevel==0 do
			(
				selectRandom apr.value groupchkb.state
			)
			
	)
	)
)
rollout randomColors "Material & Color Randomizer"
(

	group "Color Randomization" 
	(
	checkbox rmv_material "Remove Materials" align:#center offset:[0,-1]
	button rndwires "Randomize Wirecolors" align:#center offset:[0,-1]
	)
	group "Material Randomization"
	(
	checkbutton multi_mat "<<Assign Multi Material>>" width:160 offset:[0,-1]
	button rndmaterials "Randomize Materials" tooltip:"Assigns sub-materials of the assigned multi-material to the selection randomly" offset:[0,-1]
	)
			group "Material ID Randomization"
			(
			button r_matID "Randomize Mat ID's"  tooltip:"Assigns random Material ID's to selected objects" offset:[0,-1]
			spinner maxMatID "Total Material ID's: " range: [1, 1000, 10] type:#integer fieldwidth: 40 align:#right offset:[0,-1]
			)
			on r_matID pressed do
			(
			if selection.count > 0 then
			(
			randommatmod maxMatID.value
			)
			else (messagebox "select at least one object")
			)

	on rndwires pressed do
	(
		rndwirecolor rmv_material.state
	)
	
		on multi_mat changed state do
	(
		
		if(state==true) then
		(
		MatEditor.Open()
		medit.setactivemtlslot 1 true
		if(MMaterial==undefined) then

		meditMaterials[1]=multimaterial()
		else
		meditMaterials[1]=MMaterial
		multi_mat.text="Click When Done"   
                   
		)
		else
		(
		MatEditor.close()
		if((classof meditMaterials[1]) == multimaterial) then
			(   
			MMaterial=meditMaterials[1]
			multi_mat.text=MMaterial.name  as string
			)
			else
			(
			multi_mat.text="Only Multi-Materials!!"
			)
		)
	)
	
	on rndmaterials pressed do
	(
		if Mmaterial != undefined then
		rndmaterial Mmaterial.numsubs
		else
		messagebox "Assign a Multi-Material first"
	)
	
)
rollout abou "About" 
(
	label script "Tik Randomizer 2.0.1"
	label author "Arda Kutlu"
	label web "ardakutlu@gmail.com"
	hyperlink hl "www.ardakutlu.com" address:"www.ardakutlu.com" align:#center
	label author2 "Updated By Simon Bourgeois" 
	label web2 "Simon.bourgeois@free.fr"
	hyperlink hl2 "Portfolio" address:"https://simonbourgeois6.wixsite.com/monsite" align:#center
	hyperlink hl3 "Artstation" address:"https://www.artstation.com/simon_bourgeois" align:#center
)
				
				
-----------------------------------------------------------------
				
Tabs_Rollouts = #(
#("Rotation Randomizer",#(randomR)),
#("Position Randomizer",#(randomP)),
#("Scale Randomizer",#(randomS)),
#("Parameters Randomizer",#(rndparam)),
#("Object ID Randomizer",#(OBJID)),
#("Material ID Randomizer",#(MATID)),
#("UV offset Randomizer",#(randomUV)),
#("Selection Randomizer",#(SelectionAPR)),
#("Material & Color Randomizer",#(randomColors)),
#("About",#(abou))
)


-----------------------------------------------------------------

rollout Mass_RAND ""
(
dropdownlist dn_tabs "" height:20 width:190 align:#center
subRollout theSubRollout width:200 height:280 align:#center

on dn_tabs Selected itm do

(
for subroll in Tabs_Rollouts[LastSubRollout][2] do
removeSubRollout theSubRollout subroll
for subroll in Tabs_Rollouts[LastSubRollout = dn_tabs.selection][2] do
addSubRollout theSubRollout subroll
)--end tabs clicked


-------------------------------------------
on Mass_RAND open do
(
local hodo = #()
for aTab in Tabs_Rollouts do
(
append hodo aTab[1]
)
dn_tabs.items = hodo


for subroll in Tabs_Rollouts[1][2] do
addSubRollout theSubRollout subroll

)

------------------------------------------------
)
createdialog Mass_RAND 200 290
)
)