fn flattenUnwrap uvChannel objs=
	(
	if (getCommandPanelTaskMode() != #modify) do setCommandPanelTaskMode #modify
		(
			select objs
			--removeSubSel = (Poly_Select ())
			--addModifier o removeSubSel
			uvMod = (Unwrap_uvw())
			uvMod.setApplyToWholeObject true
			uvMod.setMapChannel uvChannel
			addModifier objs uvMod ui:true
			uvMod.flattenMap 45.0 #([1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1]) 0.02 true 0 true true
		)
	)
	
	fn UnwrapOnly uvChannel objs=
	(
	if (getCommandPanelTaskMode() != #modify) do setCommandPanelTaskMode #modify
		(
			--select o
			--removeSubSel = (Poly_Select ())
			--addModifier o removeSubSel
			uvMod = (Unwrap_uvw())
			uvMod.setApplyToWholeObject true
			uvMod.setMapChannel uvChannel
			addModifier objs uvMod ui:true
		)
	)

fn UVPack sourceUV targetUV objs=
	(

		(
			p = UVPacker()
			p.show_preview = false
			addmodifier objs p
			
			p.use_source = true
			p.source_channel = sourceUV
			p.channel = targetUV
			p.pack()
		)
	)
	
fn collapseFN objs=
	(

		(
			collapseStack objs
		)
	)
	
fn shuffleUV sourceUv targetUv objs=
(
		(
		channelInfo.copychannel objs 3 sourceUv
		channelInfo.PasteChannel objs 3 targetUv
		)
		
)
	

global tik_uvUnwrap
try(destroyDialog tik_uvUnwrap)catch()

rollout tik_uvUnwrap "Tik UV Unwrap n'Pack v0.01" width:339 height:414
(
	spinner sp_uvChannel "UV Channel" pos:[50,20] width:84 height:16 range:[1,100,5] type:#integer
	
	button btn_Unwrap "Unwrap Only" pos:[180,20] width:140 height:25
	groupBox grp_autoUvUnwrap "Auto UV Unwrap" pos:[12,50] width:315 height:54
	checkbox cb_flattenUnwrap "" pos:[26,70] width:16 height:20 checked:true
	button btn_FlattenUnwrap "Unwrap & Flatten" pos:[180,67] width:140 height:25

	groupBox grp_AutoUvPack "Auto UV Pack" pos:[12,121] width:315 height:54
	checkbox cb_uvPack "" pos:[26,143] width:16 height:20 checked:true
	button btn_uvPack "UV Pack" pos:[180,138] width:140 height:25

	groupBox grp_collapseShuffle "Collapse and Shuffle" pos:[12,190] width:315 height:110
	checkbox cb_collapse "" pos:[26,228] width:16 height:20 checked:true
	checkbox cb_shuffleUv "" pos:[180,228] width:16 height:20 checked:true
	spinner sp_sourceUV "source UV" pos:[232,206] width:84 height:16 range:[1,100,5] type:#integer
	spinner sp_targetUv "target UV  " pos:[232,232] width:84 height:16 range:[1,100,5] type:#integer
	button btn_collapseMesh "Collapse Mesh" pos:[23,259] width:140 height:25
	button btn_shuffleUV "Shuffle UV" pos:[180,259] width:140 height:25
	
	button btn_runAllChecked "Run All Checked" pos:[180,314] width:140 height:25
	progressBar pb1 "ProgressBar" pos:[19,374] width:302 height:27
	
	on btn_Unwrap pressed do
		(
		objectList=selection as array
		for xo = 1 to objectList.count do
		(
		pb1.value = 100.*xo/objectList.count
		if cb_flattenUnwrap.state == true then
		(UnwrapOnly sp_uvChannel.value objectList[xo])
		)
		pb1.value = 0
		)
	
	on btn_FlattenUnwrap pressed do
		(
		objectList=selection as array
		for xo = 1 to objectList.count do
		(
		pb1.value = 100.*xo/objectList.count
		if cb_flattenUnwrap.state == true then
		(flattenUnwrap sp_uvChannel.value objectList[xo])
		)
		pb1.value = 0
		)
	
	on btn_uvPack pressed do
		(
		objectList=selection as array
		for xo = 1 to objectList.count do
		(
		pb1.value = 100.*xo/objectList.count
		if cb_uvPack.state == true then
		(UVPack sp_uvChannel.value sp_uvChannel.value objectList[xo])
		)
		pb1.value = 0
		)
	
	on btn_collapseMesh pressed do
		(
		objectList=selection as array
		for xo = 1 to objectList.count do
		(
		pb1.value = 100.*xo/objectList.count
		if cb_collapse.state == true then
		(collapseFN objectList[xo])
		)
		pb1.value = 0
		)
	
	on btn_shuffleUV pressed do
		(
		objectList=selection as array
		for xo = 1 to objectList.count do
		(
		pb1.value = 100.*xo/objectList.count
		if cb_shuffleUv.state == true then
		(shuffleUV sp_sourceUV.value sp_targetUV.value objectList[xo])
		)
		pb1.value = 0
		)
	
	on btn_runAllChecked pressed do
	(
		disableSceneRedraw()
		objectList=selection as array
		for xo = 1 to objectList.count do
		(
		pb1.value = 100.*xo/objectList.count
		if cb_flattenUnwrap.state == true then
		(flattenUnwrap sp_uvChannel.value objectList[xo])
		
		if cb_uvPack.state == true then
		(UVPack sp_uvChannel.value sp_uvChannel.value objectList[xo])
		
		if cb_shuffleUv.state == true then
		(shuffleUV sp_sourceUV.value sp_targetUV.value objectList[xo])
		
		if cb_collapse.state == true then
		(collapseFN objectList[xo])
		)
		pb1.value = 0
		enableSceneRedraw()
	)
)



createDialog tik_uvUnwrap 339 414