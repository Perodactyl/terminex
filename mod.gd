extends Node
class_name Mod

var datastore = Data.getStore(self)

func fileName():
	return "unnamed" #What the filesystem stores to.

func displayName():
	return "Unnamed" #What the user sees

func help():
	return "" #Called when help is typed. Shows the string given, or can be given a dictionary.
	#If the return value is false-like it won't show a header for this mod's help.
	#You can also specify in the Dictionary:
	#show-header:false
	#It is recommended to use a Dictionary.

func load():
	pass #Any time it loads, including first run.
	# It is suggested to add an event handler like:
	# console.connect("line", self, "line")
	# A line would be a dictionary with two values: text, and handled
	# text is what the user typed.
	# at the end of handling if handled is set to false, it will say no such command was found.

func install():
	pass #First run

func save():
	Data.saveStore(self) #Save data.

func store(): #Used by the mod loader, don't overwrite.
	return datastore

func allow_cmds():
	#What commands should not cause an error about no command existing.
	var h = help()
	if h is Dictionary:
		return h.keys()
	else:
		return []

func uninstall():
	Godir.dir.remove("user://mods/"+fileName()+".data")
