(
/*
SourceObject=$Point001
FollowObject=$Point002
rangeStart=0
rangeEnd=100
*/
local SourceObject
local FollowObject
fn bakeToAnotherFN startTime endTime=
(
FollowObject.parent=undefined
FollowObject.pivot=SourceObject.transform[4]
--FollowObject.pivot=SourceObject.pivot --nedense her zaman dogru calismiyor
for i = startTime to endTime do
(
	with animate on
	(
		at time i FollowObject.transform=SourceObject.transform
	)
)
)


rollout BakeToAnother "Bake To Another"
(
	group "Objects"
	(
	pickbutton sourceObjPB "Source Object"
	pickbutton followObjPB "Follow Object"
	)
group "Range"
	(
	spinner startFrame "Start" type:#integer range:[-999999,999999,animationRange.start]
	spinner endFrame "End" type:#integer range:[-999999,999999,animationRange.end]
	)
	button gogogo "Bake"
	
	on sourceObjPB picked obj do
	(
		if obj != undefined do
		(
		SourceObject=obj
		sourceObjPB.text = obj.name
		)
	)
		on followObjPB picked obj do
	(
		if obj != undefined do
		(
		FollowObject=obj
		followObjPB.text = obj.name
		)
	)
	on gogogo pressed do
	(
		bakeToAnotherFN startFrame.value endFrame.value
	)

)
	



createDialog BakeToAnother 100 180

)