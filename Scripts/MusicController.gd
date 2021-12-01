extends Node2D

func _ready():
	get_node("MusicLevel" + String(Global.nextScene)).play()

func CaveMusic(body):
	get_node("MusicLevel" + String(Global.nextScene)).stop()
	if (not $MusicCave.is_playing()):
		$MusicCave.play()

func stopMusic(body):
	$MusicCave.stop()
	if (not get_node("MusicLevel" + String(Global.nextScene)).is_playing()):
		get_node("MusicLevel" + String(Global.nextScene)).play()
