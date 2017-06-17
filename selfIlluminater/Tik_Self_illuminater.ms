for i in sceneMaterials do
(
	(		
	for a = 1 to i.numsubs do
	(
		try
		(
	i.selfIllumAmount=100
			i.useSelfIllumColor = off
		i[a].selfIllumAmount=100
			
		)
	catch
		(	
			try 
			(
				i[a].selfIllumAmount=100
				i[a].useSelfIllumColor = off
			) 
		catch()
		)
	)
	)
)
	