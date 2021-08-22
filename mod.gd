extends Node
class_name Mod

var datastore = Data.getStore(self)

func fileName():
	return "unnamed" #What the filesystem stores to.

func displayName():
	return "Unnamed" #What the user sees

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
