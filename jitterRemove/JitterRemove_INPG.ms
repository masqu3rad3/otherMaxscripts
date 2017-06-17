--Jitter Remove
SmoothArray=#()
 NumSelectedTracks=trackviews.current.numSelTracks()
 for i = 1 to NumSelectedTracks do

(
	SelTrack=trackviews.current.getSelected i
	threshold=0.6
	
	for a = 0 to 100 do
	(
	index_=getkeyindex SelTrack a
	
		case of 
		(
		(classof SelTrack.value==Point3):
			(
				if index_ != 0 then 
					(
						preKeyValue=at time (a-1) SelTrack.value
						curKeyValue=at time (a) SelTrack.value
						nextKeyValue=at time (a+1) SelTrack.value
						if (abs(preKeyValue[1]-curKeyValue[1])>threshold) then
						(
							if (isKeyselected SelTrack index_) then
							(
								Average=(preKeyValue[1]+nextKeyValue[1])/2
								S=#(a,Average)

								append SmoothArray S
							
								--with animate on
								--(at time a SelTrack.value=(preKeyValue+nextKeyValue)/2)
								--deletekey SelTrack index_
							)
						)
					)
			
				
				for tr in SmoothArray do
				(
					with animate on
					(
					at time tr[1] SelTrack.value=tr[2]
					)
				)
				
			)
		(classof SelTrack.value==Integer or classof Seltrack.value==Float):
			(
				if index_ != 0 then 
					(
						preKeyValue=at time (a-1) SelTrack.value
						curKeyValue=at time (a) SelTrack.value
						nextKeyValue=at time (a+1) SelTrack.value
						if (abs(preKeyValue-curKeyValue)>threshold) then
						(
							if (isKeyselected SelTrack index_) then
							(
								Average=(preKeyValue+nextKeyValue)/2
								S=#(a,Average)

								append SmoothArray S
							
								--with animate on
								--(at time a SelTrack.value=(preKeyValue+nextKeyValue)/2)
								--deletekey SelTrack index_
							)
						)
					)
			
				
				for tr in SmoothArray do
				(
					with animate on
					(
					at time tr[1] SelTrack.value=tr[2]
					)
				)
			)
		)
	)
	

)
print SmoothArray
