extends Node


func getStore(mod):
	if Godir.dir.file_exists("user://mods/"+mod.fileName()+".data"):
		var contents = Godir.read_file("user://mods/"+mod.fileName()+".data")
		var dict = str2var(contents)
		print("Read a thing: ", dict)
		return dict
	return {}

func saveStore(mod):
	var data = mod.store()
	var string = var2str(data)
	Godir.write_file("user://mods/"+mod.fileName()+".data", string)
