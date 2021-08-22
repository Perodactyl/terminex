extends Control


func _ready():
	OS.center_window()
	console.connect("line", self, "input")
	$inContainer/in/line.grab_focus()

func input(data):
	console.log(data.text)
