extends Node

#textures
var CharacterNames=[]
var AssetNames=[]
var storedCharacters=[]
var storedAssets=[]
var gettingdragged=false
var gettingdraggedASSET=false
var focus=-1
var focusASSET=-1
var selectedSceneId=0

func _ready():
	CharacterNames.append("AlbertEinstein")
	CharacterNames.append("IsaacNewton")
	CharacterNames.append("WilliamShakespeare")
	CharacterNames.append("MihaiEminescu")
	CharacterNames.append("BenjaminFranklin")
	CharacterNames.append("IonCreanga")
	CharacterNames.append("IonGhica")
	CharacterNames.append("NeilArmstrong")
	AssetNames.append("Table")
	AssetNames.append("Painting1")
	AssetNames.append("Painting2")
