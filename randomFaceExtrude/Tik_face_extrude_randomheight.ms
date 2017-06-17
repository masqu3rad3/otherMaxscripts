for i = 1 to (polyop.getnumfaces $) do
(
	polyop.setFaceSelection $ #{i}
	$.extrudeFaces (random 1 50)
)