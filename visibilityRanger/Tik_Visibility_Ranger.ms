/*
macroScript visibility_ranger
category: "Tik Works"
toolTip: "Visibility Ranger"
buttonText: "Visibility Ranger"
*/  
  ( 
   fn visibil startF finishF StartOffF FinishOffF p1 p2=
            (
				for i in selection do 
					(
					i.visibility = bezier_float()
						if StartOffF <= 1 do StartOffF = 1
						if FinishOffF <= 1 do FinishOffF = 1
						animate on
							(
								addNewKey i.visibility.controller (startF - startOffF)
								at time (startF - startOffF) i.visibility = p1

								addNewKey i.visibility.controller (startF)
								at time (startF) i.visibility = p2
						   
								addNewKey i.visibility.controller (FinishF + FinishOffF)
								at time (FinishF + FinishOffF) i.visibility = p1

								addNewKey i.visibility.controller (FinishF)
								at time (FinishF) i.visibility = p2
							)
						)
            )--end of visibil function
    fn delvis p1=
	(
           for i in selection do 
			   (		
				i.visibility=p1
			   deletekeys i.visibility.controller
			   )
		
	)


(
	global visibility_ranger
	try(destroyDialog visibility_ranger)catch()
	
	rollout visibility_ranger "Visibility Ranger"
		
	(
		
	groupbox Effect_Area "Effect Area" width:110 height:65 offset:[9,0]
	spinner startframe "From Frame" range: [-9999, 9999, 0] type:#integer fieldwidth: 32 offset:[-10,-50]
	spinner endframe "To Frame" range: [-9999, 9999, 10] type:#integer fieldwidth: 32 offset:[-10,0]
	groupbox Fade_Values "Fade Values" width:110 height:65 offset:[9,10]
	spinner startfade "Start Fade" range: [0, 9999, 0] type:#integer fieldwidth: 32 offset:[-10,-50]
	spinner endfade "Finish Fade" range: [0, 9999, 0] type:#integer fieldwidth: 32 offset:[-10,0]
	radiobuttons area_vis_invis labels:#("Make Area Visible","Make Area Invisible") offset:[0,10]
	button Clea "Clear Visibility Keys" tooltip:"Deletes All visibility Keys of selected object" offset:[0,0]
	button makevis "Define Visible Area" tooltip: "Makes selected object visible between selected keyframes"
		
	on startframe changed value do
	(
	if endframe.value <= startframe.value then endframe.value  = startframe.value
	)
	on endframe changed value do
	(
	if startframe.value >= endframe.value then startframe.value   = endframe.value
	)
				
	
	on makevis pressed do 
	(
		case area_vis_invis.state of
		(
			1: visibil startframe.value endframe.value startfade.value endfade.value off on
			2: visibil startframe.value endframe.value startfade.value endfade.value on off
		)
	)
	on Clea pressed do 
	(	
				case area_vis_invis.state of
		(
			1: delvis on
			2: delvis off
		)
	)
	
	)
	
	createdialog visibility_ranger 150 250
)
		


)
