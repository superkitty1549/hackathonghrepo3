extends Node2D

@export var messages: Array[String] = ["Huh.. Where am I? (space or enter to continue)", "It's so eerily quiet here... wonder if there's anyone else here?", "Oh... this is so weird...", "Etched in the back of this sign says...","Herein lies the remains of the former glorious ChuChu Island.","Wait, wasn't ChuChu Island that one place we learned about in school?","The greatest island to ever exist, or whatever. Supposedly nothing ever went wrong. Well, we'll see about that.","Hmm, seems like the only thing that isn't super weird is these purple circles on the ground...","I guess I'll follow them and see where that takes me."]

var player_near = false
var message_index = 0

@onready var dialog_ui = $DialogUI  # Ensure this node exists!
@onready var dialog_text = $DialogUI/Control/RichTextLabel
@onready var area = $Area2D  # Ensure this exists!

func _ready():
	dialog_ui.visible = false  # Hide dialog at start
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited) 

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		print("E Pressed!")  # Debugging


	if player_near and Input.is_action_just_pressed("interact"):
		print(" Starting dialogue!")
		start_dialog()
	
	if dialog_ui.visible and Input.is_action_just_pressed("ui_accept"):  # Press 'Enter' to continue
		show_message()


func start_dialog():
	print("Showing dialogue!")  # Debugging
	dialog_ui.visible = true
	message_index = 0
	show_message()

func show_message():
	if message_index < messages.size():  
		dialog_text.text = messages[message_index]  # Show current message
		message_index += 1  # Move to the next message
	else:
		dialog_ui.visible = false  # Hide UI when all messages are shown
		message_index = 0  # Reset for next interaction


func _on_body_entered(body):
	if body.name == "Player":
		player_near = true
		print("Player entered sign area")

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		print("Player left sign area")
