extends Node2D

export (float) var percent_froot : float = .75
export (Array, PackedScene) var fruits

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func random_spawn_position():
	rng.randomize()
		#will get a random number b/w room width
	var random_x = rng.randi_range(0,$Sprite.texture.get_width())
		#will get a random number b/w room height
	var random_y = rng.randi_range(0,$Sprite.texture.get_height())

func froot_spawn():
	rng.randomize()
	
	if rng.randf() < percent_froot: #less than this then spawn
		var froot = fruits[rng.randi_range(0,4)].instance()
		add_child(froot)
		froot.position = Vector2(random_spawn_position(),random_spawn_position()) #will spawn fruit at random x&y within room
	
