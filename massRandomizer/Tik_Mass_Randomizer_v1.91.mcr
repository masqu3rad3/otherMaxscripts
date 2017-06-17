macroScript randomize
category: "Tik Works"
toolTip: "Mass Randomizer"
buttonText: "Mass Randomizer"


(
	local MMaterial
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---FUNCTIONS------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fn randomizeR xa xb ya yb za zb= --function for random Rotation 
(
	undo on
	for i in selection do
	(
	in coordsys local i.rotation  = eulerangles  (random xa xb)  (random ya yb) (random za zb)
	)
)

fn randomizeP xpa xpb ypa ypb zpa zpb= --function for random Position
(
	undo on
	for i in selection do
	(
	in coordsys local  i.pos =  [(random xpa xpb),  (random ypa ypb), (random zpa zpb)]
	)
)


fn randomizeS xmin xmax ymin ymax zmin zmax prop= --function for random Scale
(
		undo on
		for i in selection do
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
)--end of Rotation Function



fn rndID = --function for random G-Buffer ID
	(
	undo on
	for i in 1 to selection.count do selection[i].gbufferchannel = i
	messagebox "G-Buffer ID's are randomized"
	)			
	
fn randomParamL lmin lmax= --function for random Length
	(
		undo on
		for i in selection do
		(
				try i.length = (random lmin lmax) 
			catch ()
		)
	)
	
fn randomParamW wmin wmax= --function for random Width
	(
		undo on
		for i in selection do
		(
				try i.width = (random wmin wmax) 
			catch ()
		)
	)--End of G-Buffer
	
fn randomParamH hmin hmax= --function for random Height
	(
		undo on
		for i in selection do
		(
				try i.height = (random hmin hmax) 
			catch ()
		)
	)--End of Height Function
	
fn randomParamR rmin rmax= --function for random Radius 
	(
		undo on
		for i in selection do
		(
				try i.radius = (random rmin rmax) 
			catch ()
				try i.radius1 = (random rmin rmax) 
			catch ()
				try i.radius2 = (random rmin rmax) 
			catch ()
		)
	)--End of


fn rndUVW Uoffmin Uoffmax Voffmin Voffmax Rotoffmin Rotoffmax MAPchannel= --function for random UV offsets
	undo on
for i in selection do 
(
	rndU=random Uoffmin Uoffmax --random U value
	rndV=random Voffmin Voffmax --random V value
	rndR=random Rotoffmin Rotoffmax -- random Rotation Value
	if i.modifiers[#UVW_Xform] != undefined then -- looks if the object has or has not the xform modifier
	(
		if i.modifiers[#UVW_Xform].Map_Channel==MAPchannel then
		(
		i.modifiers[#UVW_Xform].u_offset = rndU
		i.modifiers[#UVW_Xform].v_offset = rndV
		i.modifiers[#UVW_Xform].Rotation_Center = 1
		i.modifiers[#UVW_Xform].Rotation_Angle = rndR
		)
			else
		(
		b = uvw_Xform ()
		b.u_offset = rndU
		b.v_offset = rndV
		b.Rotation_Center = 1
		b.Rotation_Angle = rndR
		b.Map_Channel=MAPchannel
		addModifier i b
		)
	)
	else
	(
		b = uvw_Xform ()
		b.u_offset = rndU
		b.v_offset = rndV
		b.Rotation_Center = 1
		b.Rotation_Angle = rndR
		b.Map_Channel=MAPchannel
		addModifier i b
	)
)--end of random UV offsets

	
fn selectrandomVerts apr = 
	undo on
(
	if classof (modpanel.getCurrentObject ()) != (Edit_Mesh) then 
	(
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) then 
	(
current_modifier = ( try(modpanel.getModifierIndex $ (modpanel.getCurrentObject()))catch(0) )
		count = #()
		count = $.modifiers[current_modifier].getSelection #currentlevel  --polyop.getVertSelection $
		sel_array = #{}
		for i in count do
		(
			a=random 1 apr
			if a == 1 then append sel_array i
		)
		$.modifiers[current_modifier].setselection #currentlevel #{}
		$.modifiers[current_modifier].select #currentlevel sel_array
	)
	else 
	(
		count = getvertSelection $
		sel_array = #()
		for i in count do
		(
			a=random 1 apr
			if a == 1 then append sel_array i
		)
		try (polyop.setvertselection $ sel_array) catch (setvertselection $ sel_array)
	)
)
else (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier")
)--end of random verts
------------------------------------------------------------------------------------------------------------------------------------
fn selectrandomFaces apr = 
	undo on
(
	if classof (modpanel.getCurrentObject ()) != (Edit_Mesh) then 
	(
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) then 
	(
current_modifier = ( try(modpanel.getModifierIndex $ (modpanel.getCurrentObject()))catch(0) )
		count = #()
		count = $.modifiers[current_modifier].getSelection #currentlevel  --polyop.getVertSelection $
		sel_array = #{}
		for i in count do
		(
			a=random 1 apr
			if a == 1 then append sel_array i
		)
		$.modifiers[current_modifier].setselection #currentlevel #{}
		$.modifiers[current_modifier].select #currentlevel sel_array
	)
	else 
	(
		count = getfaceSelection $
		sel_array = #()
		for i in count do
		(
			a=random 1 apr
			if a == 1 then append sel_array i
		)
		try (setfaceselection $ sel_array) catch (setfaceselection $ sel_array)
	)
)
else (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier")
)--end of random faces
------------------------------------------------------------------------------------------------------------------------------------
fn selectrandomEdges apr = 
	undo on
(
	if classof (modpanel.getCurrentObject ()) != (Edit_Mesh) then 
	(
	if  classof (modpanel.getCurrentObject ()) == (Edit_Poly) then 
	(
current_modifier = ( try(modpanel.getModifierIndex $ (modpanel.getCurrentObject()))catch(0) )
		count = #()

		count = $.modifiers[current_modifier].getSelection #currentlevel
		sel_array = #{}
		for i in count do
		(
			a=random 1 apr
			if a == 1 then append sel_array i
		)
		$.modifiers[current_modifier].setselection #currentlevel #{}
		$.modifiers[current_modifier].select #currentlevel sel_array

	)
	else 
	(
		count = #()
		count = getedgeSelection $

		sel_array = #()
		for i in count do
		(
			a=random 1 apr
			if a == 1 then append sel_array i
		)
		try (setedgeselection $ sel_array) catch (setedgeselection $ sel_array)
	)
)
else (messagebox "Selection Randomizer currently cannot work with Edit_Mesh Modifier")
)--end of random edges

------------------------------------------------------------------------------------------------------------------------------------

fn selectRandom apr =
	undo on
(
		if selection.count >=2 then
(
	fodobog = #()

for i in selection do 
(
a = random 1 apr
if a == 1 then append fodobog i
)
select fodobog
)
else
(messagebox "Select at least 2 object, 2 edges, 2 vertices or two faces")
)--end of random objects

------------------------------------------------------------------------------------------------------------------------------------

function randommatmod matcount = 
undo on
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
)--end of random material ID function

----------------------------------------------------------------------------------
fn rndwirecolor rmv_material =
	undo on
(
	if rmv_material == true do
	($.material = undefined)
	for i in selection do i.wirecolor = color (random 0 255) (random 0 255) (random 0 255)
)--end of random wirecolor
----------------------------------------------------------------------------------

fn rndmaterial Material_count= 
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
        group "X Rotation"
		(
        spinner x1 "Min:" range: [-360, 360, -360] type:#float across:2
        spinner x2 "Max:" range: [-360, 360, 360] type:#float
		)
		group "Y Rotation"
		( 
		spinner y1 "Min:" range: [-360, 360, -360] type:#float across:2
        spinner y2 "Max:" range: [-360, 360, 360] type:#float
		)			
		group "Z Rotation"        
		(
		spinner z1 "Min:" range: [-360, 360, -360] type:#float across:2
        spinner z2 "Max:" range: [-360, 360, 360] type:#float
		)
		button rndR "Randomize Rotations"

        on rndR pressed do
        (
        if selection.count > 0 then
        (
            randomizeR x1.value x2.value y1.value y2.value z1.value z2.value
        )
        else (messagebox "select at least one object")
        )
)
rollout randomP "Position Randomizer"
(
        group "X Position"
		(
        spinner xp1 "Min:" range: [-9999,9999, 0] type:#float across:2
        spinner xp2 "Max:" range: [-9999, 9999, 0] type:#float
		)
		group "Y Position"
		( 
		spinner yp1 "Min:" range: [-9999, 9999, 0] type:#float across:2
        spinner yp2 "Max:" range: [-9999, 9999, 0] type:#float
		)			
		group "Z Position"        
		(
		spinner zp1 "Min:" range: [-9999, 9999, 0] type:#float across:2
        spinner zp2 "Max:" range: [-9999, 9999, 0] type:#float
		)
		button rndP "Randomize Positions"

        on rndP pressed do
        (
        if selection.count > 0 then
        (
            randomizeP xp1.value xp2.value yp1.value yp2.value zp1.value zp2.value
        )
        else (messagebox "select at least one object")
        )
)
rollout randomS "Scale Randomizer"
(
		group "X Scale"
		(
		spinner x1 "Min:" range: [-1000, 1000, 50] type:#float across:2
        spinner x2 "Max:" range: [-1000, 1000, 150] type:#float
		)
		group "Y Scale"
		(
		spinner y1 "Min:" range: [-1000, 1000, 50] type:#float across:2
        spinner y2 "Max:" range: [-1000, 1000, 150] type:#float
		)
		group "Z Scale"
		(
		spinner z1 "Min:" range: [-1000, 1000, 50] type:#float across:2
        spinner z2 "Max:" range: [-1000, 1000, 150] type:#float
		)
		checkbox propor "Proportional"
		
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
				randomizeS x1.value x2.value y1.value y2.value z1.value z2.value propor
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


rollout OID "Object ID Randomizer" rolledup:false
(

			button r_ID "Randomize ID's"  tooltip:"Assigns random ID's to selected objects"
	label l1 "Works only on selected objects"

			on r_ID pressed do
			(
			if selection.count > 0 then
			(
			rndID ()
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
		spinner mapChannelSP "Map Channel" range:[1,99999,1] type:#integer fieldwidth:30
		button rndUV "Randomize UV Offset" tooltip: "Assigns a randomly tiled and rotated UVW Xform modifier to each selected object."

        on rndUV pressed do
        (
        if selection.count > 0 then
        (
            rndUVW u1.value u2.value v1.value v2.value r1.value r2.value mapChannelSP.value
        )
        else (messagebox "select at least one object")
        )
)

rollout SelectionAPR "Selection Randomizer"
(
spinner apr "Select Approximately 1/" type:#integer range:[2,999,2] tooltip:"Sets the approximate percentage for random selection. 4 means it will select about 1/4 of current selection" fieldwidth:20
	button selapr "Randomize Selection" tooltip:"Randomly reselects the selection with given N value"
	label spac ""
	label def1 "Works with objects and sub-objects"
	label def2 "Select at least 2 objects" align:#center
	label def3 "or 2 sub-objects" align:#center

	on selapr pressed do 
	(
			if subobjectLevel == 3 do
			(
				selectrandomEdges apr.value
			)
			if subobjectLevel == 4 do
			(	
				selectrandomFaces apr.value
			)
			if subobjectLevel == 2 do
			(
				selectrandomEdges apr.value
			)
			if subobjectLevel == 1 do
			(
				selectrandomVerts apr.value
			)
			if subobjectLevel == 5 do
			(	
				selectrandomFaces apr.value
			)
			if subobjectLevel == 0 do
			(
				selectRandom apr.value
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
						label script "Tik Randomizer 1.9"
						label author "Arda Kutlu"
						label year "2008"
						label web "ardakutlu@gmail.com"
						hyperlink hl "www.ardakutlu.com" address:"www.ardakutlu.com" align:#center
                )
				
				
-----------------------------------------------------------------
				
Tabs_Rollouts = #(
#("Rotation Randomizer",#(randomR)),
#("Position Randomizer",#(randomP)),
#("Scale Randomizer",#(randomS)),
#("Parameters Randomizer",#(rndparam)),
#("Object ID Randomizer",#(OID)),
#("UV offset Randomizer",#(randomUV)),
#("Selection Randomizer",#(SelectionAPR)),
#("Material & Color Randomizer",#(randomColors)),
#("About",#(abou))
)


-----------------------------------------------------------------

rollout Mass_RAND ""
(
dropdownlist dn_tabs "" height:20 width:190 align:#center
subRollout theSubRollout width:200 height:250 align:#center

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
createdialog Mass_RAND 200 280
)
) 