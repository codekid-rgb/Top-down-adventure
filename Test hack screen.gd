extends Node2D
onready var le = get_node("VBoxContainer/LineEdit")
onready var terlog = get_node("VBoxContainer/TextEdit")

func _ready():
	terlog.text += "welcome to Nixos v21.11 bash v5 GNU/Linux\n"
func _on_LineEdit_text_entered(new_text):
	if le.text == "sudo -s":
		terlog.text += "user Zap is now root\n"
		le.text = ""
		le.placeholder_text = "[root@drivaca:~]$"
	if le.text == "ls":
		terlog.text += "Passwords.txt, evilAI.py, Zapstar.cpp, eAIplans.txt, evilspider.c, evilknight.jar, evilwizzard.js\n"
		le.text = ""
	if le.text == "vim Passwords.txt":
		terlog.text += "All of my random passwords start with 9 and end in a random number, they are 2 digit.\n"
		le.text = ""
	else:
		terlog.text += "Parse Error, not understood\n"
		le.text = ""
