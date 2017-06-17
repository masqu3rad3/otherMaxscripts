-- date:		18.12.2007
-- script: 		Mass Modifier Enabler/Disabler
-- version:		1.1
-- written by:		Arda Kutlu
-- e-mail:		ardakutlu@gmail.com


macroscript TIK_MMED
category: "Tik Works"
tooltip: "Mass Modifier Enable/Disable"
buttonText: "Mass Modifier E/D"

(
if RO != undefined then (closeRolloutFloater RO)
RO = NewRolloutFloater "TIK Mass Modifier Enabler/Disabler" 150 442
local foo=true
(

rollout ID "Modifier Enable/Disable"
	(
	group "Turbosmooth Modifier"
		(
		checkbutton tsmo "Turbosmooth" checked: true width:120 height:25
		)
		on tsmo changed true do
			(
			for i in objects do try i.modifiers[#Turbosmooth].enabled = true
			catch
			()
			)
		
		group "Meshsmooth Modifier" 
		(
		checkbutton msmo "Meshsmooth" checked: true width:120 height:25
		)
		on msmo changed true do
			(
			for i in objects do try i.modifiers[#Meshsmooth].enabled = true
			catch
			()
			)
	
		group "Flex Modifier" 
		(
		checkbutton fle "Flex" checked: true width:120 height:25
		)
		on fle changed true do
			(
			for i in objects do try i.modifiers[#Flex].enabled = true
			catch
			()
			)
		
		group "Tessellate Modifier" 
		(
		checkbutton tes "Tessellate" checked: true width:120 height:25
		)
		on tes changed true do
			(
			for i in objects do try i.modifiers[#Tessellate].enabled = true
			catch
			()
			)
			
		group "Subdivide Modifier"
		(
		checkbutton sub "Subdivide" checked: true width:120 height:25
		)
		on sub changed true do
			(
			for i in objects do try i.modifiers[#subdivide].enabled = true
			catch
			()
			)
			
		group "Shell Modifier"
		(
		checkbutton she "Shell" checked: true width:120 height:25
		)
		on she changed true do
			(
			for i in objects do try i.modifiers[#shell].enabled = true
			catch
			()
			)
			
		group "Hair Modifier"
		(
		checkbutton hai "Hair" checked: true width:120 height:25
		)
		on hai changed true do
			(
			for i in objects do try i.modifiers[#hair_and_fur].enabled = true
			catch
			()
			)
			
	)
addRollout ID RO


rollout about_roll "About"
(
	label script1 "Mass Modifier 1.2"
	label script2 "Enabler/Disabler"
	label author "Arda Kutlu"
	label year "2007"
	label ema "ardakutlu@gmail.com"
	hyperlink hl "www.ardakutlu.com" address:"www.ardakutlu.com"
)
addRollout about_roll RO rolledUp:true

)
)