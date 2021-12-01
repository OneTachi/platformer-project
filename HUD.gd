extends CanvasLayer

var coins = 0
var bonusCoins = 0
var numCoins = 0

func _ready():
	$backpanel/Coins.text = String(coins)
	$backpanel/Hearts.text = String(Global.hearts)
	$rempanel/Coins2.text = String(numCoins - coins)
	$rempanel/bonusCoins.text = String(bonusCoins)

func _on_coin_exists():
	numCoins = numCoins + 1

func _on_bonus_exists():
	bonusCoins = bonusCoins + 1

func _on_coin_collected():
	coins = coins + 1
	_ready()
	if coins == numCoins:
		get_tree().change_scene("res://WinMenu.tscn")
		Global.nextScene = Global.nextScene + 1
		Global.hearts = 5
		coins = 0
		numCoins = 0
		bonusCoins = 0

func _on_bonusCoin_collected():
	bonusCoins = bonusCoins - 1
	_ready()


