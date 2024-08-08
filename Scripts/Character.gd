extends Node2D

var speed=200.0
var dir=Vector2(1,0)

var moving:=false
var ok:=true
var clickable:=false
var gettingdragged:=false
var AnimationStarted:=false
var charId:=-1
var SceneId:=-1
var Name

func _on_pickable_button_controller_transfer_type_of_character(CharacterId,Sceneid):
	if(ok==true):
		SceneId=Sceneid
		charId=global.storedCharacters.size()
		global.storedCharacters.append($".")
		$AnimationController.spritename=global.CharacterNames[CharacterId]
		Name=CharacterId
		ok=false

#dragndrop
func _process(delta):
	if(global.focus!=charId):
		$ExternalCharacterSettings.hide()
	elif(AnimationStarted==false):
		$ExternalCharacterSettings.show()
	if(AnimationStarted==false):
		if(clickable==true and Input.is_action_pressed("click")):
			if(global.gettingdragged==false or gettingdragged==true):
				global.gettingdragged=true
				gettingdragged=true
				global.focus=charId
				global_position=get_global_mouse_position()
				$AnimationController/CollisionShape2D/Frame.show()
		else:
			if($AnimationController/CollisionShape2D/Frame.visible==true):
				global.gettingdragged=false
				gettingdragged=false
				$AnimationController/CollisionShape2D/Frame.hide()
	elif(moving==true):
		position+=delta*speed*dir
	

func _on_character_body_2d_mouse_entered():
	clickable=true

func _on_character_body_2d_mouse_exited():
	clickable=false
#dragndropend

var talking:=false
func _on_checkif_talks_toggled(toggled_on):
	talking=toggled_on
	if(toggled_on==true):
		$ExternalCharacterSettings/CheckifTalks/TalkAnimationDelayTextEdit.show()
		$ExternalCharacterSettings/CheckifTalks/TalkAnimationDuration.show()
	else:
		$ExternalCharacterSettings/CheckifTalks/TalkAnimationDelayTextEdit.hide()
		$ExternalCharacterSettings/CheckifTalks/TalkAnimationDuration.hide()
		$ExternalCharacterSettings/CheckifTalks/TalkAnimationDelayTextEdit.text=""
		$ExternalCharacterSettings/CheckifTalks/TalkAnimationDuration.text=""



func _on_talk_animation_delay_text_edit_text_changed():
	$AnimationController/TalkStartTimer.wait_time=int($ExternalCharacterSettings/CheckifTalks/TalkAnimationDelayTextEdit.text)

func _on_talk_animation_duration_text_changed():
	$AnimationController/TalkingFor.wait_time=int($ExternalCharacterSettings/CheckifTalks/TalkAnimationDuration.text)

var animationAlreadyStarted=false

func ChangeYposition():
	$AnimationController.position.y-=5
	while(moving):
		await get_tree().create_timer(0.5).timeout
		$AnimationController.position.y-=5
		await get_tree().create_timer(0.5).timeout
		$AnimationController.position.y+=5

func animationStart():
	if(SceneId==global.selectedSceneId and animationAlreadyStarted==false):
		$AnimationController/CollisionShape2D.disabled=false
		animationAlreadyStarted=true
		if($"ExternalCharacterSettings/Turns?/Turn Delay".visible==true):
			$AnimationController/TurnDelay.wait_time=int($"ExternalCharacterSettings/Turns?/Turn Delay".text)
			$AnimationController/TurnDelay.start()
		if(talking==true):
			$AnimationController/TalkStartTimer.start()
		$ExternalCharacterSettings.hide()
		AnimationStarted=true
		if($"ExternalCharacterSettings/WillMove/Movement Duration".visible==true):
			await get_tree().create_timer(int($"ExternalCharacterSettings/WillMove/Movement Delay".text)).timeout
			if($AnimationController.left==true):
				dir=Vector2(-1,0)
			else:
				dir=Vector2(1,0)
			speed=float($"ExternalCharacterSettings/WillMove/Movement Speed".text)
			moving=true
			ChangeYposition()
			$MOVEMENTSKATEBOARDYEAH.show()
			$MOVEMENTSKATEBOARDYEAH.play("Moving")
			await get_tree().create_timer(int($"ExternalCharacterSettings/WillMove/Movement Duration".text)).timeout
			$MOVEMENTSKATEBOARDYEAH.hide()
			$AnimationController.position.y=0
			moving=false
	elif(SceneId!=global.selectedSceneId):
		$AnimationController/CollisionShape2D.disabled=true
