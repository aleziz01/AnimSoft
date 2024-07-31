extends CharacterBody2D

var spritename="AlbertEinstein"

func _ready():
	await get_tree().create_timer(0.1).timeout
	if(spritename=="Painting2"):
		$CollisionShape2D.scale=Vector2(2,1)

func _process(delta):
	$"Animations+Sprites".play(spritename)


func _on_infront_or_behind_toggled(toggled_on):
	$".".z_index=int(toggled_on)
