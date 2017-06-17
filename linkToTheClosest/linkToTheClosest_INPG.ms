pointArray=$point* as array
boxArray=$box* as array
 for b in boxArray do
 (
	 distanceArray=#()
	 for  p in pointArray do
	 (
		tempDis= distance p b
		 --print tempDis
		 append distanceArray tempDis
	 )
		shortestDistance=amin distanceArray
		closestPointIndex=findItem distanceArray shortestDistance
		b.parent=pointArray[closestPointIndex]
	 
 )