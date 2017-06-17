for i in selection do
(
	for a = 112 to 420 by 4 do
	(
	
	index_posX=getkeyindex i.pos.controller.x_position.controller a
	if index_posX != 0 then (deletekey i.pos.controller.x_position.controller index_posX)

	index_posY=getkeyindex i.pos.controller.y_position.controller a
	if index_posY != 0 then (deletekey i.pos.controller.y_position.controller index_posY)
		
	index_posZ=getkeyindex i.pos.controller.z_position.controller a
	if index_posZ != 0 then (deletekey i.pos.controller.z_position.controller index_posZ)
		
	index_rotX=getkeyindex i.rotation.controller.x_rotation.controller a
	if index_rotX != 0 then (deletekey i.rotation.controller.x_rotation.controller index_rotX)
		
	index_rotY=getkeyindex i.rotation.controller.y_rotation.controller a
	if index_rotY != 0 then (deletekey i.rotation.controller.y_rotation.controller index_rotY)
		
	index_rotZ=getkeyindex i.rotation.controller.z_rotation.controller a
	if index_rotZ != 0 then (deletekey i.rotation.controller.z_rotation.controller index_posX)
	)
)


--deletekey $.pos.controller.x_position.controller 352