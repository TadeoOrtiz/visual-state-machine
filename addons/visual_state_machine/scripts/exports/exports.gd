class_name ExportStateProperty extends RefCounted

@export var name: String
@export var type: int
var value: Variant

func _init(n: String, t: int, v: Variant) -> void:
	self.name = n
	self.type = t
	self.value = v

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary]
	
	properties.append(
		{
			"name": "value",
			"type": TYPE_MAX,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	return properties
