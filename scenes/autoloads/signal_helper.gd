@tool
extends Node

func chain(sig1: Signal, sig2: Signal) -> void:
	persist(sig1, sig2.emit)

func chain_once(sig1: Signal, sig2: Signal) -> void:
	once(sig1, sig2.emit)

func persist(sig: Signal, callable: Callable) -> void:
	if not sig.is_connected(callable):
		sig.connect(callable)

func remove(sig: Signal, callable: Callable) -> void:
	if sig.is_connected(callable):
		sig.disconnect(callable)

func remove_all(sig: Signal) -> void:
	for e in sig.get_connections():
		sig.disconnect(e["callable"])

func once(sig: Signal, callable: Callable) -> void:
	if not sig.is_connected(callable):
		sig.connect(callable, CONNECT_ONE_SHOT)

func once_next_frame(callable: Callable) -> void:
	var sig := get_tree().process_frame
	once(sig, callable)

func once_after(delay: float, callable: Callable) -> Signal:
	var sig := get_tree().create_timer(delay).timeout
	once(sig, callable)
	return sig

func on_changed(resource: Resource, callable: Callable) -> void:
	if resource:
		persist(resource.changed, callable)
