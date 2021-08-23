#NOTICE: This file gets rewritten when the game is run. If you want to make a mod, copy it to another file and edit it.
extends Mod

func fileName():
	return "baseGame"

func displayName():
	return "Base Game"

func load():
	datastore.startups += 1
	if datastore.corrupt:
		console.out.percent_visible = 0
		console.log(Utils.gibberish(10000))
		var timer:Timer = Utils.delay(0.01, self, "showMoreGibberish", [], {
			"one_shot":false
		})
		return
	console.connect("line", self, "line")
	if !datastore.gameStarted:
		console.log("Welcome to Terminex! Type help for a list of commands.")
	elif datastore.startups == 2:
		datastore.usedMod = false
		console.log("Hi! I'm bob. Your friendly terminal-hacking helper!")
		console.log("Sorry for that. I've been trying to reach you.")
		console.log("Use the \"mod\" command.")
	elif datastore.usedMod:
		console.log("Hi! I'm bob.")
	elif datastore.startups < 5:
		console.log("Seriously?! After all my attempts to reach you you just close me?!")
		console.log("Just use the \"mod\" command already.")
	else:
		datastore.gameEnded = true
		console.log("Game ending achieved:2", Color.cyan)
		console.log("User didn't obey bob.", Color.red)
		console.log("Use the \"restart\" command to play the game again")
	save()

func glitch_err(phaze:int=0):
	match phaze:
		0:
			console.log("Warning:System glitch detected.", Color.yellow)
			Utils.delay(2, self, "glitch_err", [1])
		1:
			console.log("ERR:Sys32CrashLogOffline.", Color.red)
			Utils.delay(0.3, self, "glitch_err", [2])
		2:
			console.log("StatusCode3ExitImminent.", Color.red)
			Utils.delay(0.4, self, "glitch_err", [3])
		3:
			console.log("SYSTERM", Color.red)
			Utils.delay(0.1, self, "glitch_err", [4])
		4:
			datastore.gameStarted = true
			save()
			Utils.tree().quit()

func install():
	datastore.corrupt = false
	datastore.gameEnded = false
	datastore.usedMod = false
	datastore.startups = 0
	datastore.gameStarted = false
	save()
	Utils.delay(5, self, "glitch_err")
	return false #False means no install message.

func help():
	return {
		"show-header":false,
		"help":"Shows command list",
		"mod":"Various mod controls. Use mods ? to find more.",
		"exit":"Close the terminal."
	}

func line(data:Dictionary):
	var t:String = data.text
	var reg = RegEx.new()
	reg.compile("(\\w+)\\s*(.*)")
	var result = reg.search(t)
	if !result:
		console.log(";[")
		return
	print(result.strings)
	var rawArgs = result.strings[2]
	var inQuot = false
	var args = []
	for thing in rawArgs.split(" ", false):
		if thing.begins_with("\""):
			inQuot = true
			var chars = thing.split("")
			chars.remove(0)
			args.append(chars.join(""))
		elif thing.ends_with("\"") && inQuot:
			inQuot = false
			var chars = thing.split("")
			chars.remove(len(chars)-1)
			args[len(args)] += (chars.join(""))
		elif inQuot:
			args[len(args)] += thing
		else:
			args.append(thing)
	if !datastore.gameEnded:
		match result.strings[1]:
			"help":
				if datastore.gameStarted:
					for mod in console.loadedMods:
						var h = mod.help()
						if !!h:
							var canShowHead = true
							if h is Dictionary:
								if ("show-header" in h && h["show-header"]) or !"show-header" in h:
									console.log("Mod: "+mod.displayName())
								var cmds = h.keys()
								cmds.erase("show-header")
								for cmd in cmds:
									console.log(cmd+"			"+h[cmd])
							if h is String:
								console.log("Mod: "+mod.displayName())
								console.log(h)
				elif !datastore.gameEnded:
					console.log("\"help\" Failed to execute because system tampering was detected.")
			"exit":
				if !datastore.gameStarted:
					datastore.corrupt = true
				save()
				Utils.tree().quit()
			"mod":
				datastore.usedMod = true
				save()
	else:
		if result.strings[1] == "restart":
			uninstall()
			Utils.tree().quit()
		else:
			console.log("A virus was detected on your terminal. No commands execution is allowed.", Color.orange)
func showMoreGibberish():
	console.out.percent_visible += 0.01
	if console.out.percent_visible == 1:
		uninstall()
		Utils.delay(2, self, "exit", [false])

func exit(doSave):
	if doSave:
		save()
	Utils.tree().quit()
