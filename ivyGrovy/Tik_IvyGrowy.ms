
boxArray=$box* as array
for i = 1 to boxArray.count do
(
	curHeight=boxArray[i].height
	firstF=(i*2)
	lastF=(i*2)+5
	boxArray[i].visibility = bezier_float()
	animate on
	(
	at time 0 boxArray[i].height=0
		
	addNewKey boxArray[i].visibility.controller 0
	at time 0 boxArray[i].visibility=off
		
	at time firstF boxArray[i].height=0
		
	addNewKey boxArray[i].visibility.controller firstF
	at time firstF boxArray[i].visibility=off
		
	addNewKey boxArray[i].visibility.controller (firstF+1)
	at time (firstF+1) boxArray[i].visibility=on
	
	at time lastF boxArray[i].height=curHeight
	)
)

/*
test = selection as array
for i =1 to test.count do
(
	test[i].visibility=bezier_float()
	animate on
	(
		addnewkey test[i].visibility.controller 0
		at time 0 test[i].visibility = 0
		addnewkey test[i].visibility.controller 20
		at time 20 test[i].visibility = 1
	)
)
*/