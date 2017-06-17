--ID Changer 0.1

FaceArray=#()
uniqueIDList=#()

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
	else
		(messageBox "Select at least one object")
	)
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

	Multilistbox IDlist_mList "ID List " height:5
	button changeID_but "Change ID" across:3
	spinner fromID_sp "from" type:#integer fieldwidth:30 pos:[85,125,20]
	spinner toID_sp "to" type:#integer fieldwidth:30 pos:[150,125,20]
	
on analyzeObj_but pressed do
	(
		IDlist_mList.items=ListIDs()
	)
on changeID_but pressed do
	(
	ChangeID fromID_sp.value toID_sp.value --call the change ID function
	IDlist_mList.items=ListIDs()--Refresh the multilistbox
	)
	
)
createdialog IDchanger width:220