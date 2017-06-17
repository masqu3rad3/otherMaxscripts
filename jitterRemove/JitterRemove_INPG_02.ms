--Jitter Remove
iter=4
SmoothPower=1
SmoothArray=#()
threshold=0.03--0.015 --Maximum Value Difference Between Keyframes
 NumSelectedTracks=trackviews.current.numSelTracks()
for i = 1 to NumSelectedTracks do
	for z = 1 to iter do
	(
		(
			SelTrack=trackviews.current.getSelected i
			
			

			for a = 0 to 100 do
			(
			index_=getkeyindex SelTrack a
			
						--print "hede"
						if index_ != 0 then 
							(
								preKeyValue=at time (a-1) SelTrack.value
								curKeyValue=at time (a) SelTrack.value
								nextKeyValue=at time (a+1) SelTrack.value
								--if (abs(preKeyValue-curKeyValue)>threshold) then
								--if abs((curKeyValue)+((preKeyValue+nextKeyValue)/2))>threshold then
								--if ((curKeyValue)-(preKeyValue))>threshold then
								if (abs((curKeyValue)-(preKeyValue)))>threshold then
								(
									if (isKeyselected SelTrack index_) then
									(
										Average=((	(preKeyValue)+(nextKeyValue))/2)/smoothPower 
										S=#(a,Average)

										append SmoothArray S
									
										with animate on
										(at time a SelTrack.value=((preKeyValue/smoothPower )+(nextKeyValue/smoothPower))/2 )
										--deletekey SelTrack index_
									)
								)

							
							)
					
					
				)
				
				---Second IT
					for a = 0 to 100 do
			(
			index_=getkeyindex SelTrack a
			
						--print "hede"
						if index_ != 0 then 
							(
								preKeyValue=at time (a-1) SelTrack.value
								curKeyValue=at time (a) SelTrack.value
								nextKeyValue=at time (a+1) SelTrack.value
								--if (abs(preKeyValue-curKeyValue)>threshold) then
								--if abs((curKeyValue)+((preKeyValue+nextKeyValue)/2))>threshold then
								--if ((curKeyValue)-(preKeyValue))>threshold then
								if (abs((curKeyValue)-(nextKeyValue)))>threshold then
								(
									if (isKeyselected SelTrack index_) then
									(
										Average=((	(preKeyValue)+(nextKeyValue))/2)/smoothPower 
										S=#(a,Average)

										append SmoothArray S
									
										with animate on
										(at time a SelTrack.value=((preKeyValue/smoothPower )+(nextKeyValue/smoothPower))/2 )
										--deletekey SelTrack index_
									)
								)
							)
				)--end of second it
		)
)
	/*
					for tr in SmoothArray do
				(
					with animate on
					(
					at time tr[1] SelTrack.value=tr[2]
					)
				)
*/

--print SmoothArray
