extends CharacterBody2D

var spritename="AlbertEinstein"

const SPEED = 200.0

var left=false
var talking=false
func _process(delta):
	if(talking==false):
		if(left==true):
			$SpriteSet.play(spritename+"Left")
		else:
			$SpriteSet.play(spritename+"Right")


func _on_talk_start_timer_timeout():
	talking=true
	if(left==true):
		$SpriteSet.play(spritename+"TalkingLeft")
	else:
		$SpriteSet.play(spritename+"TalkingRight")
	$TalkingFor.start()
	print("yes")

func _on_talking_for_timeout():
	talking=false

func _on_left_or_right_toggled(toggled_on):
	left=toggled_on

func _on_will_move_toggled(toggled_on):
	$"../ExternalCharacterSettings/WillMove/Movement Duration".visible=toggled_on
	$"../ExternalCharacterSettings/WillMove/Movement Delay".visible=toggled_on
	$"../ExternalCharacterSettings/WillMove/Movement Speed".visible=toggled_on

func _on_turns_toggled(toggled_on):
	$"../ExternalCharacterSettings/Turns?/Turn Delay".visible=toggled_on

func _on_turn_delay_timeout():
	if(left==true):
		$"..".dir=Vector2(1,0)
		left=false
		if(talking==true):
			$SpriteSet.play(spritename+"TalkingRight")
		else:
			$SpriteSet.play(spritename+"Right")
	else:
		$"..".dir=Vector2(-1,0)
		left=true
		if(talking==true):
			$SpriteSet.play(spritename+"TalkingLeft")
		else:
			$SpriteSet.play(spritename+"Left")

