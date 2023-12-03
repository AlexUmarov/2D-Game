extends Node
class_name StateChar

signal Transitioned

enum {
	IDLE,
	WALK,
	RUN,
	ATTACK,
}

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Pthysics_Update(delta: float):
	pass
