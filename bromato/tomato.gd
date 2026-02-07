extends RigidBody3D

@export var splash_scene: PackedScene 

func _ready():
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(_on_impact)

func _on_impact(body):
	if splash_scene:
		var splash = splash_scene.instantiate()
		
		body.add_child(splash)
		splash.global_position = global_position
		splash.look_at(body.global_position)
		start_fade_out(splash)
	queue_free()

func start_fade_out(splash_node):
	var tween = create_tween()
	
	tween.tween_interval(3.0)
	tween.tween_property(splash_node, "albedo_mix", 0.0, 2.0)
	tween.finished.connect(splash_node.queue_free)
