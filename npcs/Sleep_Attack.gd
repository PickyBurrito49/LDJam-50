extends Node2D

signal attack_arrived
signal attack_destroyed

onready var tween = $Tween

export var Can_Click :bool

var sprite_face
var sprite_texture

var target_sprites = ['beetrap', 'bobboar', 'chumpanzee', 'gouse', 'muck', 'parrilla', 'spidersheep', 'sporkupine', 'squirrk', 'zebrear']

func _ready():
	randomize()
	var sprite_pick =randi() % target_sprites.size()
	sprite_texture = target_sprites[sprite_pick]
	sprite_face = load('res://assets/icons/attackIcons/'+sprite_texture+'.png')
	$Sprite.texture = sprite_face
	tween.connect("tween_all_completed", self, '_on_tween_all_completed')
	yield(get_tree().create_timer(0.1), "timeout")
	emit_signal("attack_arrived")

func _unhandled_input(event):
	if event.is_echo():
		return

	if event.is_action_pressed("ui_primaryclick") and Can_Click == true:
		$AttackSuccess.emitting = true
		tween.interpolate_property(self, "scale", self.scale, Vector2(0,0), 1.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees, 355, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func _on_tween_all_completed():
	emit_signal("attack_destroyed")
	queue_free()


func _on_Area2D_mouse_entered():
	Can_Click = true

func _on_Area2D_mouse_exited():
	Can_Click = false
