extends Node

signal loading_finished

func await_loading() -> void:
	await loading_finished
