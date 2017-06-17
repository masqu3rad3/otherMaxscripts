--TIK ASCII Sequence Exporter v1.0
--Features:
-- Export ASCII sequence
-- Export only selected range

--Known Issues
--Due to the .ase exporters limitations, it asks for confirmation on each frame. Couldnt find a workaround yet. The only thing you can do is keeping the enter button pressed :)

--Installation:
-- Run the script. (MAXScript => Run Script)
-- Customize => Customize User Interface. Under the Category: Tik Works you will find the script.
-- Assign the script to a Menu, Hotkey or Quad Menu.

--Usage:
--Select mesh animated objects you want to export.
--Select the path
--Define the base name of the sequence.
--Define the time range. Default range is current scenes timeline range.
--Hit export

-- Written by Arda Kutlu
-- Date: January 2011

macroScript TIK_ASCIIExport
category: "Tik Works"
tooltip: "ASCII Sequence Exporter"
ButtonText: "Tik ASCIISequence Export"

(
local R1=animationRange.start.frame as integer
local R2=animationRange.end.frame as integer
local SavePath = GetDir #scene
local Filename
if selection.count == 1 then
(Filename=$.name)
else
(Filename = maxFileName)



fn exportGeoSeq MarkIn MarkOut=
(
	for x = MarkIn to MarkOut do
		(

		animationRange=interval x (MarkOut+1)
		--sliderTime = x
		digit = formattedPrint (x) format:".4d"
			if animationRange.start==MarkIn then
			(
			exportFile (SavePath+"/"+FileName+"_"+digit) selectedOnly:false using:AsciiExp
			)
			else
				(
				exportFile (SavePath+"/"+FileName+"_"+digit) selectedOnly:false using:AsciiExp
				)

		)
		animationRange=interval R1 R2
)
--exportFile (GetDir #scene + "/exportTest.obj") selectedOnly:true

global ObjSeqExp
try(destroyDialog ObjSeqExp)catch()
rollout ObjSeqExp "Object Sequence Exporter"
(
label l1 "Export Path" align:#left
edittext path_text ""  readonly:true  width:220 across:2
button browse "Browse" enabled:true offset:[45,0] height:18
edittext filename_text "File Name" enabled:true	

Spinner R1sp "Range Start" type:#integer range:[-99999999,99999999,R1] align:#center fieldwidth:45 --across:2
Spinner R2sp "Range End" type:#integer range:[-99999999,99999999,R2] align:#center fieldwidth:45
--label l2 "Exports selection as sequence in selected time range"
button exportButton "Export"
	
label l3 "Written by Arda Kutlu"  offset:[0,8]
HyperLink website "www.ardakutlu.com"  address:"http://www.ardakutlu.com" color:blue hovercolor:orange visitedcolor:blue align:#center

on ObjSeqExp open do
	(
		path_text.text=SavePath
		filename_text.text=Filename
	)

on filename_text entered txt do
(Filename=filename_text.text)
	
on browse pressed do
(
	SavePath = getSavePath caption:"Geometry Sequence Export Path"
	if SavePath != undefined then
	(path_text.text=SavePath)
)

on R1sp changed value do
	(R1=R1sp.value)

on R2sp changed value do
	(R2=R2sp.value)

on exportButton pressed do
	(

		(exportGeoSeq (R1) (R2))

	)
	
)
createdialog ObjSeqExp width:300
)--End of Script