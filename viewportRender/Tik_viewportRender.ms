(

local savePath
savePath=undefined
local R1=animationRange.start.frame as integer
local R2=animationRange.end.frame as integer


fn renderSeq MarkIn MarkOut=
(
sPath=getFilenamePath savePath

sFileName=getFilenameFile savePath

sExt=getFilenameType savePath
	
	for x = MarkIn to MarkOut do
		(
		sliderTime = x
		digit = formattedPrint (x) format:".4d"
			render outputfile:(sPath+sFileName+digit+sExt) vfb:off

		)
)



global ObjSeqExp
try(destroyDialog ObjSeqExp)catch()
rollout ObjSeqExp "Render from Viewport"
(
label l1 "Render Path" align:#left
edittext path_text ""  readonly:true  width:220 across:2
button browse "Browse" enabled:true offset:[45,0] height:18

Spinner R1sp "Range Start" type:#integer range:[-99999999,99999999,R1] align:#center fieldwidth:45 --across:2
Spinner R2sp "Range End" type:#integer range:[-99999999,99999999,R2] align:#center fieldwidth:45

button exportButton "Render"
	
label l3 "Written by Arda Kutlu"  offset:[0,8]
HyperLink website "www.ardakutlu.com"  address:"http://www.ardakutlu.com" color:blue hovercolor:orange visitedcolor:blue align:#center

	
on browse pressed do
(
	savePath = getBitmapSaveFileName ()
	if SavePath != undefined then
	(path_text.text=savePath)

)

on R1sp changed value do
	(R1=R1sp.value)

on R2sp changed value do
	(R2=R2sp.value)

on exportButton pressed do
	(
		if savePath != undefined then
		(renderSeq (R1) (R2))
		else
		(messageBox "Choose Render Path")
	)


)
createdialog ObjSeqExp width:300
)--End of Script
