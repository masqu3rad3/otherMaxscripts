fn flattenUnwrap uvChannel=
	(
	max modify mode
	selObjsArr = selection as array
	for o in selObjsArr do
		(
			select o
			removeSubSel = (Poly_Select ())
			addModifier o removeSubSel
			uvMod = (Unwrap_uvw())
			uvMod.setMapChannel uvChannel
			addModifier o uvMod ui:true
			uvMod.flattenMap 45.0 #([1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1]) 0.02 true 0 true true
		)
	)
	
	fn UnwrapOnly uvChannel=
	(
	max modify mode
	selObjsArr = selection as array
	for o in selObjsArr do
		(
			select o
			uvMod = (Unwrap_uvw())
			uvMod.setMapChannel uvChannel
			addModifier o uvMod ui:true
		)
	)

fn UVPack sourceUV targetUV=
	(
	selObjsArr = selection as array
	for o in selObjsArr do
		(
			p = UVPacker()
			p.show_preview = false
			addmodifier o p
			
			p.use_source = true
			p.source_channel = sourceUV
			p.channel = targetUV
			p.pack()
		)
	)
	
fn collapseFN =
	(
	selObjsArr = selection as array
	for o in selObjsArr do
		(
			collapseStack o
		)
	)
	
fn shuffleUV sourceUv targetUv =
(
	selObjsArr = selection as array
	for o in selObjsArr do
		(
		channelInfo.copychannel o 3 sourceUv
		channelInfo.PasteChannel o 3 targetUv
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
	(UnwrapOnly sp_uvChannel.value)
	
	on btn_FlattenUnwrap pressed do
	(flattenUnwrap sp_uvChannel.value)
	
	on btn_uvPack pressed do
	(UVPack sp_uvChannel.value sp_uvChannel.value)
	
	on btn_collapseMesh pressed do
	(collapseFN())
	
	on btn_shuffleUV pressed do
	(shuffleUV sp_sourceUV.value sp_targetUV.value)
	
	on btn_runAllChecked pressed do
	(
		if cb_flattenUnwrap.state == true then
		(flattenUnwrap sp_uvChannel.value)
		
		if cb_uvPack.state == true then
		(UVPack sp_uvChannel.value sp_uvChannel.value)
		
		if cb_shuffleUv.state == true then
		(shuffleUV sp_sourceUV.value sp_targetUV.value)
		
		if cb_collapse.state == true then
		(collapseFN())
	)
)



createDialog tik_uvUnwrap 339 414