macroScript TIK_CameraBG
category: "Tik Works"
tooltip: "Maya Style Camera BG"
ButtonText: "Maya Style Camera BG"
(
	animbuttonstate = false
	difmap = selectBitMap ()
	
	if difmap != undefined do
	(	
		-- **************** START MODIFICATION *****************
		if selection.count != 1 and classOf $ == FreeCamera or classOf $ == TargetCamera then	
		(
		bgcam = $ --if are some camera selected then use it
		)
		else
		(
			bgcam = FreeCamera() --create new free camera
			bgcam.transform = inverse (viewport.getTM()) --set the transform (PRS) to the viewport's ones
			bgcam.FOV = viewport.getFOV() --set the FOV to match the view
			viewport.setCamera bgcam --set the camera into the current viewport
			bgcam.name = uniquename "camera_with_bg"
		)
		if bgcam.fov.controller == undefined then bgcam.fov.controller = bezier_float () --if aren't controller in FOV then create it
		if bgcam.farrange.controller == undefined then bgcam.farrange.controller = bezier_float () --if aren't controller in far range then create it
		-- **************** END MODIFICATION *****************
		
		bgp = plane()
		bgp.name = uniquename "bg_plane"
		bgp.primaryVisibility = false
		bgp.receiveShadows = false
		bgp.castShadows = false
		bgp.showFrozenInGray = false
		bgp.motionBlurOn = false
		freeze bgp
		if bgcam.type == #target then
		(	
		cur = lookat_Constraint ()
			cur.appendTarget bgcam 100
			bgp.transform.controller = cur
		bgp.pos = bgcam.target.pos
		)
		else
		(
		bgp.rotation = bgcam.rotation
		bgp.pos = bgcam.pos
		)
		
		in coordsys local move bgp [0,0,-bgcam.farrange]
		bgp.parent = bgcam
		paramWire.connect bgcam.baseObject[#Far_Env_Range] bgp.pos.controller[#Z_Position] "-Far_Env_Range"
		
		tempex = "((Edge_b/sin(180 - (90+((radToDeg (Angle_a))/2)))) * (sin((radToDeg (Angle_a))/2)) * 2) / " + getRendImageAspect() as string
		
		bgp.length.controller = Float_Expression ()
		bgp.length.controller.AddScalarTarget "Angle_a" bgcam.fov.controller
		bgp.length.controller.AddScalarTarget "Edge_b" bgcam.farrange.controller
		bgp.length.controller.SetExpression tempex
		
		temppar = "length *" + getRendImageAspect() as string
		
		paramWire.connect bgp.baseObject[#length] bgp.baseObject[#width] temppar
		
		text_mat = bitmaptexture ()
		text_mat.bitmap = difmap
		
		bgp_mat = standardMaterial diffusemap:text_mat  selfIllumAmount:100 showInViewport:true
		bgp.material = bgp_mat
	)
) 