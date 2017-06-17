--1,3 Remember feature added
/*
macroScript TIK_MMED
category: "Tik Works"
tooltip: "Mass Modifier Enable/Disable"
buttonText: "Mass Modifier E/D"
*/
(
if massModStates==undefined then
(
global TurbosmoothState=true
global MeshsmoothState=true
global FlexState=true
global TessellateState=true
global SubdivideState=true
global ShellState=true
global HairState=true
global massModStates=1
)

if RO != undefined then (closeRolloutFloater RO)
RO = NewRolloutFloater "TIK Mass Modifier Enabler/Disabler" 150 442
local foo=true
(

rollout ID "Modifier Enable/Disable"
	(
	group "Turbosmooth Modifier"
		(
		checkbutton tsmo "Turbosmooth" checked: TurbosmoothState width:120 height:25
		)
		on tsmo changed state do
			(
			TurbosmoothState=state
			for i in objects do try i.modifiers[#Turbosmooth].enabled = state
			catch
			()
			)
		
		group "Meshsmooth Modifier" 
		(
		checkbutton msmo "Meshsmooth" checked: MeshsmoothState width:120 height:25
		)
		on msmo changed state do
			(
				MeshsmoothState=state
			for i in objects do try i.modifiers[#Meshsmooth].enabled = state
			catch
			()
			)
	
		group "Flex Modifier" 
		(
		checkbutton fle "Flex" checked: FlexState width:120 height:25
		)
		on fle changed state do
			(
				FlexState=state
			for i in objects do try i.modifiers[#Flex].enabled = state
			catch
			()
			)
		
		group "Tessellate Modifier" 
		(
		checkbutton tes "Tessellate" checked: TessellateState width:120 height:25
		)
		on tes changed state do
			(
			TessellateState=state
			for i in objects do try i.modifiers[#Tessellate].enabled = state
			catch
			()
			)
			
		group "Subdivide Modifier"
		(
		checkbutton sub "Subdivide" checked: SubdivideState width:120 height:25
		)
		on sub changed state do
			(
			SubdivideState=state
			for i in objects do try i.modifiers[#subdivide].enabled = state
			catch
			()
			)
			
		group "Shell Modifier"
		(
		checkbutton she "Shell" checked: ShellState width:120 height:25
		)
		on she changed state do
			(
			ShellState=state
			for i in objects do try i.modifiers[#shell].enabled = state
			catch
			()
			)
			
		group "Hair Modifier"
		(
		checkbutton hai "Hair" checked: HairState width:120 height:25
		)
		on hai changed state do
			(
			HairState=state
			for i in objects do try i.modifiers[#hair_and_fur].enabled = state
			catch
			()
			)
			
	)
addRollout ID RO


rollout about_roll "About"
(
	label script1 "Mass Modifier 1.3"
	label script2 "Enabler/Disabler"
	label author "Arda Kutlu"
	label year "2007"
	label ema "ardakutlu@gmail.com"
	hyperlink hl "www.ardakutlu.com" address:"www.ardakutlu.com"
)
addRollout about_roll RO rolledUp:true

)
) 