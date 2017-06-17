--ID Changer 0.2

FaceArray=#()
uniqueIDList=#()
skipList=#()
groupHeads=#()
overrideConfirmed=true

fn OpenCloseGrps switch =
(
	if switch==open then
	(
	groupHeads=#()
		for i in selection do
		(
			if (isGroupHead i) == true then
			(
				append groupHeads i
				setGroupOpen i true
			)
		)
	)
	if switch==close then
	(
		for i in groupHeads do
		(
			(setGroupOpen i false)
		)
	)
)

fn checkEditable_poly yta = --this checks for whether the objects in the selection are editable poly or not
(

	
	skipList=#()
		for i in selection do
		(
			if superclassof i != GeometryClass or classof i == Targetobject then
			(append skipList i)
			else
			(
				if classof i != editable_poly then
					(
						if yta==true then
						(convertToPoly i)
						else
						(
						qBox = querybox ((i.name) + " is not an Editable Poly. Do you want to convert it now? Press Yes to convert the object to Editable Poly No to skip this object")
							if qBox == true then --convert to editable_poly
							(convertToPoly i)
							else
							(append skipList i) --add it to deselection list
						)
					)
			)
		)--end of for loop (i)
				for obj in skiplist do --deselect items in the deselection list
			(deselect obj)
	
)--end of function

fn ListIDs=
(
FaceArray=#()	
uniqueIDList=#()
	if selection.count >0 then
	(
		for obj in selection do
			(
			faceCount=polyop.getNumFaces obj
				for i = 1 to faceCount do
					(
					tempID= (polyop.getFaceMatID obj i)
					append FaceArray (tempID as string)
					)
			)
		if FaceArray.count >1 then
		(uniqueIDList=makeUniqueArray FaceArray)

	)	
	else
		(uniqueIDList=#())
)

fn ChangeID fromID toID=
(
	for obj in selection do
	(
		obj.selectByMaterial fromID
		obj.setMaterialIndex toID 1
	)
)


--------------------------------------------------------
---------------ROLLOUTS----------------------------
---------------------------------------------------------

global IDchanger
try(destroyDialog IDchanger)catch()
rollout IDchanger "ID Changer"
(
	button analyzeObj_but "Analyze Selection"
	Multilistbox IDlist_mList "ID List " height:30
	button changeID_but "Change ID" across:3
	spinner fromID_sp "from" type:#integer fieldwidth:30 pos:[85,452,20]
	spinner toID_sp "to" type:#integer fieldwidth:30 pos:[150,452,20]
	checkbox yesToAll "Convert all to Editable Poly"
	
on analyzeObj_but pressed do
	(
		if yesToAll.state == true then
			(
			qboxB = querybox "All objects will be converted to editable Polys do you want to continue?"
			if qboxB==true then
			(overrideConfirmed=true)
			else
			(overrideConfirmed=false)
			)
		
		if overrideConfirmed==true or yesToAll.state==false then
			(
			originalSel=selection as array
			OpenCloseGrps open --Check for the groups and open if any
			checkEditable_poly yesToAll.state
			IDlist_mList.items=ListIDs()
			OpenCloseGrps close -- Close the previously opened groups
			select originalSel
			)	
	)
on changeID_but pressed do
	(
		if yesToAll.state == true then
			(
			qboxB = querybox "All objects will be converted to editable Polys do you want to continue?"
			if qboxB==true then
			(overrideConfirmed=true)
			else
			(overrideConfirmed=false)
			)
	if overrideConfirmed==true or yesToAll.state==false then
		(
		originalSel=selection as array
		OpenCloseGrps open --Check for the groups and open if any
		checkEditable_poly yesToAll.state --call Check Editable Poly function	
		ChangeID fromID_sp.value toID_sp.value --call the change ID function
		IDlist_mList.items=ListIDs()--Refresh the multilistbox
		OpenCloseGrps close -- Close the previously opened groups
		select originalSel
		)
	)

------------------------------------

)
createdialog IDchanger width:220