extends Node

signal line(data)

onready var consoleEl:Control = $"/root/base"
onready var inNode:LineEdit = consoleEl.get_node("inContainer/in/line")
onready var out:RichTextLabel = consoleEl.get_node("outContainer/out/text")
var debug = true
var loadedMods = []

func _ready():
	Godir.write_file("user://mods/baseGame.gd", Godir.read_file("res://baseGame.gd"))
	inNode.connect("text_entered", self, "lineIn")
	if Godir.dir.dir_exists("user://mods"):
		for file in Godir.list_files_in_directory("user://mods"):
			if file.ends_with(".gd"):
				var script = load("user://mods/"+file)
				var mod = Node.new()
				mod.set_script(script)
				if !Godir.dir.file_exists("user://mods/"+mod.fileName()+".data"):
					mod.install()
					console.log("installed mod: "+mod.displayName())
				mod.load()
				loadedMods.append(mod)
			elif file.ends_with(".data"):
				pass
			else:
				debug("Unrecognized file in mods directory: "+file)
	else:
		Godir.make_dir("user://mods")

func log(text:String, color:Color=Color.white, sanitizeText:bool=false):
	out.append_bbcode("[color=#"+color.to_html(false)+"]"+(sanitize(text) if sanitizeText else text)+"[/color]")
	out.append_bbcode("\n")

func say(text:String, color:Color=Color.white, sanitizeText:bool=false):
	return self.log(text, color, sanitizeText)

func debug(text):
	if debug:
		out.append_bbcode("[[color=#FF00FF] Debug [/color]]  ")
		say(text, Color.yellow)
func sanitize(text):
	var sanReg = RegEx.new()
	sanReg.compile("\\[")
	var results = sanReg.search_all(text)
	#ZWSP >​<
	return sanReg.sub(text, "[​", true)

func lineIn(text):
	var pack = {
		"text":text,
		"handled":false
	}
	inNode.text = ""
	emit_signal("line", pack)
