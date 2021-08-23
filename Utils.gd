extends Node


func delay(time:float, node:Node, callback:String, binds:Array=[], settings:Dictionary={}):
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "delay_finished", [timer, node, callback, binds])
	timer.one_shot = true
	if settings:
		for setting in settings:
			timer.set(setting, settings[setting])
	timer.start(time)
	return timer

func delay_finished(timer, node, callback, binds):
	if timer.one_shot:
		timer.queue_free()
	if node:
		node.callv(callback, binds)

func tree():
	return get_tree() #Loaded mods can't use get_tree() for some reason.

func gibberish(length:int=1, randSeed:String=""):
	var rng = RandomNumberGenerator.new()
	if randSeed:
		rng.seed(randSeed)
	rng.randomize()
	var output = ""
	for i in range(length):
		var charcode = rng.randi_range(32, 126)
		output += char(charcode)
	return output
