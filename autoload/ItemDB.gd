extends Node

var items := {
	"dummy" : {
		"item_name" : "",
		"item_description" : "Dummy description",
		"target_slot" : "",
		"target_class" : [],
		"path_texture" : "",
		"path_scn" : ""
	},
	"WoodStaff" : {
		"item_name" : "Wood staff",
		"item_description" : "A staff made of wood, it sucks",
		"target_slot" : "weapon",
		"target_class" : ["wizard"],
		"path_texture" : "res://items/wizard/weapons/WoodStaff/wood_staff.png",
		"path_scn" : "res://items/wizard/weapons/WoodStaff/WoodStaff.tscn"
	},
	"JadeStaff" : {
		"item_name" : "Jade staff",
		"item_description" : "A staff bla bla",
		"target_slot" : "weapon",
		"target_class" : ["wizard"],
		"path_texture" : "res://items/wizard/weapons/JadeStaff/jade_staff.png",
		"path_scn" : "res://items/wizard/weapons/JadeStaff/JadeStaff.tscn"
	},
	"DiamondStaff" : {
		"item_name" : "Diamond staff",
		"item_description" : "...",
		"target_slot" : "weapon",
		"target_class" : ["wizard"],
		"path_texture" :"res://items/wizard/weapons/DiamondStaff/diamond_staff.png" ,
		"path_scn" : "res://items/wizard/weapons/DiamondStaff/DiamondStaff.tscn"
	},
	"Spark" : {
		"item_name" : "Spark",
		"item_description" : "...",
		"target_slot" : "ability",
		"target_class" : ["wizard"],
		"path_texture" :"res://items/wizard/abilities/Spark/spark.png",
		"path_scn" : "res://items/wizard/abilities/Spark/Spark.tscn"
	},
	"Meteor" : {
		"item_name" : "Meteor",
		"item_description" : "...",
		"target_slot" : "ability",
		"target_class" : ["wizard"],
		"path_texture" :"res://items/wizard/abilities/Meteor/meteor.png",
		"path_scn" : "res://items/wizard/abilities/Meteor/MeteorBullet.tscn"
	},
	#MAKE IT AUTOMATIC LIKE IN QRPG
}

func _ready():
	pass
