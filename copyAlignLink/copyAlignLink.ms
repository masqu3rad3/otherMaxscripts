
(
local target_list = #()
local target_names_list = #()
local SourceOBJ
local insCheck
	
fn CopyAlignLink OFFX OFFY OFFZ Unrenderable ifInstance= 
(
	for i in target_list do
	(
		if ifInstance==true then
		(Temp_SourceCopy = instance SourceOBJ)
		else
		(Temp_SourceCopy = copy SourceOBJ)
	
		Temp_SourceCopy.transform = i.transform
		if OFFX != 0.0 or OFFY != 0.0 or OFFZ != 0.0 then
		(
		Rot_Val = eulerangles OFFX OFFY OFFZ
		Rotate Temp_SourceCopy Rot_Val
		)
		Temp_SourceCopy.parent = i
		Temp_SourceCopy.name = (SourceOBJ.name)+"_"+(i.name as string)
		if Unrenderable == true then
		(
		i.renderable = off
		)
	)
)
-------------------------------------------------------------------
try(destroyDialog CAL )catch()
	rollout CAL "Copy-Align-Link"
	(
	pickbutton SourceOBJ_btn "Select Source" width:120
	button TargetOBJ_btn "Select Target Objects" tooltip:"Select one or more objects using Select Objects dialog" width:120
	listBox targets_lbox "" items:target_names_list height:5
	button remove_all_btn "Remove all" tooltip:"Remove all objects from list" width:120
	checkbox make_unrenderable "Unrenderable Targets?" checked:true
	checkbox make_instance "Instance?" checked:false
		group "Rotation Offsets"
		(
			spinner Offset_x "X Rotation:  " range:[-360,360,0] fieldwidth:50
			spinner Offset_y "Y Rotation:  " range:[-360,360,0] fieldwidth:50
			spinner Offset_z "Z Rotation:  " range:[-360,360,0] fieldwidth:50
		)
	button goo_btn "Copy-Align-Link" width:120
	label l1 "Copy-Align-Link V1.0"  
	label l2 "Arda Kutlu"  
	HyperLink website "www.ardakutlu.com"  address:"http://www.ardakutlu.com" color:blue hovercolor:orange visitedcolor:blue align:#center
		
		
		on SourceOBJ_btn picked obj do
		(
			SourceOBJ = obj
			SourceOBJ_btn.text=SourceOBJ.name
		)
		
		on TargetOBJ_btn pressed do 
		(
			local obj = selectByName title:"Select target objects" single:false
			if obj!=undefined then 
				(
					for i=1 to obj.count do
					(
						append target_list obj[i]
						append target_names_list obj[i].name
						targets_lbox.items = target_names_list
					)
				)
		)
		
		on targets_lbox doubleClicked num do 
			(
				deleteItem target_list num
				deleteItem target_names_list num
				targets_lbox.items = target_names_list
			)
			
		on remove_all_btn pressed do 
			(
				target_list = #()
				target_names_list = #()
				targets_lbox.items = target_names_list
			)
		on goo_btn pressed do
			(
				print target_list
				CopyAlignLink Offset_x.value Offset_y.value Offset_z.value make_unrenderable.state make_instance.state
			)
		
	)

createdialog cal 150 350
)