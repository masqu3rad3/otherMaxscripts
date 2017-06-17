minLength=10
maxLength=50
iteration=25
EndFrame=100
EndOffset=25
MaxBendGizmoRot=260
MaxBendDirection=300
tangentType=#auto
MaxArea=2
MaxMove=50
MaxSpin=150

for i = 1 to iteration do
(
tempShp=splineShape() --New Spline Shape
tempShp.name=uniquename "orlon"
addNewSpline tempShp
randLength=random 10 50
for x = 0 to randLength do --Spline Length Loop
(
	addKnot tempShp 1 #smooth #line [0,x,0]
)
--Noise Modifiers
NoiseY=noiseModifier()
NoiseZ=noiseModifier()
NoiseY.seed=random 1 99999
NoiseZ.seed=random 1 99999
NoiseY.scale=random 7 12
NoiseZ.scale=random 7 12
NoiseZ.fractal=true
NoiseY.fractal=true
NoiseZ.strength=[0,0,random 5 12]
NoiseY.strength=[0,random 5 12,0]
--Bend Modifier
Crumble=BendMod()
Crumble.BendAxis=1
Crumble.angle=random 0 900
Crumble.direction=random -MaxBendDirection MaxBendDirection
Crumble.gizmo.rotation.x=random -MaxBendGizmoRot MaxBendGizmoRot
Crumble.gizmo.rotation.y=random -MaxBendGizmoRot MaxBendGizmoRot
Crumble.gizmo.rotation.z=random -MaxBendGizmoRot MaxBendGizmoRot

rotate tempShp (eulerangles  (random -360 360)  (random -360 360) (random -360 360))
move tempShp [(random -MaxArea MaxArea),  (random -MaxArea MaxArea), (random -MaxArea MaxArea)]

with animate on
(
	at time (EndFrame+(random -EndOffset EndOffset)) noiseY.strength=[0,0,random 1 3]
	at time (EndFrame+(random -EndOffset EndOffset)) noiseZ.strength=[0,0,random 1 3]
	at time (EndFrame+(random -EndOffset EndOffset)) crumble.angle=random 70 150
	at time (EndFrame+(random -EndOffset EndOffset)) tempShp.pos=[(random -MaxMove MaxMove),(random -MaxMove MaxMove),(random -MaxMove MaxMove)]
	at time (EndFrame+(random -EndOffset EndOffset)) in coordsys local tempShp.rotation  = eulerangles  (random -MaxSpin MaxSpin)  (random -MaxSpin MaxSpin) (random -MaxSpin MaxSpin) 
)

tempShp.pos.controller.X_Position.controller.keys[1].inTangentType=tangentType
tempShp.pos.controller.X_Position.controller.keys[2].inTangentType=tangentType
--setAfterORT tempShp.pos.controller.X_Position.controller #linear
tempShp.pos.controller.Y_Position.controller.keys[1].inTangentType=tangentType
tempShp.pos.controller.Y_Position.controller.keys[2].inTangentType=tangentType
--setAfterORT tempShp.pos.controller.Y_Position.controller #linear
tempShp.pos.controller.Z_Position.controller.keys[1].inTangentType=tangentType
tempShp.pos.controller.Z_Position.controller.keys[2].inTangentType=tangentType
--setAfterORT tempShp.pos.controller.Z_Position.controller #linear

addmodifier tempShp NoiseY
addmodifier tempShp NoiseZ
addmodifier tempShp Crumble
)