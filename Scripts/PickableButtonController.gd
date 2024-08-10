extends Node2D

var BackgroundTextures:=[]
var Scenes:=[]
var CharacterNode:=preload("res://Scenes/Character.tscn")
var AssetNode:=preload("res://Scenes/asset.tscn")
#descriptions
var AlbertEinsteinText:="Albert Einstein was a German theoretical physicist who is widely held as one of the most influential scientists. He is best known for his theory of relativity and his contributions to quantum mechanics. He received the 1921 Nobel Prize in physics, mainly for his discovery of the law of the photoelectric effect. His intellectual achievements and originaility have made the word Einstein synonymous to genius."
var IsaacNewtonText:="Isaac Newton was a mathematician, physicist, astronomer, alchemist, theologian, and author who was described as a natural philosopher. He was a key figure in the Scientific revolution and the Enlightenment that followed it. His book Philosophiæ Naturalis Principia Mathematica, first published in 1687, established classical mechanics. Newton also made contributions to optics, and shares credit with German mathematician Gottfried Wilhelm Leibniz for formulating infinitesmal calculus."
var WilliamShakespeareText:="William Shakespeare was a"
var MihaiEminescuText:="Mihai Eminescu was a..."
var BenjaminFranklinText:="Benjamin Franklin was a..."
var IonCreangaText:="Ion Creanga was a..."
var IonGhicaText:="Ion Ghica was a..."
var NeilArmstrongText:="Neil Armstrong was a..."
var WiseJapaneseManText:="This japanese man was a professor, but now he has chosen to live a long, peaceful life"
var SmartFemaleTeacherText:="This teacher is really chill!"
var AngryFemaleTeacherText:="This teacher is not really chill at all..."
var ScientistText:="Science guy!!!"
var MugurIsarescuText:="Mugur Isarescu is a..."
var Boy1Text:="This is a first grader!"
var Boy2Text:="This is a first grader!"
var Girl1Text:="This is a first grader!"
var Girl2Text:="This is a first grader!"

var animStarted:=false
var CharacterDescriptions:=[]
signal transferTypeOfCharacter
signal transferTypeOfAsset
signal startAnimation
func _ready():
	Scenes.append($"../../Scenes/AnimationScene")
	$AssetAdder.get_popup().connect("id_pressed", _on_AssetAdder_pressed)
	$CharacterAdder.get_popup().connect("id_pressed", _on_CharacterAdder_pressed)
	$CharacterAdderPage2.get_popup().connect("id_pressed",_on_CharacterAdder_pressed)
	BackgroundTextures.append(preload("res://Art/Backgrounds/BackgroundRandom.png"))
	BackgroundTextures.append(preload("res://Art/Backgrounds/stage.png"))
	BackgroundTextures.append(preload("res://Art/Backgrounds/isaac newton's tree.png"))
	CharacterDescriptions.append(AlbertEinsteinText)
	CharacterDescriptions.append(IsaacNewtonText)
	CharacterDescriptions.append(WilliamShakespeareText)
	CharacterDescriptions.append(MihaiEminescuText)
	CharacterDescriptions.append(BenjaminFranklinText)
	CharacterDescriptions.append(IonCreangaText)
	CharacterDescriptions.append(IonGhicaText)
	CharacterDescriptions.append(NeilArmstrongText)
	CharacterDescriptions.append(WiseJapaneseManText)
	CharacterDescriptions.append(SmartFemaleTeacherText)
	CharacterDescriptions.append(AngryFemaleTeacherText)
	CharacterDescriptions.append(ScientistText)
	CharacterDescriptions.append(MugurIsarescuText)
	CharacterDescriptions.append(Boy1Text)
	CharacterDescriptions.append(Boy2Text)
	CharacterDescriptions.append(Girl1Text)
	CharacterDescriptions.append(Girl2Text)

var fading=false
func FadeInAndOut():
	fading=true
	while($"../../FadeInnOut".self_modulate.a<1):
		await get_tree().create_timer(0.01).timeout
		$"../../FadeInnOut".self_modulate.a+=2.0/255.0
	await get_tree().create_timer(1).timeout
	while($"../../FadeInnOut".self_modulate.a>0):
		await get_tree().create_timer(0.01).timeout
		$"../../FadeInnOut".self_modulate.a-=2.0/255.0
	fading=false
	

func _process(delta):
	if(global.focus>=0):
		$CharacterDescription.text=CharacterDescriptions[global.storedCharacters[global.focus].Name]
	if(animStarted==true):
		if Input.is_action_just_pressed("changeScenesLeft") and global.selectedSceneId-1>=0 and fading==false:
			global.selectedSceneId-=1
			FadeInAndOut()
			await get_tree().create_timer(2.275).timeout
			$SceneChooser.emit_signal("item_selected",global.selectedSceneId)
			await get_tree().create_timer(1.275).timeout
			emit_signal("startAnimation")
		if Input.is_action_just_pressed("changeScenesRight") and global.selectedSceneId+1<Scenes.size() and fading==false:
			global.selectedSceneId+=1
			FadeInAndOut()
			await get_tree().create_timer(2.275).timeout
			$SceneChooser.emit_signal("item_selected",global.selectedSceneId)
			await get_tree().create_timer(1.275).timeout
			emit_signal("startAnimation")

func addScene():
	if(Scenes.size()<4):
		$BackgroundPicker.select(1)
		$SceneChooser.add_item(str(Scenes.size()+1),Scenes.size())
		$SceneChooser.select(Scenes.size())
		var instance=preload("res://Scenes/AnimationScene.tscn").instantiate()
		global.selectedSceneId=Scenes.size()
		Scenes.append(instance)
		$"../../Scenes".add_child(instance)
		HideScenes()
		Scenes[global.selectedSceneId].show()
		Scenes[global.selectedSceneId].get_node("WorldBoundary/CollisionShape2D").disabled=false
		


func HideScenes():
	for i in Scenes.size():
		Scenes[i].hide()
		Scenes[i].get_node("WorldBoundary/CollisionShape2D").disabled=true

func _on_scene_chooser_item_selected(index):
	HideScenes()
	Scenes[index].get_node("WorldBoundary/CollisionShape2D").disabled=false
	Scenes[index].show()
	for i in BackgroundTextures.size():
		if(Scenes[index].get_node("GUI/Background").texture==BackgroundTextures[i]):
			$BackgroundPicker.select(i)
			break
	global.selectedSceneId=index

func _on_background_picker_item_selected(index):
	Scenes[global.selectedSceneId].get_node("GUI/Background").texture=BackgroundTextures[index]
	if(index==2):
		Scenes[global.selectedSceneId].get_node("WorldBoundary").position=Vector2(126.225,-35.47)
		Scenes[global.selectedSceneId].get_node("WorldBoundary").rotation_degrees=16
	else:
		Scenes[global.selectedSceneId].get_node("WorldBoundary").position=Vector2(0,0)
		Scenes[global.selectedSceneId].get_node("WorldBoundary").rotation_degrees=0

func _on_CharacterAdder_pressed(id):
	#simple solution to the having too many characters in one menubutton problem
	if($CharacterAdderPage2.visible==true):
		id+=13 #13 because despite the max index being 12 the count starts at 0 so theres 13 in total
	var instance=CharacterNode.instantiate()
	Scenes[global.selectedSceneId].get_node("Characters").add_child(instance)
	self.connect("transferTypeOfCharacter",instance._on_pickable_button_controller_transfer_type_of_character)
	self.connect("startAnimation",instance.animationStart)
	emit_signal("transferTypeOfCharacter",id,global.selectedSceneId)

func _on_AssetAdder_pressed(id):
	var instance=AssetNode.instantiate()
	Scenes[global.selectedSceneId].get_node("Assets").add_child(instance)
	self.connect("transferTypeOfAsset",instance._on_pickable_button_controller_transfer_type_of_asset)
	self.connect("startAnimation",instance.animationStart)
	emit_signal("transferTypeOfAsset",id,global.selectedSceneId)

func _on_ready_button_pressed():
	global.focus=-1
	global.focusASSET=-1
	$"../../Scenes".scale+=Vector2(0.2,0.2)
	$"../../Scenes".position=Vector2(0,0)
	$"..".hide()
	animStarted=true
	emit_signal("startAnimation")
	if(float($AnimationDuration.text)!=0):
		await get_tree().create_timer(float($AnimationDuration.text)).timeout
		get_tree().quit()


func _on_killswitch_pressed():
	if(global.focus>=0):
		global.storedCharacters[global.focus].queue_free()
		global.storedCharacters.pop_back()
		global.focus-=1

func _on_exit_pressed():
	get_tree().quit()


func _on_page_button_item_selected(index):
	if(index==1):
		$CharacterAdder.hide()
		$CharacterAdderPage2.show()
	else:
		$CharacterAdderPage2.hide()
		$CharacterAdder.show()
