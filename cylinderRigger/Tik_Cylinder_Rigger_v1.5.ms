
-- date:		22.05.2009
-- script: 		Cylinder Rigger
-- version:		1.5
-- written by:	Arda Kutlu
-- e-mail:		ardakutlu@gmail.com
-- web: http://www.ardakutlu.com

-- Description: It is intended to be used in animations of cylindirical objects on hard surfaces.
-- Any cylindirical object (Bottles, Cans, Batteries, Coins etc.) can be rigged with this script.
-- Actually any object can be rigged whether it is cylindirical or not, but x and y positions may not be as precise
--as in Cylinders.
--Although it can be used on the main object, it is strongly advised to use a simple primitive object 
--and parent the real one to it. And be sure you ALWAYS SAVE YOUR WORK before using the script. 
--I can not be held responsible for any data/time loss you may encounter while you are using Cylinder Rigger.

-- HOW TO USE:
-- 1. Select the objects you want to be rigged.
-- 1. Run the .ms file from Maxscript -> Run Script
-- Use the point helper named "Rig Controller" to rotate the object.
-- Rigged Objects will stay always in the correct z position whether it is cylindirical or not
-- But x and y positions may misposition depending on the shape. If it is a slightly Chamfered Cylinder it wont be noticeable, but if it is Teapot... welll..
-- Objects will rotate properly until they reach 90 degrees.

if selection.count != 0 then
(
for d in selection do 
	(
	----CREATE OBJECTS----
	Cylinder_Rigged = d
	addmodifier Cylinder_Rigged (edit_mesh())
	Cylinder_Reference =instance Cylinder_Rigged prefix:"Reference_Cylinder"
	--Cylinder_Reference.pos = Cylinder_Rigged.pos
	Cylinder_Reference.isHidden = true
	a=[Cylinder_reference.min.x,Cylinder_reference.min.y,Cylinder_reference.min.z]
	b=[Cylinder_reference.max.x,Cylinder_reference.min.y,Cylinder_reference.min.z]
	cap = (distance a b)/2
	Point_Controller = point prefix:"Point_Controller" centermarker:on axistripod:off box:off cross:off size:(cap/2)
	Dummy_Controller = point prefix:"Rig_Controller" centermarker:off axistripod:off box:on cross:off size:(cap*4)
	Point_Controller.pos = Cylinder_Rigged.pos
	Dummy_Controller.pos = Cylinder_Rigged.pos
	Point_Controller.parent = Dummy_Controller
	-------------------------------------------
		
		
	----CONTROLLER DEFINITIONS----
	ListControl = position_list()
	PositionScript1 = position_script()
	PositionScript2 = position_script()
	RotationScript1 = rotation_script()
	-------------------------------------------

	----ASSIGN VARIABLES TO CONTROLLERS--------
	PositionScript1.addnode "dum" Cylinder_Reference
	PositionScript1.addnode "point" Point_Controller
		
	--PositionScript1.addconstant "cap" Cylinder_Reference.radius
	
	PositionScript2.addnode "point" Point_Controller

	RotationScript1.addnode "point" Point_Controller

	-------------------------------------------

	----DEFINE SCRIPTS----
	PositionScript1.script = 
	"cap=" + (cap as string) + 
	"
	if point.rotation.y_rotation >= 0 then 
	(
	X = (((cap) - (cos( (point.rotation.y_rotation))*(cap))))
	)
	else
	(
	X = (-((cap) - (cos( (point.rotation.y_rotation))*(cap))))
	)
	if point.rotation.x_rotation <= 0 then
	(
	Y = (((cap) - (cos( (point.rotation.x_rotation))*(cap))))
	)
	else
	(
	Y = (-((cap) - (cos( (point.rotation.x_rotation))*(cap))))
	)
 zarray = for i in 1 to dum.numVerts collect
((getvert dum i).z)
Z = dum.pos.z-amin zarray 
	[ X, Y, Z ]
	"
	PositionScript2.script = 
	"
	point.pos
	"
	RotationScript1.script = 
	"
eulerangles ((point.rotation.x_rotation)) ((point.rotation.y_rotation)) ((point.rotation.z_rotation))
"
	-------------------------------------------

	----ASSIGN CONTROLLERS TO OBJECTS----

	Cylinder_Rigged.position.controller = ListControl
	Cylinder_Rigged.position.controller[1].controller=PositionScript1
	Cylinder_Rigged.position.controller[2].controller=PositionScript2

	Cylinder_Rigged.rotation.controller = RotationScript1

	Cylinder_Reference.position.controller = PositionScript2
	Cylinder_Reference.rotation.controller = RotationScript1

	---------------------------------------------
	)


)
else
(
	messagebox "Select at least one object"
 )  