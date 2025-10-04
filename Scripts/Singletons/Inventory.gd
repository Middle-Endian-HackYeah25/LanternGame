extends Node

var key_count: int = 2

signal key_amt_changed(new_amt: int)

func add_key(amt: int = 1) -> void:
	key_count += amt
	emit_signal("key_amt_changed", key_count)

func remove_key(amt: int = 1) -> void:
	key_count -= amt
	emit_signal("key_amt_changed", key_count)

func reset_keys() -> void:
	key_count = 0
	emit_signal("key_amt_changed", key_count)
