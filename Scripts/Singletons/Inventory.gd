extends Node

var key_count: int = 0

signal key_amt_changed(new_amt: int)

func add_key(amt: int = 1) -> void:
	key_count += amt
	emit_signal("key_amt_changed", key_count)

func get_key(amt: int = 1) -> bool:
	if key_count < amt:
		return false
	else:
		key_count -= amt
		emit_signal("key_amt_changed", key_count)
		return true

func reset_keys() -> void:
	key_count = 0
	emit_signal("key_amt_changed", key_count)
