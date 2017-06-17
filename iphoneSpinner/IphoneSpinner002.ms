
Flip_exp = Bezier_Float ()

for i= 1 to 72 do
(
	temp=copy $hedehot

	--movekeys temp (i*25)
	
	dongu = (4800/framerate)
	fulloffset = (4800/framerate)
	--pageCount=page_list_array.count
	spinExpVal=("SpinValue*"+(dongu as string)+(((72-i)*dongu)-(72*dongu)) as string                       )
	
	
	
	spinExpVal=("SpinValue*"+(dongu as string)+"*SeperationValue+"+"(seperationValue*"+(dongu as string)+")*("+(((72-i-1)-72)as string)+")")
	
	
	
	spinExp=float_expression()
	spinExp.AddScalarTarget "SpinValue" $SpinController.spinner.controller
	spinExp.AddScalarTarget "SeperationValue" $SpinController.seperation.controller
	
		addeasecurve temp.pos.controller.X_Position.controller Flip_exp
	temp.pos.controller.X_Position.controller[1].controller = spinExp
	temp.pos.controller.X_Position.controller[1].controller.setExpression spinExpVal
	
		addeasecurve temp.pos.controller.Y_Position.controller Flip_exp
	temp.pos.controller.Y_Position.controller[1].controller = spinExp
	temp.pos.controller.Y_Position.controller[1].controller.setExpression spinExpVal
	
		addeasecurve temp.pos.controller.Z_Position.controller Flip_exp
	temp.pos.controller.Z_Position.controller[1].controller = spinExp
	temp.pos.controller.Z_Position.controller[1].controller.setExpression spinExpVal
	
		addeasecurve temp.rotation.controller.X_Rotation.controller Flip_exp
	temp.rotation.controller.X_Rotation.controller[1].controller = spinExp
	temp.rotation.controller.X_Rotation.controller[1].controller.setExpression spinExpVal
	
			addeasecurve temp.rotation.controller.Y_Rotation.controller Flip_exp
	temp.rotation.controller.Y_Rotation.controller[1].controller = spinExp
	temp.rotation.controller.Y_Rotation.controller[1].controller.setExpression spinExpVal
	
			addeasecurve temp.rotation.controller.Z_Rotation.controller Flip_exp
	temp.rotation.controller.Z_Rotation.controller[1].controller = spinExp
	temp.rotation.controller.Z_Rotation.controller[1].controller.setExpression spinExpVal
	

	

	
)

SpinValue*2400+