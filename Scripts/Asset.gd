extends Node2D

var ok=true
var clickable=false
var gettingdragged=false
var AnimationStarted=false
var charId=null
var Name

func _on_pickable_button_controller_transfer_type_of_asset(id):
	if(ok==true):
		charId=global.storedAssets.size()
		global.storedAssets.append($".")
		$CharacterBody2D.spritename=global.AssetNames[id]
		Name=id
		ok=false

func _process(delta):
	if(global.focusASSET!=charId):
		$PickableButtonController/InfrontOrBehind.hide()
	elif(AnimationStarted==false):
		$PickableButtonController/InfrontOrBehind.show()
	if(AnimationStarted==false):
		if(clickable==true and Input.is_action_pressed("click")):
			if(global.gettingdragged==false or gettingdragged==true):
				global.gettingdragged=true
				gettingdragged=true
				global.focusASSET=charId
				global_position=get_global_mouse_position()
				$CharacterBody2D/CollisionShape2D/Frame.show()
		else:
			if($CharacterBody2D/CollisionShape2D/Frame.visible==true):
				global.gettingdragged=false
				gettingdragged=false
				$CharacterBody2D/CollisionShape2D/Frame.hide()

func _on_character_body_2d_mouse_entered():
	clickable=true

func _on_character_body_2d_mouse_exited():
	clickable=false

func animationStart():
	AnimationStarted=true
	$PickableButtonController/InfrontOrBehind.hide()
