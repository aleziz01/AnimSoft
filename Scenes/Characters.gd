extends Node2D

var SceneId=-1
signal startAnimation

func animationStart():
	print("characteranimationstart")
	for i in global.storedCharacters.size():
		self.connect("startAnimation",global.storedCharacters[i].animationStart)
	emit_signal("startAnimation")
