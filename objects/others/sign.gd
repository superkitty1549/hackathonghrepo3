extends Node2D  # ✅ Keep this as Node2D

@export var messages: Array[String] = ["Hello, traveler!", "This is a sign.", "Press E to interact, and Enter to continue."]  

var player_near = false
var message_index = 0

@onready var dialog_ui = $"../DialogUI"  
@onready var dialog_text = $"../DialogUI/RichTextLabel"
@onready var area = $Area2D  # ✅ Reference Area2D

func _ready():
	dialog_ui.visible = false  # Hide dialog at start
	area.body_entered.connect(_on_body_entered)  # ✅ Ensure signal is connected
	area.body_exited.connect(_on_body_exited)

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		print("E Pressed!")  # Debugging
	if player_near and Input.is_action_just_pressed("interact"):
		print("Interacting with sign!")  # Debugging
		start_dialog()

func start_dialog():
	dialog_ui.visible = true
	message_index = 0
	show_message()

func show_message():
	if message_index < messages.size():
		dialog_text.text = messages[message_index]
	else:
		end_dialog()

func _input(event):
	if event.is_action_pressed("ui_accept") and dialog_ui.visible:
		message_index += 1
		show_message()

func end_dialog():
	dialog_ui.visible = false

func _on_body_entered(body):
	print("Something entered:", body.name)  # Debugging
	if body.is_in_group("player"):
		print("✅ Player entered sign area!")  # Debugging
		player_near = true

func _on_body_exited(body):
	print("Something exited:", body.name)  # Debugging
	if body.is_in_group("player"):
		print("✅ Player left sign area!")  # Debugging
		player_near = false
