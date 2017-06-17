/*
macroScript modifier_instancer
category: "Tik Works"
tooltip: "Modifier Instancer"
buttontext: "Modifier Instancer"
*/
(
global RO
global sourceOBJ

fn GetGeometry o =
(
o != sourceOBJ
)



	fn modinstancer sourceOBJ target_list selected_mods= 
	
		(
		
	
			mods = (selected_mods as array) --Number of modifiers of the picked obj

			for a=1 to target_list.count do --Loop for target objects
				(
				nextobj=maxOps.getNodeByHandle target_list[a]
				for i = mods.count to 1 by -1 do --Loop for modifiers
					(
					temp_mod = sourceOBJ.modifiers[mods[i]]
						if validmodifier nextobj temp_mod do
						(
						addmodifier nextobj temp_mod
						)
					)
				)
		)


--------------------------------------------------------
---------------ROLLOUTS----------------------------
---------------------------------------------------------
(
local mods = #()
local target_list = #()
local target_names_list = #()
local picked_mods = #()
local selected_mods = #()
local temp_mod = #()

for i in selection do 
(
	append target_list i.inode.handle
	append target_names_list i.name
)
/* append target_list obj[i].inode.handle
append target_names_list obj[i].name */
--local sourceOBJ
	
	
            if RO != undefined then (closeRolloutFloater RO)
              
            RO = NewRolloutFloater "Modifier Instancer" 200 400

rollout ModifierIns "Modifier Instancer" 
(
	Group "Source Object"
				(
				pickButton pick_btn "Select Source Object" tooltip:"Pick Source object from scene"
				Multilistbox mods_lbox "Select Source Modifiers " height:5
				)
	Group "Target Object"
				(
				button mult_btn "Select Target Objects" tooltip:"Select one or more objects using Select Objects dialog"
				listBox objects_lbox "" items:target_names_list height:5
				button remove_all_btn "Remove all" tooltip:"Remove all objects from list"
				)
	button instancer "INSTANCE MODIFIERS" 
	
	on pick_btn picked obj do
				(
					picked_mods = #()
					SourceOBJ = obj
					pick_btn.text=SourceOBJ.name
					for i = 1 to SourceOBJ.modifiers.count do 
					(append picked_mods SourceOBJ.modifiers[i].name)
					mods_lbox.items = picked_mods
					print picked_mods
					mods_lbox.selection = #{1..(SourceOBJ.modifiers.count)}
				)
		
				on mult_btn pressed do 
				(
				local obj = selectByName title:"Select target objects" single:false filter:getgeometry
										
				if obj!=undefined then 
					(
					for i=1 to obj.count do
					(
						append target_list obj[i].inode.handle
						append target_names_list obj[i].name
						objects_lbox.items = target_names_list
					)
					)
				)

	on objects_lbox doubleClicked num do 
			(
		deleteItem target_list num
		deleteItem target_names_list num
		objects_lbox.items = target_names_list

			)

			on remove_all_btn pressed do 
			(
				target_list = #()
				target_names_list = #()
				objects_lbox.items = target_names_list
			)
	
	on instancer pressed do
		(
			--print sourceOBJ
		mods = #()
		undo on
			--print mods_lbox.selection as array
		modinstancer sourceOBJ target_list mods_lbox.selection
		)		
)--End Of ModifierIns Rollout
addRollout ModifierIns RO rolledUp:false
rollout about_roll "About"
(
	label script1 "Tik Works "
	label script2 "Modifier Instancer v0.5"
	label author "Arda Kutlu"
	label year  "2008"
	label web "http://www.ardakutlu.com"	
)--End Of About_Roll
addRollout about_roll Ro rolledup:true			
)


)--End of Script 