
(
global LinkClosestRO
local parentArray=#()
local childArray=#()
local parent_names_list=#()
local child_names_list=#()


fn checkParents o=
(
	finditem parentArray o ==0
	--o != $Spot01
/*
for i in parentArray do
(o != i)
	*/
)

fn checkChildren o=
(
		finditem childArray o ==0
--	o != childArray
	/*
for i in childArray do
(o != i)
	*/
)


fn linkClosest=
  (
	  --parentArray = parents
	  --childArray = children
	  for b in childArray do

	 distanceArray=#()
	 for  p in parentArray do
	 (
		print "parents"
		print parentArray
		print "schildren"
		print childArray
		tempDis= distance p b
		 --print tempDis
	 append distanceArray tempDis
	 )
		shortestDistance=amin distanceArray
		closestPointIndex=findItem distanceArray shortestDistance
		b.parent=parentArray[closestPointIndex]
 )
 
 
if LinkClosestRO != undefined then (closeRolloutFloater LinkClosestRO)
              
LinkClosestRO = NewRolloutFloater "Link To The Closest" 200 400
 
 rollout Linker "Link Closest" 
(
	Group "Child Objects"
				(
				button mult_btnChild "Select Child Objects" tooltip:"Select one or more objects using Select Objects dialog"
				listBox objects_lboxChild ""  height:5
				button remove_all_btnChild "Remove all" tooltip:"Remove all objects from list"
				)
	Group "Parent Objects"
				(
				button mult_btnParent "Select Parent Objects" tooltip:"Select one or more objects using Select Objects dialog"
				listBox objects_lboxParent ""  height:5
				button remove_all_btnParent "Remove all" tooltip:"Remove all objects from list"
				)
	button linker_btn "Link To The Closest" 
	
		
				on mult_btnChild pressed do 
				(
				local obj = selectByName title:"Select target objects" single:false filter:checkParents o
										
				if obj != undefined then 
					(
					childArray=obj
					for i=1 to childArray.count do
					(
						--append target_list obj[i].inode.handle
						append child_names_list childArray[i].name
						objects_lboxChild.items = child_names_list
					)

					)
				)

	on objects_lboxChild doubleClicked num do 
			(
		deleteItem childArray num
		deleteItem child_names_list num
		objects_lboxChild.items = child_names_list

			)

			on remove_all_btnChild pressed do 
			(
				childArray = #()
				child_names_list = #()
				objects_lboxChild.items = child_names_list
			)
			
			
	on mult_btnParent pressed do 
				(
				local obj = selectByName title:"Select target objects" single:false filter:checkChildren o
										
				if obj != undefined then 
					(
					parentArray=obj
					for i=1 to parentArray.count do
					(
						--append target_list obj[i].inode.handle
						append parent_names_list parentArray[i].name
						objects_lboxParent.items = parent_names_list
					)

					)
				)

	on objects_lboxParent doubleClicked num do 
			(
		deleteItem parentArray num
		deleteItem parent_names_list num
		objects_lboxParent.items = parent_names_list

			)

			on remove_all_btnParent pressed do 
			(
				parentArray = #()
				parent_names_list = #()
				objects_lboxParent.items = parent_names_list
			)
	
	on linker_btn pressed do
	(

		linkClosest()
	)
		
)--End Of Linker Rollout


addRollout Linker LinkClosestRO rolledUp:false
)