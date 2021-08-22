extends Control


func _ready():
	OS.center_window()
	console.connect("line", self, "input")

func input(data):
	console.log(data.text)
