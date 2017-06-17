macroScript MrStudio
category: "Tik Works"
toolTip: "MrStudio"
buttonText: "MrStudio"
(
	---Variables---
	global bmpre_p1
	global bmpre_p2
	global bmpre_p3
	global bmpre_ini
	local PreviewAA_minVal=-4
	local PreviewAA_maxVal=4
	local PreviewSSVal=32
	local Area_samples=128
	local Ambient_samples=64
	local orbitx
	local orbity
	local orbitz
	local objVol
	local LightPosMult
	local orbitzCenter
	local ControlPoint
	local preset1
	local preset2
	local preset3
	local preset4
	local preset5
	local LeftLightVal
	local LeftLightCol
	local LeftLightSamp
	local RightLightVal
	local RightLightCol
	local RightLightSamp
	local BackLightVal
	local BackLightCol
	local BackLightSamp
	local AmbLightVal
	local AmbLightCol
	local AmbLightSamp
	local MrStudio_initial
	local MrStudio_preset1
	local MrStudio_preset2
	local MrStudio_preset3


-------CreatePresetDummies---------
			LightPresetCA = attributes LightPreset
		(
			parameters main
			(	
			LeftLightVal type:#float default:50
			LeftLightCol type:#color default:white
				
			RightLightVal type:#float default:150
			RightLightCol type:#color default:white
				
			BackLightVal type:#float default:0
			BackLightCol type:#color default:white
			
			AmbLightVal type:#float default:50
			AmbLightCol type:#color default:white
			)
		)
		
		MrStudio_Presets_layer = layermanager.newLayerFromName "MrStudio_Presets"


		if $MrStudio_initial == undefined then
			(
			MrStudio_initial = dummy()
			MrStudio_initial.name = "MrStudio_initial"
			custAttributes.add MrStudio_initial LightPresetCA
			MrStudio_Presets_layer.addNode MrStudio_initial
			)
			else (MrStudio_initial = $MrStudio_initial)
			

			
		if $MrStudio_preset1 == undefined then
			(
			MrStudio_preset1 = dummy()
			MrStudio_preset1.name = "MrStudio_preset1"
			custAttributes.add MrStudio_preset1 LightPresetCA
			MrStudio_Presets_layer.addNode MrStudio_preset1
			)
			else (MrStudio_preset1 = $MrStudio_preset1)
			
			
		if $MrStudio_preset2 == undefined then
			(
			MrStudio_preset2 = dummy()
			MrStudio_preset2.name = "MrStudio_preset2"
			custAttributes.add MrStudio_preset2 LightPresetCA
			MrStudio_Presets_layer.addNode MrStudio_preset2
			)
			else (MrStudio_preset2 = $MrStudio_preset2)
			
			
		if $MrStudio_preset3 == undefined then
			(
			MrStudio_preset3 = dummy()
			MrStudio_preset3.name = "MrStudio_preset3"
			custAttributes.add MrStudio_preset3 LightPresetCA
			MrStudio_Presets_layer.addNode MrStudio_preset3
			)
			else (MrStudio_preset3 = $MrStudio_preset3)
			
	
			MrStudio_initial.layer.isHidden = true
			MrStudio_initial.layer.isFrozen = true
	

---------------------------------		 

	
if $MrStudio_FreeArea_Left == undefined then
	($MrStudio_initial.LeftLightVal = 50
	$MrStudio_initial.LeftLightCol = white)
	else 
	($MrStudio_initial.LeftLightVal = $MrStudio_FreeArea_Left.multiplier
	$MrStudio_initial.LeftLightCol = $MrStudio_FreeArea_Left.rgbFilter)

if $MrStudio_FreeArea_Right == undefined then
	($MrStudio_initial.RightLightVal = 150
	$MrStudio_initial.RightLightCol = white)
	else 
	($MrStudio_initial.RightLightVal = $MrStudio_FreeArea_Right.multiplier
	$MrStudio_initial.RightLightCol = $MrStudio_FreeArea_Right.rgbFilter)

if $MrStudio_FreeArea_Back == undefined then
	($MrStudio_initial.BackLightVal = 0
	$MrStudio_initial.BackLightCol = white)
	else 
	($MrStudio_initial.BackLightVal = $MrStudio_FreeArea_Back.multiplier
	$MrStudio_initial.BackLightCol = $MrStudio_FreeArea_Back.rgbFilter)

if $MrStudio_Ambient_Light == undefined then
	($MrStudio_initial.AmbLightVal = 50
	$MrStudio_initial.AmblightCol = white)
	else 
	($MrStudio_initial.AmbLightVal = $MrStudio_Ambient_Light.multiplier *100
	$MrStudio_initial.AmblightCol = $MrStudio_Ambient_Light.rgb)

	
LeftLightVal = MrStudio_initial.LeftLightVal
RightLightVal = MrStudio_initial.RightLightVal
BackLightVal = MrStudio_initial.BackLightVal
AmbLightVal = MrStudio_initial.AmbLightVal
LeftLightCol = MrStudio_initial.LeftLightCol
RightLightCol = MrStudio_initial.RightLightCol
BackLightCol = MrStudio_initial.BackLightCol
AmbLightCol = MrStudio_initial.AmbLightCol


	
	function PresetRefresh p1 p2 p3 LLV LLC RLV RLC BLV BLC ALV ALC= 
	(
		if p1 != true and p2 != true and p3 != true then
		(
		$MrStudio_initial.LeftLightVal = LLV
		$MrStudio_initial.LeftLightCol = LLC
		
		$MrStudio_initial.RightLightVal = RLV
		$MrStudio_initial.RightLightCol = RLC
			
		$MrStudio_initial.BackLightVal = BLV
		$MrStudio_initial.BackLightCol = BLC
		
		$MrStudio_initial.AmbLightVal = ALV
		$MrStudio_initial.AmbLightCol = ALC
		)
		if p1 == true then
		(
		$MrStudio_preset1.LeftLightVal = LLV
		$MrStudio_preset1.LeftLightCol = LLC
			
		$MrStudio_preset1.RightLightVal = RLV
		$MrStudio_preset1.RightLightCol = RLC
			
		$MrStudio_preset1.BackLightVal = BLV
		$MrStudio_preset1.BackLightCol = BLC
		
		$MrStudio_preset1.AmbLightVal = ALV
		$MrStudio_preset1.AmbLightCol = ALC
		)
		if p2 == true then
		(
		$MrStudio_preset2.LeftLightVal = LLV
		$MrStudio_preset2.LeftLightCol = LLC
			
		$MrStudio_preset2.RightLightVal = RLV
		$MrStudio_preset2.RightLightCol = RLC
			
		$MrStudio_preset2.BackLightVal = BLV
		$MrStudio_preset2.BackLightCol = BLC
		
		$MrStudio_preset2.AmbLightVal = ALV
		$MrStudio_preset2.AmbLightCol = ALC
		)
			if p3 == true then
		(
		$MrStudio_preset3.LeftLightVal = LLV
		$MrStudio_preset3.LeftLightCol = LLC
			
		$MrStudio_preset3.RightLightVal = RLV
		$MrStudio_preset3.RightLightCol = RLC
			
		$MrStudio_preset3.BackLightVal = BLV
		$MrStudio_preset3.BackLightCol = BLC
		
		$MrStudio_preset3.AmbLightVal = ALV
		$MrStudio_preset3.AmbLightCol = ALC
		)


		
	)
		
	function PresetRetrieve p1 p2 p3 = 
	(
		if p1 != true and p2 != true and p3 != true then
		(
		try $MrStudio_FreeArea_Left.multiplier = $MrStudio_initial.LeftLightVal catch ()
		try $MrStudio_FreeArea_Left.rgbFilter = $MrStudio_initial.LeftLightCol catch ()

			
		try $MrStudio_FreeArea_Right.multiplier = $MrStudio_initial.RightLightVal catch()
		try $MrStudio_FreeArea_Right.rgbFilter = $MrStudio_initial.RightLightCol catch()

			
		try $MrStudio_FreeArea_Back.multiplier = $MrStudio_initial.BackLightVal catch()
		try $MrStudio_FreeArea_Back.rgbFilter = $MrStudio_initial.BackLightCol catch()

		
		try $MrStudio_Ambient_Light.multiplier = $MrStudio_initial.AmbLightVal/100 catch()
		try $MrStudio_Ambient_Light.rgb = $MrStudio_initial.AmbLightCol catch()
		)
		if p1 == true then
		(
		try $MrStudio_FreeArea_Left.multiplier = $MrStudio_preset1.LeftLightVal catch ()
		try $MrStudio_FreeArea_Left.rgbFilter = $MrStudio_preset1.LeftLightCol catch ()
			
		try $MrStudio_FreeArea_Right.multiplier = $MrStudio_preset1.RightLightVal catch()
		try $MrStudio_FreeArea_Right.rgbFilter = $MrStudio_preset1.RightLightCol catch()
			
		try $MrStudio_FreeArea_Back.multiplier = $MrStudio_preset1.BackLightVal catch()
		try $MrStudio_FreeArea_Back.rgbFilter = $MrStudio_preset1.BackLightCol catch()
		
		try $MrStudio_Ambient_Light.multiplier = $MrStudio_preset1.AmbLightVal/100 catch()
		try $MrStudio_Ambient_Light.rgb = $MrStudio_preset1.AmbLightCol catch()
		)
			if p2 == true then
		(
		try $MrStudio_FreeArea_Left.multiplier = $MrStudio_preset2.LeftLightVal catch ()
		try $MrStudio_FreeArea_Left.rgbFilter = $MrStudio_preset2.LeftLightCol catch ()
			
		try $MrStudio_FreeArea_Right.multiplier = $MrStudio_preset2.RightLightVal catch()
		try $MrStudio_FreeArea_Right.rgbFilter = $MrStudio_preset2.RightLightCol catch()
			
		try $MrStudio_FreeArea_Back.multiplier = $MrStudio_preset2.BackLightVal catch()
		try $MrStudio_FreeArea_Back.rgbFilter = $MrStudio_preset2.BackLightCol catch()
		
		try $MrStudio_Ambient_Light.multiplier = $MrStudio_preset2.AmbLightVal/100 catch()
		try $MrStudio_Ambient_Light.rgb = $MrStudio_preset2.AmbLightCol catch()
		)
		if p3 == true then
		(
		try $MrStudio_FreeArea_Left.multiplier = $MrStudio_preset3.LeftLightVal catch ()
		try $MrStudio_FreeArea_Left.rgbFilter = $MrStudio_preset3.LeftLightCol catch ()
			
		try $MrStudio_FreeArea_Right.multiplier = $MrStudio_preset3.RightLightVal catch()
		try $MrStudio_FreeArea_Right.rgbFilter = $MrStudio_preset3.RightLightCol catch()
			
		try $MrStudio_FreeArea_Back.multiplier = $MrStudio_preset3.BackLightVal catch()
		try $MrStudio_FreeArea_Back.rgbFilter = $MrStudio_preset3.BackLightCol catch()
		
		try $MrStudio_Ambient_Light.multiplier = $MrStudio_preset3.AmbLightVal/100 catch()
		try $MrStudio_Ambient_Light.rgb = $MrStudio_preset3.AmbLightCol catch()
		)
	)

	function CrStudio =
	(

			
				------Render Engine and Units Setup------
					(
						units.DisplayType = #Generic
						units.MetricType = #Millimeters
						units.SystemType = #Millimeters
					)
					(
						mentalRR = mental_ray_renderer ()
						mentalRR.FinalGatherEnable2 = false
						mentalRR.CausticsEnable = false
						mentalRR.GlobalIllumEnable = false
						mentalRR.Enable_Material_Override = false
						renderers.current = mentalRR
						SceneExposureControl.exposureControl=()
						backgroundColor = gray
					)

				
				------Determine Studio size and center--------
					if selection.count != 0 then 
					(	
						LightPosMult=(($.max.z)-($.min.z))/37
						orbitz=selection.min.z
						orbitzCenter=selection.center.z
						orbitx=selection.center.x
						orbity=selection.center.y
					) 
						else ()
					-----Create Ground Plane----------
					 (
					ground = convertToPoly(Plane name:"MrStudio_Ground" length:1500 width:1000 lengthsegs:4 widthsegs:4 pos:[0,198,0])
					select ground
					max modify mode
					subObjectLevel = 1
					polyop.setVertSelection ground #(21,22,23,24,25)
					ground.moveToPlane [0,0,1] 527.134 #Vertex
					subObjectLevel = 0
					ground.wireColor = black
					ground.surfSubdivide = true
					ground.iterations = 1
					ground.useRenderIterations = true
					ground.useRenderSmoothness = true
					ground.renderIterations = 3
					ground.renderSmoothness = 1
					groundMaterial = Arch___Design__mi()
					groundMaterial.diff_color= color 211 211 211
					groundMaterial.refl_weight=0
					meditMaterials[1] = groundMaterial
					ground.material = meditMaterials[1]
					if orbitz != undefined then 
						(
						ground.pos = [orbitx,orbity,orbitz]
						scale ground [LightPosMult,LightPosMult,LightPosMult]
						) else ()
						clearSelection()
					)
					
					--------------Create Lights----------------
					(
					leftLight = Free_Area()
					leftLight.name = "MrStudio_FreeArea_Left"
					leftLight.distribution = 2
					leftLight.light_length = 686
					leftLight.light_width = 789
					leftLight.rgbFilter = LeftLightCol
					leftLight.intensity = 1000
					leftLight.multiplier = 50
					leftLight.useMultiplier = true
					leftLight.mr_NumAreaSamples = Area_samples
					leftLight.shadowGenerator = raytraceShadow()
					leftLight.baseObject.castShadows = true
					leftLight.position = [-726.58,-215.395,627.33]
					leftlight.multiplier
					rotate leftLight (angleaxis -50 [0,1,0])
					rotate leftLight (angleaxis 21 [0,0,1])
					if orbitz != undefined then 
						(
						leftLight.pivot = [0,0,0]
						scale leftLight [LightPosMult,LightPosMult,LightPosMult]
						move leftLight [orbitx,orbity,orbitz]
						)

						
					rightLight = Free_Area()
					rightLight.name = "MrStudio_FreeArea_Right"
					rightLight.distribution = 2
					rightLight.light_length = 714
					rightLight.light_width = 999
					rightLight.rgbFilter = RightLightCol
					rightLight.intensity = 1000
					rightLight.multiplier = 150
					rightLight.useMultiplier = true
					rightLight.mr_NumAreaSamples = Area_samples
					rightLight.shadowGenerator = raytraceShadow()
					rightLight.baseObject.castShadows = true
					rightLight.position = [752.309,53.182,477.891]
					rotate rightLight (angleaxis 65 [0,1,0])	
					if orbitz != undefined then 
						(
						rightLight.pivot = [0,0,0]
						scale rightLight [LightPosMult,LightPosMult,LightPosMult]
						move rightLight [orbitx,orbity,orbitz]
						)
						
					backLight = Free_Area()
					backLight.name = "MrStudio_FreeArea_Back"
					backLight.distribution = 2
					backLight.light_length = 714
					backLight.light_width = 999
					backLight.rgbFilter = BackLightCol
					backLight.intensity = 1000
					backLight.multiplier = 0
					backLight.useMultiplier = true
					backLight.mr_NumAreaSamples = Area_samples
					backLight.shadowGenerator = raytraceShadow()
					backLight.baseObject.castShadows = false
					backLight.position = [248.46,486.495,252.259]
					rotate backLight (angleaxis 75 [0,1,0])	
					rotate backLight (angleaxis 70 [0,0,1])	
					if orbitz != undefined then 
						(
						backLight.pivot = [0,0,0]
						scale backLight [LightPosMult,LightPosMult,LightPosMult]
						move backLight [orbitx,orbity,orbitz]
						)

					
					AmbientLight = Omnilight()
					AmbientLight.name = "MrStudio_Ambient_light" 
					AmbientLight.AmbientOnly = true
					AmbientLight.multiplier=0.5
					AmbientLight.rgb=AmbLightCol
					AmbientLight.projectorMap = Ambient_Reflective_Occlusion__3dsmax()
					AmbientLight.projectorMap.samples = Ambient_samples
					AmbientLight.projectorMap.max_distance = 50
					meditMaterials[2]=AmbientLight.projectorMap
					AmbientLight.isFrozen = true
					) 
				
	)


-------------------ROLLOUT------------------------
	(
	global MrStudio
	try(destroyDialog MrStudio)catch()
	
	rollout MrStudio "Mr. Studio"
		
	(
	button CreateStudio "Create Studio" pos:[10,6] width:77 height:25
	button DeleteStudio "Delete Studio" pos:[101,6] width:77 height:25
	

	
	colorPicker leftCp "" pos:[5,161] width:37 height:19 color:MrStudio_initial.LeftLightCol
	spinner leftsp "" pos:[6,139] width:42 height:16 range:[0,999999,50]
	slider Leftsl "" pos:[9,58] width:37 height:99 range: [0,250,50] orient:#vertical ticks:10
	button Leftbt "Left" pos:[9,35] width:37
		
	colorPicker rightCp "" pos:[49,161] width:37 height:19 color:MrStudio_initial.RightLightCol
	spinner rightsp "" pos:[50,139] width:42 height:16 range: [0,999999,150]
	slider rightsl "" pos:[52,58] width:37 height:99 range: [0,250,150] orient:#vertical
	button Rightbt "Right" pos:[52,35] width:37
	
	colorPicker backCp "" pos:[94,161] width:37 height:19 color:MrStudio_initial.BackLightCol
	spinner backsp "" pos:[95,139] width:42 height:16 range:[0,999999,0]
	slider backsl "" pos:[98,58] width:37 height:99 range: [0,250,0] orient:#vertical
	button Backbt "Back" pos:[98,35] width:37
	
	colorPicker ambCp "" pos:[140,161] width:37 height:19 color:MrStudio_initial.AmbLightCol
	spinner ambsp "" pos:[141,139] width:42 height:16 range: [0,999999,50]
	slider ambsl "" pos:[144,58] width:37 height:99 range: [0,250,50] orient:#vertical
	button Ambbt "Amb." pos:[144,35] width:37
	
	button preview "Press for Preview" pos:[9,186] width:170 height:110

	group "Preview Options"
	(
	slider previewAA "Antialiasing" width:90 range:[1,5,3] ticks:0 type:#integer  across:2
	slider previewSS "Shadow Samp." width:90 range:[1,5,3] ticks:0 type:#integer
	edittext previewAA_text "" readonly:true offset:[-4,-5] text:"Min 1/4,Max 4" across:2
	edittext previewSS_text "" readonly:true offset:[-3,-5] text:"32"
	)
	
	checkButton preset1 "S1" pos:[8,390] width:31 height:28
	checkButton preset2 "S2" pos:[43,390] width:31 height:28
	checkButton preset3 "S3" pos:[78,390] width:31 height:28
	button help "Help" pos:[113,390] width:65 height:28
		
		label l2 "Created by Arda Kutlu"  offset:[0,8]
		HyperLink website "www.ardakutlu.com"  address:"http://www.ardakutlu.com" color:blue hovercolor:orange visitedcolor:blue align:#center
		
	on previewAA changed val do
	(
		case previewAA.value of
		(
			1: (previewAA_minVal=-64
				previewAA_maxVal=-4
				previewAA_text.text="Min 1/64,Max 1/4"
				)
			2: (previewAA_minVal=-16
				previewAA_maxVal=1
				previewAA_text.text="Min 1/16,Max 1"
				)
			3:	(previewAA_minVal=-4
				previewAA_maxVal=4
				previewAA_text.text="Min 1/4,Max 4"
				)
			4:	(previewAA_minVal=1
				previewAA_maxVal=16
				previewAA_text.text="Min 1,Max 16"
				)
			5:	(previewAA_minVal=4
				previewAA_maxVal=64
				previewAA_text.text="Min 4,Max 64"
				)
		)
	)
	
		on previewSS changed val do
	(
		case previewSS.value of
		(
			1: (previewSSVal=8
				previewSS_text.text="8"
				)
			2: (previewSSVal=16
				previewSS_text.text="16"
				)
			3:	(previewSSVal=32
				previewSS_text.text="32"
				)
			4:	(previewSSVal=64
				previewSS_text.text="64"
				)
			5:	(previewSSVal=128
				previewSS_text.text="128"
				)
		)
	)
	
	on Leftbt pressed do
	(try (select $MrStudio_FreeArea_Left) catch())
		
		on Rightbt pressed do
	(try (select $MrStudio_FreeArea_Right) catch())
		
			on Backbt pressed do
	(try (select $MrStudio_FreeArea_Back) catch())
		
			on Ambbt pressed do
	(try (select $MrStudio_Ambient_Light) catch())
		
	on MrStudio open do
	(
				if $MrStudio_FreeArea_Left != undefined then
				(
				Leftsp.enabled = true
				Leftsl.enabled = true
				CreateStudio.enabled = false
				)
				if $MrStudio_FreeArea_Right != undefined then
				(
				Rightsp.enabled = true
				Rightsl.enabled = true
				CreateStudio.enabled = false
				)
				if $MrStudio_FreeArea_Back != undefined then
				(
				Backsp.enabled = true
				Backsl.enabled = true
				CreateStudio.enabled = false
				)
				if $MrStudio_Ambient_Light != undefined then
				(
				Ambsp.enabled = true
				Ambsl.enabled = true
				CreateStudio.enabled = false
				)
				if $MrStudio_Ground != undefined then
				(
				CreateStudio.enabled = false
				)

				
		Leftsp.value = $MrStudio_initial.LeftLightVal
		Leftsl.value = 	Leftsp.value
		Leftcp.color = $MrStudio_initial.LeftLightCol
		Rightsp.value = $MrStudio_initial.RightLightVal
		Rightsl.value = Rightsp.value
		Rightcp.color = $MrStudio_initial.RightLightCol
		Backsp.value = $MrStudio_initial.BackLightVal
		Backsl.value = Backsp.value
		Backcp.color = $MrStudio_initial.BackLightCol
		Ambsp.value = $MrStudio_initial.AmbLightVal
		Ambsl.value = Ambsp.value
		Ambcp.color = $MrStudio_initial.AmbLightCol
	presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
	presetretrieve preset1.state preset2.state preset3.state 
		
	)
	
	------------PRESET BEHAVIOURS-----------------
	on preset1 changed thestate do
	(
	if thestate == true then
		(
			preset2.state = false
			preset3.state = false
			presetretrieve preset1.state preset2.state preset3.state 
			leftsp.value = $MrStudio_preset1.LeftLightVal
			leftsl.value = leftsp.value
			rightsp.value = $MrStudio_preset1.RightLightVal
			rightsl.value = rightsp.value
			backsp.value = $MrStudio_preset1.BackLightVal
			backsl.value = backsp.value
			ambsp.value = $MrStudio_preset1.ambLightVal
			ambsl.value = ambsp.value
			
			leftcp.color = $MrStudio_preset1.LeftLightCol	
			rightcp.color = $MrStudio_preset1.RightLightCol
			backcp.color = $MrStudio_preset1.BackLightCol
			ambcp.color = $MrStudio_preset1.AmbLightCol
			
			if bmpre_p1 != undefined then
			(preview.images = #(bmpre_p1, undefined, 1, 1, 1, 1, 1))
		)
		else 
		(
			presetretrieve preset1.state preset2.state preset3.state 
			leftsp.value = $MrStudio_initial.LeftLightVal
			leftsl.value = leftsp.value
			rightsp.value = $MrStudio_initial.RightLightVal
			rightsl.value = rightsp.value
			backsp.value = $MrStudio_initial.backLightVal
			backsl.value = backsp.value
			ambsp.value = $MrStudio_initial.ambLightVal
			ambsl.value = ambsp.value
			
			leftcp.color = $MrStudio_initial.LeftLightCol	
			rightcp.color = $MrStudio_initial.RightLightCol
			backcp.color = $MrStudio_initial.BackLightCol
			ambcp.color = $MrStudio_initial.AmbLightCol
			if preset1.state == off and preset2.state == off and preset3.state == off and bmpre_ini != undefined then
			(preview.images = #(bmpre_ini, undefined, 1, 1, 1, 1, 1))
		)
	)	

	on preset2 changed thestate do
	(
		if thestate == true then
		(
			preset1.state = false
			preset3.state = false
			presetretrieve preset1.state preset2.state preset3.state 
			leftsp.value = $MrStudio_preset2.LeftLightVal
			leftsl.value = leftsp.value
			rightsp.value = $MrStudio_preset2.RightLightVal
			rightsl.value = rightsp.value
			backsp.value = $MrStudio_preset2.backLightVal
			backsl.value = backsp.value
			ambsp.value = $MrStudio_preset2.ambLightVal
			ambsl.value = ambsp.value 
			
			leftcp.color = $MrStudio_preset2.LeftLightCol	
			rightcp.color = $MrStudio_preset2.RightLightCol
			backcp.color = $MrStudio_preset2.BackLightCol
			ambcp.color = $MrStudio_preset2.AmbLightCol
			
			if bmpre_p2 != undefined then
			(preview.images = #(bmpre_p2, undefined, 1, 1, 1, 1, 1))
		)
		else 
		(
			presetretrieve preset1.state preset2.state preset3.state 
			leftsp.value = $MrStudio_initial.LeftLightVal
			leftsl.value = leftsp.value
			rightsp.value = $MrStudio_initial.RightLightVal
			rightsl.value = rightsp.value
			backsp.value = $MrStudio_initial.backLightVal
			backsl.value = backsp.value
			ambsp.value = $MrStudio_initial.ambLightVal
			ambsl.value = ambsp.value
			
			leftcp.color = $MrStudio_initial.LeftLightCol	
			rightcp.color = $MrStudio_initial.RightLightCol
			backcp.color = $MrStudio_initial.BackLightCol
			ambcp.color = $MrStudio_initial.AmbLightCol
						if preset1.state == off and preset2.state == off and preset3.state == off and bmpre_ini != undefined then
			(preview.images = #(bmpre_ini, undefined, 1, 1, 1, 1, 1))
		)
	)	

	on preset3 changed thestate do
	(
		if thestate == true then
		(
			preset1.state = false
			preset2.state = false
			presetretrieve preset1.state preset2.state preset3.state 
			leftsp.value = $MrStudio_preset3.LeftLightVal
			leftsl.value = leftsp.value
			rightsp.value = $MrStudio_preset3.RightLightVal
			rightsl.value = rightsp.value
			backsp.value = $MrStudio_preset3.backLightVal
			backsl.value = backsp.value
			ambsp.value = $MrStudio_preset3.ambLightVal
			ambsl.value = ambsp.value 
			
			leftcp.color = $MrStudio_preset3.LeftLightCol	
			rightcp.color = $MrStudio_preset3.RightLightCol
			backcp.color = $MrStudio_preset3.BackLightCol
			ambcp.color = $MrStudio_preset3.AmbLightCol
			if bmpre_p3 != undefined then
			(preview.images = #(bmpre_p3, undefined, 1, 1, 1, 1, 1))
		)
		else 
		(
			presetretrieve preset1.state preset2.state preset3.state 
			leftsp.value = $MrStudio_initial.LeftLightVal
			leftsl.value = leftsp.value
			rightsp.value = $MrStudio_initial.RightLightVal
			rightsl.value = rightsp.value
			backsp.value = $MrStudio_initial.backLightVal
			backsl.value = backsp.value
			ambsp.value = $MrStudio_initial.ambLightVal
			ambsl.value = ambsp.value
			
			leftcp.color = $MrStudio_initial.LeftLightCol	
			rightcp.color = $MrStudio_initial.RightLightCol
			backcp.color = $MrStudio_initial.BackLightCol
			ambcp.color = $MrStudio_initial.AmbLightCol
						if preset1.state == off and preset2.state == off and preset3.state == off and bmpre_ini != undefined then
			(preview.images = #(bmpre_ini, undefined, 1, 1, 1, 1, 1))
		)
	)	
	---------------------------------------------------------

	on LeftCp changed new_colL do
	(
		LeftLightCol = new_colL
		presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
		presetretrieve preset1.state preset2.state preset3.state 
	)
			
	on RightCp changed new_colR do
	(
		RightLightCol = new_colR
		presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
		presetretrieve preset1.state preset2.state preset3.state 
	)

	on BackCp changed new_colB do
	(
		BackLightCol = new_colB
		presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
		presetretrieve preset1.state preset2.state preset3.state 
	)

	on AmbCp changed new_colA do
	(
		AmblightCol = new_colA
		presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
		presetretrieve preset1.state preset2.state preset3.state 
	)


	-----------Is it slowing down?-----------
	on MrStudio mouseMove hobo do
	(
				if $MrStudio_FreeArea_Left == undefined then
				(
				Leftsp.enabled = false
				Leftsl.enabled = false
				)
				if $MrStudio_FreeArea_Right == undefined then
				(
				Rightsp.enabled = false
				Rightsl.enabled = false
				)
				if $MrStudio_FreeArea_Back == undefined then
				(
				Backsp.enabled = false
				Backsl.enabled = false
				)
				if $MrStudio_Ambient_Light == undefined then
				(
				Ambsp.enabled = false
				Ambsl.enabled = false
				)
	)
	---------------------------------------------
	on Leftsp changed val do
	(
		undo on
				(
				Leftsl.value = Leftsp.value
				--LeftLightVal = Leftsp.value
				presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
				presetretrieve preset1.state preset2.state preset3.state 
				)
	) 
	
	on Leftsl changed val do
	(						
		undo on
				(
				Leftsp.value = Leftsl.value
				--LeftLightVal = Leftsp.value
				presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
				presetretrieve preset1.state preset2.state preset3.state 
				)
	)
	
	on Rightsp changed val do
	(	
		undo on
	
				(
				Rightsl.value = Rightsp.value
			--	RightLightVal = Rightsp.value
				presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
				presetretrieve preset1.state preset2.state preset3.state 
				)
	)
	
	on Rightsl changed val do
	(	
		undo on
			(
			Rightsp.value = Rightsl.value
			--RightLightVal = Rightsp.value
			presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
			presetretrieve preset1.state preset2.state preset3.state 
			)
	)
	
	on Backsp changed val do
	(	
		undo on
				(
				Backsl.value = Backsp.value
				--BackLightVal = Backsp.value
				presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
				presetretrieve preset1.state preset2.state preset3.state 
				)
	)
	
	on Backsl changed val do
	(	
		undo on
			(
			Backsp.value = Backsl.value
			--BackLightVal = Backsp.value
			presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
			presetretrieve preset1.state preset2.state preset3.state 
			)
	)
	
	on Ambsp changed val do
	(		
		undo on
			(
			Ambsl.value = Ambsp.value
			--AmbLightVal = Ambsp.value/100
			presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
			presetretrieve preset1.state preset2.state preset3.state 
			)
	)
	
	on Ambsl changed val do
	(
		undo on
			(
			Ambsp.value = Ambsl.value
			--AmbLightVal = Ambsp.value/100
			presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
			presetretrieve preset1.state preset2.state preset3.state 
			)
	)

	on CreateStudio pressed do
	(
		if queryBox "Mr.Studio will change the Units Setup and Render Settings. Are you sure you want to continue?" then
		(
		undo on
	CrStudio ()
		if $MrStudio_FreeArea_Left != undefined or $MrStudio_FreeArea_Right != undefined or $MrStudio_FreeArea_Back != undefined or $MrStudio_Ambient_Light != undefined or $MrStudio_Ground != undefined then
		(
			Leftsp.enabled = true
			Leftsl.enabled = true
			Rightsp.enabled = true
			Rightsl.enabled = true
			Backsp.enabled = true
			Backsl.enabled = true
			Ambsp.enabled = true
			Ambsl.enabled = true
			CreateStudio.enabled = false
			presetrefresh preset1.state preset2.state preset3.state Leftsp.value Leftcp.color Rightsp.value Rightcp.color Backsp.value Backcp.color Ambsp.value Ambcp.color
		)
		)
	)
	
	on DeleteStudio pressed do
	(
		undo on
		try delete $MrStudio_FreeArea_Left catch ()
		try delete $MrStudio_FreeArea_Right catch ()
		try delete $MrStudio_FreeArea_Back catch ()
		try delete $MrStudio_Ambient_Light catch ()
		try delete $MrStudio_Ground catch ()
		CreateStudio.enabled = true
	)
		
		on previewAA changed val do
	(
		case previewAA.value of
		(
			1: (previewAA_minVal=-3
				previewAA_maxVal=-1
				previewAA_text.text="Min 1/64,Max 1/4"
				)
			2: (previewAA_minVal=-2
				previewAA_maxVal=0
				previewAA_text.text="Min 1/16,Max 1"
				)
			3:	(previewAA_minVal=-1
				previewAA_maxVal=1
				previewAA_text.text="Min 1/4,Max 4"
				)
			4:	(previewAA_minVal=0
				previewAA_maxVal=2
				previewAA_text.text="Min 1,Max 16"
				)
			5:	(previewAA_minVal=1
				previewAA_maxVal=3
				previewAA_text.text="Min 4,Max 64"
				)
		)
	)
	
		on previewSS changed val do
	(
		case previewSS.value of
		(
			1: (previewSSVal=8
				previewSS_text.text="8"
				)
			2: (previewSSVal=16
				previewSS_text.text="16"
				)
			3:	(previewSSVal=32
				previewSS_text.text="32"
				)
			4:	(previewSSVal=64
				previewSS_text.text="64"
				)
			5:	(previewSSVal=128
				previewSS_text.text="128"
				)
		)
	)

	on preview pressed do
	(
		if classof renderers.current == mental_ray_renderer then
		(
		AA_Current_min = renderers.current.MinimumSamples
		AA_Current_max = renderers.current.MaximumSamples
		renderers.current.MinimumSamples = PreviewAA_minVal
		renderers.current.MaximumSamples = PreviewAA_maxVal
		)
		if $MrStudio_FreeArea_Left != undefined then
		(
			LeftLightSamp = $MrStudio_FreeArea_Left.mr_NumAreaSamples
			$MrStudio_FreeArea_Left.mr_NumAreaSamples = PreviewSSVal
		)
		
		if $MrStudio_FreeArea_Right != undefined then
		(
			RightLightSamp = $MrStudio_FreeArea_Right.mr_NumAreaSamples
			$MrStudio_FreeArea_Right.mr_NumAreaSamples = PreviewSSVal
		)
		if $MrStudio_FreeArea_Back != undefined then
		(
			BackLightSamp = $MrStudio_FreeArea_Back.mr_NumAreaSamples
			$MrStudio_FreeArea_Back.mr_NumAreaSamples = PreviewSSVal
		)
		if $MrStudio_Ambient_Light != undefined then
		(
			AmbLightSamp = $MrStudio_Ambient_Light.projectorMap.samples
			$MrStudio_Ambient_Light.projectorMap.samples = PreviewSSVal
		)
case of
			(
			(preset1.state == on) : 
									(
									preview.images = undefined
									preview.caption = "Rendering Preview"
									bmpre_p1 = render  outputSize:[170,110] vfb:off quiet:false--progressbar:true
									preview.images = #(bmpre_p1, undefined, 1, 1, 1, 1, 1)
									try $MrStudio_FreeArea_Left.mr_NumAreaSamples = LeftLightSamp catch ()
									try $MrStudio_FreeArea_Right.mr_NumAreaSamples = RightLightSamp catch ()
									try $MrStudio_FreeArea_Back.mr_NumAreaSamples = BackLightSamp catch ()
									try $MrStudio_Ambient_Light.projectorMap.samples = AmbLightSamp catch ()
									)
			(preset2.state == on) : 
									(
									preview.images = undefined
									preview.caption = "Rendering Preview"
									bmpre_p2 = render  outputSize:[170,110] vfb:off quiet:false--progressbar:true
									preview.images = #(bmpre_p2, undefined, 1, 1, 1, 1, 1)
									try $MrStudio_FreeArea_Left.mr_NumAreaSamples = LeftLightSamp catch ()
									try $MrStudio_FreeArea_Right.mr_NumAreaSamples = RightLightSamp catch ()
									try $MrStudio_FreeArea_Back.mr_NumAreaSamples = BackLightSamp catch ()
									try $MrStudio_Ambient_Light.projectorMap.samples = AmbLightSamp catch ()
									)
			(preset3.state == on) : 
									(
									preview.images = undefined
									preview.caption = "Rendering Preview"
									bmpre_p3 = render  outputSize:[170,110] vfb:off quiet:false--progressbar:true
									preview.images = #(bmpre_p3, undefined, 1, 1, 1, 1, 1)
									try $MrStudio_FreeArea_Left.mr_NumAreaSamples = LeftLightSamp catch ()
									try $MrStudio_FreeArea_Right.mr_NumAreaSamples = RightLightSamp catch ()
									try $MrStudio_FreeArea_Back.mr_NumAreaSamples = BackLightSamp catch ()
									try $MrStudio_Ambient_Light.projectorMap.samples = AmbLightSamp catch ()
									)
			(preset1.state == off and preset2.state == off and preset3.state ==off) :
									(
									preview.images = undefined
									preview.caption = "Rendering Preview"
									bmpre_ini = render  outputSize:[170,110] vfb:off quiet:false--progressbar:true
									preview.images = #(bmpre_ini, undefined, 1, 1, 1, 1, 1)
									try $MrStudio_FreeArea_Left.mr_NumAreaSamples = LeftLightSamp catch ()
									try $MrStudio_FreeArea_Right.mr_NumAreaSamples = RightLightSamp catch ()
									try $MrStudio_FreeArea_Back.mr_NumAreaSamples = BackLightSamp catch ()
									try $MrStudio_Ambient_Light.projectorMap.samples = AmbLightSamp catch ()
									)
			)
					if classof renderers.current == mental_ray_renderer then
					(
					renderers.current.MinimumSamples = AA_Current_min
					renderers.current.MaximumSamples = AA_Current_max
					)
	)

		on help pressed do
		(
			messagebox "
			Mr.Studio is a tool to simulate studio lighting with Mental Ray. It has some features to simplify the control of lights
			and provide previews.
			
			Features
			-When you press Create Studio Button, Mr.Studio creates the bended ground plane and four lights. If there is some object or objects selected, 
			Studio will be built around the center of selection. Ground will be placed to the bottom of selection. Mr.Studio will inform you that it 
			will change unit and render settings. Save your important work before proceed.
			
			-Delete Studio button will delete the lights and ground plane, it doesnt effect the presets.
			
			-Left, Right and Back Lights are Photometric Area Lights. Their area sampling samples are set to 128. If you want you can increase or decrease
			this value or area sampling totally. Ambient Light is an omni light, which has a ambient occlusion shader as a projector map. It practically
			creates an overall ambient light with ambient occlusion. Ambient Occlusion options are accessible through its shader, which could be found in
			the second material slot.
			
			-It is possible to change each lights value and color interactively from ui. Slider and spinner values are synchronized for easier usage, but it
			is possible to go over slider limits using spinner values.
			
			-Preview button provides an easy overlook for direction and intensity of lights, softness of shadows, color of lights etc. It reduces sampling 
			values for both area lights and ambient light for reduce the preview rendering time.
			
			-There are three seperate Store buttons. While a store button is checked, all light and color values will be stored in corresponding 
			store button. These values will be stored in there with the project file. So closing and opening the script, even closing and opening Max wont 
			cause any loss.
			"
		)

	
	)
	
	
	
	createdialog MrStudio 190 470
	)


) 