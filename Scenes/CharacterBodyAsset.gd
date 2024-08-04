extends CharacterBody2D

var spritename="AlbertEinstein"
var rng = RandomNumberGenerator.new()

func _ready():
	await get_tree().create_timer(0.1).timeout
	if(spritename=="Painting2"):
		$CollisionShape2D.scale=Vector2(2,1)
	if(spritename=="Apple"):
		$".".scale=Vector2(2,2)
		$"../PickableButtonController".position.y=69.285

func _process(delta):
	$"Animations+Sprites".play(spritename)
	if($"../PickableButtonController/Falls".button_pressed==true):
		move_and_slide()
		#await get_tree().create_timer(0.1).timeout
		#$"Animations+Sprites".rotation_degrees+=rng.randf_range(-5.0, 5.0)


func _on_infront_or_behind_toggled(toggled_on):
	$".".z_index=int(toggled_on)


func _on_falls_toggled(toggled_on):
	$"../PickableButtonController/Falls/Delay".visible=toggled_on
	$"../PickableButtonController/Falls/WhoDoesItFallOn?".visible=toggled_on
