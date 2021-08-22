#NOTICE: This file gets rewritten when the game is run. If you want to make a mod, copy it to another file and edit it.
extends Mod

func fileName():
	return "baseGame"

func displayName():
	return "Base Game"

func load():
	console.connect("line", self, "line")
	console.log("Welcome to Terminex! Type help for a list of commands.")
	save()

func install():
	save()

func help():
	return {
		"show-header":false,
		"help":"Shows command list",
		"mods":"Various mod controls. Use mods ? to find more."
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
	match result.strings[1]:
		"help":
			for mod in console.loadedMods:
				var h = mod.help()
				if !!h:
					var canShowHead = true
					if h is Dictionary:
						if "show-header" in h:
							console.log("Mod: "+mod.displayName())
						var cmds = h.keys()
						cmds.erase("show-header")
						for cmd in cmds:
							console.log(cmd+"			"+h[cmd])
					if h is String:
						console.log("Mod: "+mod.displayName())
						console.log(h)
