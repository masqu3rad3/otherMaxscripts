macroScript TIK_SaveIncrement
category: "Tik Works"
tooltip: "Save Increment"
(
max saveplus

if rendOutputFilename != "" then
(
Rscenedialog=renderscenedialog.isopen()

if Rscenedialog==true then (rendersceneDialog.close())	

FileExtension=	substring rendOutputFilename (((rendOutputFilename).count)-3) ((rendOutputFilename).count) -- Get the extension
	
FilePath = getFilenamePath rendOutputFilename

FilePathAndName=FilePath + (substituteString maxFileName ".max" "_") + FileExtension

rendOutputFilename = FilePathAndName

if Rscenedialog==true then (rendersceneDialog.open())
)

) 