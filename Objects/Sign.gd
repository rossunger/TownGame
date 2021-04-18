tool
extends Node2D
export var text = "" setget setText

func setText(value):
	text = value
	$Label.text = text

