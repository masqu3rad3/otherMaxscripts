

global totalL
global sliderL


try (destroyDialog animationR_RO) catch()
	rollout animationR_RO "Animation Range" width:3500 height:25
	
(

dotNetControl startDN "System.Windows.Forms.TrackBar" minimum:animationRange.start maximum:animationRange.end type:#integer width:100 height:25 offset:[80,-5]
dotNetControl endDN "System.Windows.Forms.TrackBar" minimum:animationRange.start maximum:animationRange.end  type:#integer width:100 height:25 offset:[0,-5]

spinner starto "" range:[-9999,9999,animationRange.start] type:#integer fieldwidth:35  pos:[-4,2]

spinner start_SP "" range:[(animationRange.start ),(animationRange.end ),animationRange.start] type:#integer fieldwidth:35 pos:[45,2]
	button playBlastBT "PB" 
spinner endo "" range:[-9999,9999,animationRange.end] type:#integer fieldwidth:35 pos:[(animationR_RO.width-13),2]
spinner end_SP "" range:[(animationRange.start ),(animationRange.end),animationRange.end]  type:#integer fieldwidth:35 pos:[(animationR_RO.width-12),2]
	--spinner end_SP "" range:[(animationRange.start ),(animationRange.end),animationRange.end]  type:#integer fieldwidth:35 pos:[(animationR_RO.width-63),2]
--button playBlastBT "PB" pos:[(animationR_RO.width-63),2]
	
			on animationR_RO open do
		(
			totalL = animationR_RO.width
			sliderL = (totalL/2)-95
			endo.pos = [(totalL-23),2]
			end_SP.pos =[(totalL-73),2]
			playBlastBT.pos=[(totalL-43),2]
			startDN.width = sliderL
			endDN.pos = [(startDN.width + 75),0]
			endDN.width = sliderL
			endDN.value = (animationRange.end)
			
			cui.registerdialogbar animationR_RO style:#(#cui_dock_bottom, #cui_floatable, #cui_handles)
			cui.dockdialogbar animationR_RO #cui_dock_bottom  
		)	
		on playBlastBT pressed do
		(max preview)
		
		on animationR_RO resized size do
		(
			totalL = animationR_RO.width
			sliderL = (totalL/2)-100
			endo.pos = [(totalL-43),2]
			end_SP.pos =[(totalL-92),2]
			playBlastBT.pos=[(totalL-30),2]
			startDN.width = sliderL
			endDN.pos = [(startDN.width + 75),0]
			endDN.width = sliderL
		)

		
	on starto changed val do
	( 
	if starto.value >= endo.value then endo.value = starto.value +1
	startDN.minimum = starto.value
	endDN.minimum =  starto.value
	startDN.value = starto.value
	start_SP.range.x = starto.value
	end_SP.range.x = starto.value
	start_SP.range.z = starto.value
	animationRange = interval start_SP.value end_SP.value
	)
	
	on startDN ValueChanged val do 
			(
				
			if startDN.value >= endDN.value and startDN.value != animationRange.end then endDN.value = startDN.value +1
				if startDN.value >= end_SP.value-1 or startDN.value >= startDN.maximum then startDN.value = end_SP.value-1
		
			start_SP.value = startDN.value
			animationRange = interval start_SP.value end_SP.value
			)	
	
	on start_SP changed val do
			(
			if start_SP.value >= end_SP.value then end_SP.value = start_SP.value +1
			startDN.value = start_SP.value
			animationRange = interval start_SP.value end_SP.value
			)	
			
	on endo changed val do
	( 
	if starto.value >= endo.value then endo.value = starto.value +1
	startDN.maximum = endo.value
	endDN.maximum = endo.value
	endDN.value =endo.value
	start_SP.range.y = endo.value
	end_SP.range.y = endo.value
	end_SP.range.z = endo.value
	animationRange = interval start_SP.value end_SP.value
	)
		
		on endDN ValueChanged val do 
		(
			
			if endDN.value <= startDN.value and endDN.value != animationRange.start then startDN.value = endDN.value - 1
				if endDN.value <= start_SP.value +1  or endDN.value <= endDN.minimum then endDN.value = start_SP.value +1
		    end_SP.value = endDN.value
			animationRange = interval start_SP.value end_SP.value
			
		)
		
				on end_SP changed val do 
		(
			if end_SP.value <= start_SP.value then start_SP.value = end_SP.value - 1
			endDN.value = end_SP.value
			animationRange = interval start_SP.value end_SP.value
		)
	
	
)	
	
	createDialog animationR_RO style:#(#style_resizing,#style_titlebar,#style_sysmenu)
	
