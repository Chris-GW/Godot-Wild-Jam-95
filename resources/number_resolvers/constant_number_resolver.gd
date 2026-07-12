## Resolves a fixed number.
class_name ConstantNumberResolver
extends NumberResolver

@export
var value := 0.0

func resolve() -> float:
	return value
