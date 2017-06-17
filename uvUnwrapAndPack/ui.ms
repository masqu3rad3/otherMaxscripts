rollout unnamedRollout "Untitled" width:339 height:414
(
	spinner sp_uvChannel "UV Channel" pos:[22,20] width:84 height:16 range:[1,100,5] type:#integer
	button btn_FlattenUnwrap "Flatten Unwrap" pos:[180,67] width:140 height:25
	checkbox cb_flattenUnwrap "" pos:[26,70] width:16 height:20 checked:true
	button btn_uvPack "UV Pack" pos:[180,138] width:140 height:25
	checkbox cb_uvPack "" pos:[26,143] width:16 height:20 checked:true
	button btn_collapseMesh "Collapse Mesh" pos:[23,259] width:140 height:25
	button btn_shuffleUV "Shuffle UV" pos:[180,259] width:140 height:25
	checkbox cb_collapse "" pos:[26,228] width:16 height:20 checked:true
	checkbox cb_shuffleUv "" pos:[180,228] width:16 height:20 checked:true
	spinner sp_sourceUV "source UV" pos:[232,206] width:84 height:16 range:[1,100,5] type:#integer
	spinner sp_targetUv "target UV  " pos:[232,232] width:84 height:16 range:[1,100,5] type:#integer
	button bt_runAllChecked "Run All Checked" pos:[180,314] width:140 height:25
	progressBar pb1 "ProgressBar" pos:[19,374] width:302 height:27
	groupBox grp_autoUvUnwrap "Auto UV Unwrap" pos:[12,50] width:315 height:54
	groupBox grp_AutoUvPack "Auto UV Pack" pos:[12,121] width:315 height:54
	groupBox grp_collapseShuffle "Collapse and Shuffle" pos:[12,190] width:315 height:110
)