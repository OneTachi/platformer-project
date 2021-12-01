extends Node
var txt 

func _on_MainMenu_pressed():
	get_tree().change_scene("res://TitleMenu.tscn")

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Level1.tscn")
	Global.nextScene = 1
	Global.hearts = 5

func _on_Next_pressed():
	get_tree().change_scene("res://Level" + str(Global.nextScene)+ ".tscn")

