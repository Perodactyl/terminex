#NOTICE: This file gets rewritten when the game is run. If you want to make a mod, copy it to another file and edit it.
extends Mod

func fileName():
	return "baseGame"

func displayName():
	return "Base Game"

func load():
	datastore.foobar += 1
	console.log("Testing: "+String(datastore.foobar))
	save()

func install():
	datastore.foobar = 0
	save()
