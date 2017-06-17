/* 
macroScript TIK_Flipper_Mech
category: "Tik Works"
tooltip: "Flipper Mechanism"
ButtonText: "Flipper Mechanism" 
*/

(
local plates_array=#()
local characters_list=#()
local sorted_count_list = #()
local temp_plate
local MasCtrl
local uvm
local plate_width
local plate_length
local plate_gap
local ext
local empt
local frms_gonnabekeyed
local pmaterial
local cmaterial
local savePath
local renderSize_W
local renderSize_H
local preset_Alphabet = #("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z")
local preset_Days = #("Mon","Tue","Wed","Thu","Fri","Sat","Sun")
local preset_Alphabet_W_num = #("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0")
local preset_Numbers= #("1","2","3","4","5","6","7","8","9","0")
local presets=#(preset_Alphabet,preset_Days,preset_Alphabet_W_num,preset_Numbers)
	
fn rendertexture characters_list savePath font renderSize_W renderSize_H=
(
	(
	sorted_count_list = #()
	for i = 1 to characters_list.count do append sorted_count_list characters_list[i].count
	camera_distance = amax sorted_count_list
	largest_character = finditem sorted_count_list camera_distance
	select $*
	max hide selection
	try useEnvironmentMap = false catch() --setting for render
	backgroundColor = black    --setting for render
	(
		text_material = standardmaterial()
		text_material.diffuse = white
		text_material.selfIllumAmount = 100
	) -- material for textures
	textCam = freecamera () --create temporary camera to render textures
	textCam.pos = [0,0,camera_distance*2]

	text_ext=extrude amount:0.01   --modifier to make the texts renderable and extruded
	current_text=text text:characters_list[1] size:100 font:font
	centerPivot current_text
	current_text.pos = [0,0,0]
	addmodifier current_text text_ext
	current_text.material = text_material
	kadraj = copy current_text
	kadraj.text = characters_list[largest_character]
	select kadraj
	
	--------------------------------------------------------------------
	(
	local max2, fov, asp, v 
	fn maxof vals = (local v=vals[1]; for v1 in vals do (if v1 > v do v=v1);v)
	fov=0 
	asp=(renderWidth as float)/renderHeight -- calculate the renderer's image aspect ratio
	in coordsys textcam -- work in coordinate system of the camera
	(
	for obj in kadraj where obj != textcam do -- loop across all objects except the camera
	(
	if obj.min.z >=0 do continue -- if object is behind camera, skip it
	v = maxof #((abs obj.max.x),(abs obj.min.x),(abs (obj.max.y*asp)),(abs (obj.min.y*asp)))
	fov = maxof #(fov,(2*atan(-v/obj.min.z)))+1 --(camera_distance-1) -- increase fov if needed
	)
	)
	textcam.fov=fov -- set the camera's fov to the new fov value
	)
	---------------------------------------------------------------------
	delete kadraj
	for c = 0 to (characters_list.count-1) do

		(
		current_text.text = characters_list[c+1]
	   
		bm = render camera:textcam outputwidth:renderSize_W outputheight:renderSize_H frame:c outputfile:((substring savePath 1 (savePath.count-4))+(formattedPrint c format:".2d")+(substring savePath (savePath.count-3) (savePath.count))) vfb:false --renders the texture
		)           
	   
	delete current_text
	delete textCam
	try useEnvironmentMap = true catch()
	max unhide all
	)
)

--------------------------------------------------------------------------------------------------------------------------------------------------------------



function createplate characters_list plate_length plate_width plate_height Pl_gapsp texture_size pmaterial cmaterial savePath=
(
plates_array=#()
padding = 5
total = (characters_list.count)*padding
angl = (180/(characters_list.count-1))
plate_corner = 1
plate_gap = ((plate_length as float) / 2 ) + Pl_gapsp

temp_plate = rectangle length:plate_length width:plate_width cornerRadius:plate_corner transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,(plate_gap)])
temp_plate.pivot = [0,0,0]

ext = shell outeramount:(plate_height/2) inneramount:(plate_height/2) overrideOuterMatID:on overrideInnerMatID:on overrideEdgeMatID:on \
     matInnerID:2 matOuterID:1 matEdgeID:3
uvm = (Uvwmap ())
uvm.width = texture_size
uvm.length = texture_size
--addmodifier temp_plate ext
--addmodifier temp_plate uvm
resettransform temp_plate

frms_gonnabekeyed = #()
for i = (padding*3) to total by padding do
(append frms_gonnabekeyed i)

    with animate on -- animating first 4 keyframes of the single plate
    (
    at time padding rotate temp_plate (eulerangles -180 0 0)
    at time ((padding*2)-1) temp_plate.rotation = (eulerangles -180 0 0)
    at time (padding*2) rotate temp_plate (eulerangles angl 0 0)
    at time ((padding*2)+1) rotate temp_plate (eulerangles angl 0 0)
    )
   
(
	for a = 1 to frms_gonnabekeyed.count do
	(
	
	ef = at time (frms_gonnabekeyed[a] - (padding-1)) temp_plate.rotation as eulerangles
	with animate on
		(
		at time (frms_gonnabekeyed[a]) temp_plate.rotation = (ef)
		if frms_gonnabekeyed[a] != total then
		at time (frms_gonnabekeyed[a]+1) temp_plate.rotation = (eulerangles (ef.x-angl) 0 0)
		else
			(
			at time (frms_gonnabekeyed[a]) temp_plate.rotation = (eulerangles 0 0 0)
			at time (frms_gonnabekeyed[a]-(padding-1)) temp_plate.rotation = (eulerangles 0 0 0)
			)
		)
	)
)

setbeforeort temp_plate.controller.rotation.controller #relativeRepeat
setafterort temp_plate.controller.rotation.controller #relativeRepeat	
---------------------------------------------------------------------------------------------
MasCtrl = point pos:[0,0,0] box:on size:50
MasCtrl.name = "Master_Control"
empt = EmptyModifier ()
addmodifier MasCtrl empt

for x =0 to (characters_list.count-1) do
(
    y = x+1
    if y>(characters_list.count-1) do y=0
    td_mat = multimaterial numsubs:3
    td_mat_front = blend ()
	td_mat_front.interactive = 2
    td_mat_front.map1 = copy pmaterial
    td_mat_front.map2 = copy cmaterial
    td_mat_front.mask = Bitmaptexture fileName:((substring savePath 1 (savePath.count-4))+(formattedPrint x format:".2d")+(substring savePath (savePath.count-3) (savePath.count)))
	showTextureMap td_mat_front td_mat_front.mask on
      td_mat_front.mask.coords.U_Tile = false
      td_mat_front.mask.coords.V_Tile = false
	td_mat_front.mask.coords.realWorldScale = off
    td_mat_back = blend ()
	td_mat_back.interactive = 2
    td_mat_back.map1 = copy pmaterial
    td_mat_back.map2 = copy cmaterial
    td_mat_back.mask = Bitmaptexture fileName:((substring savePath 1 (savePath.count-4))+(formattedPrint y format:".2d")+(substring savePath (savePath.count-3) (savePath.count)))
	showTextureMap td_mat_back td_mat_back.mask on
      td_mat_back.mask.coords.U_Tile = false
      td_mat_back.mask.coords.V_Tile = false
	td_mat_back.mask.coords.realWorldScale = off
    td_mat_back.mask.coords.V_Tiling = -1
    td_mat_back.mask.coords.U_Tile = false
    td_mat_back.mask.coords.V_Tile = false
    td_mat_edge = copy pmaterial
    td_mat[1] = td_mat_front
    td_mat[2] = td_mat_back
    td_mat[3] = td_mat_edge

    a = copy temp_plate
	addmodifier a ext
	addmodifier a uvm
    a.parent = MasCtrl
    a.name = uniquename "plate"
    a.material = td_mat
    append plates_array a
    movekeys a (x*padding)
)

uvm.gizmo.position= [0,-(plate_gap),0]
delete temp_plate

ca=attributes FlipControl
(
    parameters Flip rollout:FlipR
    (
        Flip type:#float ui:(Flipsp,Flipsl)
       
    )
    rollout FlipR "Flip"
    (
        local fW = 40, oS = [0,-23]
        spinner Flipsp  "" type:#float range: [-9999,9999,0] fieldwidth:fW
        slider Flipsl "Flip" type:#float range: [-100,100,0] offset: oS
    )
	    parameters Trans rollout:SizeR
    (
        Size type:#float ui:(Sizesp,Sizesl)
    )
    rollout SizeR "Transform"
    (
        local fW = 40, oS = [0,-23]
        spinner Sizesp  "" type:#float range: [-9999,9999,42] fieldwidth:fW
        slider Sizesl "Texture Size" type:#float range: [-100,100,42] offset: oS
    )
)

custAttributes.add MasCtrl.modifiers[1] ca

Flip_exp = Bezier_Float ()
--Flip_exp = Float_Expression ()
MasCtrl.modifiers[1].FlipControl.flip.controller = Bezier_Float ()
Flip_exp_value = "master_flip * 800"

for i = 1 to plates_array.count do
(
	

addeasecurve plates_array[i].rotation.x_rotation.controller Flip_exp

paramWire.connect MasCtrl.modifiers[1].FlipControl[#flip] plates_array[i].rotation.controller.X_Rotation.controller[#Ease_Curve] "radtodeg flip *14"
	
/*
addeasecurve plates_array[i].rotation.x_rotation.controller Flip_exp
plates_array[i].rotation.controller.X_Rotation.controller.Ease_Curve.controller.addscalartarget "master_flip" MasCtrl.modifiers[1].FlipControl.flip.controller
plates_array[i].rotation.controller.X_Rotation.controller.Ease_Curve.controller.SetExpression Flip_exp_value
*/
)

trans_exp = Float_Expression ()
MasCtrl.modifiers[1].FlipControl.size.controller = Bezier_Float ()
trans_exp_value = "sizer+"+texture_size as string
uvm.length.controller = trans_exp
uvm.length.controller.addscalartarget "sizer" MasCtrl.modifiers[1].FlipControl.size.controller
uvm.length.controller.SetExpression trans_exp_value
uvm.width.controller = trans_exp
)

-----------------------------------------UI------------------------------------------------------


rollout Flip "Flipper"
(

edittext Nchar "Enter Character" fieldWidth:100 labelOnTop:true enabled:true

listbox Char_List "List of Characters" items:characters_list Width:100 Height:10 labelOnTop:true

Spinner Pl_lengthsp "Plate Length" fieldwidth:35 type:#float range:[-999,999,17] offset:[0,-180]
Spinner Pl_widthtsp "Plate Width" fieldwidth:35 type:#float range:[-999,999,24] offset:[0,1] 
Spinner Pl_heightsp "Plate Height" fieldwidth:35 type:#float range:[-999,999,0.01] offset:[0,1]
Spinner Pl_gapsp "Plate Gap" fieldwidth:35 type:#float range:[-999.0,999.0,0.3] offset:[0,1] 
Spinner Tx_size "Texture Scale" fieldwidth:35 type:#float range:[-999,999,30] offset:[0,1] 
groupBox tx_rnd_size "Texture Render Size" width:115 height:65 offset:[115,0]	

	
	spinner Rend_S_width "Width" fieldwidth:35 type:#integer range:[1,99999,500] offset:[0,-50]
	spinner Rend_S_height "Height" fieldwidth:35 type:#integer range:[1,99999,500] offset:[0,0]
	
checkbutton pl_mat "Assign Base Material" width:110 height:24 offset:[0,20] across:2
checkbutton ch_mat "Assign Char. Material" width:110 height:24 offset:[4,20]
Button sp "Texture Path and Filename" width:225 offset:[0,5]
Dropdownlist presets_dd "Preset Character Sets" items:#("Select a Preset","Alphabet A...Z","Days of Week","Alphabet with Numbers","Numbers") enabled:true
Dropdownlist font_dd "Font" items:#("Arial","Arial Black","Arial Bold","Arial Bold Italic","Arial Italic","Calibri","Calibri Bold","Calibri Bold Italic","Calibri Italic","Cambria","Cambria Bold","Cambria Bold Italic","Cambria Italic","Candara","Candara Bold","Candara Bold Italic","Candara Italic","Comic Sans MS","Comic Sans MS Bold","Consolas","Consolas Bold","Consolas Bold Italic","Consolas Italic","Constantia","Constantia Bold","Constantia Bold Italic","Constantia Italic","Corbel","Corbel Bold","Corbel Bold Italic","Corbel Italic","Courier New","Courier New Bold","Courier New Bold Italic","Courier New Italic","Franklin Gothic Medium","Franklin Gothic Medium Italic","Georgia","Georgia Bold","Georgia Bold Italic","Georgia Italic","Impact","Lucida Console","Lucida Sans Unicode","Microsoft Sans Serif","Palatino Linotype","Palatino Linotype Bold","Palatino Linotype Bold Italic","Palatino Linotype Italic","Sylfaen","Symbol","Tahoma","Tahoma Bold","Times New Roman","Times New Roman Bold","Times New Roman Bold Italic","Times New Roman Italic","Trebuchet MS","Trebuchet MS Bold","Trebuchet MS Bold Italic","Trebuchet MS Italic","Verdana","Verdana Bold","Verdana Bold Italic","Verdana Italic","Webdings","Wingdings")
Button bord "Reset Character List"  width:108 across:2
Button Goo "Create Flipper" width:108 
Button Help "Help" width:60 offset:[-24,10] across:2
Button Abou "About" width:60 offset:[24,10]

	on sp pressed do
	(
		savePath = getBitmapSaveFileName ()
		print savePath
	)

    on presets_dd selected i do
    (
    if presets_dd.selection == 1 do ()
    if presets_dd.selection == 2 do characters_list=preset_Alphabet
    if presets_dd.selection == 3 do characters_list=preset_Days
    if presets_dd.selection == 4 do characters_list=preset_Alphabet_W_num
    if presets_dd.selection == 5 do characters_list=preset_Numbers
    Char_List.items = characters_list
    )
   
    on Nchar entered txt do
    (
    if txt != "" do
        (
        append characters_list txt
        Char_List.items = characters_list
        Nchar.text = ""
        )
    )
       
    on Char_List doubleClicked num do
    (
    deleteItem characters_list num
    Char_List.items = characters_list
    print characters_list
    )
   
    on bord pressed do
    (
    presets_dd.selection = 1
    characters_list =#()
    Char_List.items = characters_list
    )
   
                on pl_mat changed state do
            (
						if state == on then
						(
							ch_mat.enabled = false
						)
						else
						(
							ch_mat.enabled =true
						)
                if(state==true) then
                (
                    MatEditor.Open()
                    medit.setactivemtlslot 1 true
                    if(pMaterial==undefined) then
                        meditMaterials[1]=standardMaterial()
                    else
                        meditMaterials[1]=pMaterial
                    pl_mat.text="Click When Done"   
                   
                )
                else
                (
                    MatEditor.close()
                    if((superclassof meditMaterials[1]) == material) then
                    (   
                        pMaterial=meditMaterials[1]
                        pl_mat.text=pMaterial.name + " ( " +((classof pMaterial) as string) +" )"
                    )
                    else
                    (
                        pl_mat.text="Only Materials!!"
                    )
                )
               
            )
           
                on ch_mat changed state do
            (
						if state == on then
						(
							pl_mat.enabled = false
						)
						else
						(
							pl_mat.enabled =true
						)
                if(state==true) then
                (
                    MatEditor.Open()
                    medit.setactivemtlslot 1 true
                    if(cMaterial==undefined) then
                        meditMaterials[1]=standardMaterial()
                    else
                        meditMaterials[1]=cMaterial
                    ch_mat.text="Click When Done"   
                   
                )
                else
                (
                    MatEditor.close()
                    if((superclassof meditMaterials[1]) == material) then
                    (   
                        cMaterial=meditMaterials[1]
                        ch_mat.text=cMaterial.name + " ( " +((classof cMaterial) as string) +" )"
                    )
                    else
                    (
                        ch_mat.text="Only Materials!!"
                    )
                )
               
            )
   on help pressed do
   (
	   messagebox "
	Flipper Mechanism Script v0.96b
	   
Usage:
- Click \"Assign Base Material\". Prepare first material of material 
editor as you wish, or drag drop existing maps into first slot.
Click the same button when done.
	   
- Do the same thing to assign a material for characters on the plate
by clicking \"Assign Character Material\"
	   
- Either select a presetted set of characters or create your own by
entering manually.
	
You can also enter new characters to the presets or delete some by
double clicking them
	   
- Select a font. Arial is the default one.
	   
- Adjust \"Plate Length\", \"Plate Width\", \"Plate Height\", \"Plate Gap\" and 
\"Texture Size\" values if you need.
	   
You can change texture size after the creation from the modifier panel
of \"Master Controller\" as well. All objects are instanced, meaning 
changing each objects modifier values will change other objects as well.
	   
- Hit \"Create Flipper\"
- Script will ask you to specify a folder to hold the texture maps select one.

WARNING!
Texture images created by this script will be overwritten, if you
specify the same location twice
	   
- You can flip the plates from \"Master Control\" by animating flip value
	   
	   "
   )
   
   on abou pressed do
   (
	   messagebox"
Flipper Mechanism Script v0.96b
	   
Created by Arda Kutlu
	   
Special thanks to Lukas Lepicovsky for sharing
his piece of code which was used in ui-material editor
connection
	   
Tik Works 2008
	   
ardakutlu@gmail.com
	   
http://www.ardakutlu.com/
	   "
   )
   
    on Goo pressed do
    (
		
		if (characters_list.count >= 3) and pmaterial !=undefined and cmaterial !=undefined and savePath != undefined then 
		(
		rendertexture characters_list savePath font_dd.selected Rend_S_width.value Rend_S_height.value
		createplate characters_list Pl_lengthsp.value Pl_widthtsp.value Pl_heightsp.value Pl_gapsp.value Tx_size.value pmaterial cmaterial savePath
		)
		else
		(
			if pmaterial == undefined do
			(
			messagebox  "Please assign a material for the base of plates"
			)
			if characters_list.count <= 3 do
			(
			messagebox  "Character count must be greater than 3"
			)
			if cmaterial == undefined do
			(
			messagebox  "Please assign a material for characters on plates"
			)
			if savePath == undefined do
			(
			messagebox  "You must specify the location where the textures will be hold"
			)
		)
			
	)
)


createDialog Flip 250 425
)