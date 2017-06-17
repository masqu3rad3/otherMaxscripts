--TIK RF BIN Sequence Exporter v1.0

(
local R1=animationRange.start.frame as integer
local R2=animationRange.end.frame as integer
local SavePath = GetDir #scene

fn exportGeoSeq MarkIn MarkOut=
(
	for x = MarkIn to MarkOut do
		(

		
		sliderTime = x
		digit = formattedPrint (x) format:".4d"
			if sliderTime==MarkIn then
				(
				exportFile (SavePath) selectedOnly:true using:RfBINMeshExporter
				)
			else
				(
				exportFile (SavePath) #noPrompt selectedOnly:true using:RfBINMeshExporter
				)

		)
)
--exportFile (GetDir #scene + "/exportTest.obj") selectedOnly:true

global ObjSeqExp
try(destroyDialog ObjSeqExp)catch()
rollout ObjSeqExp "RF Bin Sequence Exporter"
(
label l1 "Export Path" align:#left
edittext path_text ""  readonly:true  width:220 across:2
button browse "Browse" enabled:true offset:[45,0] height:18

Spinner R1sp "Range Start" type:#integer range:[-99999999,99999999,R1] align:#center fieldwidth:45 --across:2
Spinner R2sp "Range End" type:#integer range:[-99999999,99999999,R2] align:#center fieldwidth:45
--label l2 "Exports selection as sequence in selected time range"
button exportButton "Export"
	
label l3 "Written by Arda Kutlu"  offset:[0,8]
HyperLink website "www.ardakutlu.com"  address:"http://www.ardakutlu.com" color:blue hovercolor:orange visitedcolor:blue align:#center

on ObjSeqExp open do
	(
		path_text.text=SavePath
	)
	
on browse pressed do
(
	SavePath = getSavePath caption:"RF Bin Sequence Export Path"
	if SavePath != undefined then
	(path_text.text=SavePath)
)

on R1sp changed value do
	(R1=R1sp.value)

on R2sp changed value do
	(R2=R2sp.value)

on exportButton pressed do
	(
		if selection.count > 0 then
		(exportGeoSeq (R1) (R2) )
		else
		(messagebox "Select at least one geometry object" title:#Error)
	)
	
)
createdialog ObjSeqExp width:300
)--End of Script