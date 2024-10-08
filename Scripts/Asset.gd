extends Node2D

var ok:=true
var clickable:=false
var gettingdragged:=false
var AnimationStarted:=false
var AssetId:=-1
var Name
var speed:=0
var SceneId:=-1

func _on_pickable_button_controller_transfer_type_of_asset(id,sceneid):
	if(ok==true):
		SceneId=sceneid
		AssetId=global.storedAssets.size()
		global.storedAssets.append($".")
		$CharacterBodyAsset.spritename=global.AssetNames[id]
		Name=id
		ok=false

func _process(delta):
	if(global.focusASSET!=AssetId):
		$PickableButtonController/Falls.hide()
		$PickableButtonController/InfrontOrBehind.hide()
	elif(AnimationStarted==false):
		$PickableButtonController/InfrontOrBehind.show()
		$PickableButtonController/Falls.show()
	if(AnimationStarted==false):
		if(clickable==true and Input.is_action_pressed("click")):
			if(global.gettingdragged==false or gettingdragged==true):
				global.gettingdragged=true
				gettingdragged=true
				global.focusASSET=AssetId
				global_position=get_global_mouse_position()
				$CharacterBodyAsset/CollisionShape2D/Frame.show()
		else:
			if($CharacterBodyAsset/CollisionShape2D/Frame.visible==true):
				global.gettingdragged=false
				gettingdragged=false
				$CharacterBodyAsset/CollisionShape2D/Frame.hide()
	else:
		position.y+=speed*delta
		
		

func _on_character_body_2d_mouse_entered():
	clickable=true

func _on_character_body_2d_mouse_exited():
	clickable=false

func animationStart():
	if(SceneId==global.selectedSceneId):
		$PickableButtonController.hide()
		if($PickableButtonController/Falls.button_pressed==true):
			await get_tree().create_timer(int($PickableButtonController/Falls/Delay.text)).timeout
			if($"PickableButtonController/Falls/WhoDoesItFallOn?".get_selected_id()==0):
				$CharacterBodyAsset.set_collision_mask_value(3,true)
			AnimationStarted=true
			while(speed<500):
				await get_tree().create_timer(0.1).timeout
				speed+=30
		else:
			speed=0
