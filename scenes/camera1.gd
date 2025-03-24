extends Area2D

@export var next_camera: Camera2D  # Assign this in the Inspector

func _ready():
	print(name, " is ready!")  # Debugging message

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("✅ Player entered:", name)  # Debug message to confirm collision
		if next_camera:
			print("🔄 Switching to camera:", next_camera.name)  # Debug message
			next_camera.make_current()
		else:
			print("❌ next_camera is NOT assigned!")
