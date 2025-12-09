static func enum_as_string(enum_type, val):
    return enum_type.keys()[val]


static func find_native_enum_label(
    type_name: StringName, enum_name: StringName, enum_value: int
) -> String:
    for value_label in ClassDB.class_get_enum_constants(type_name, enum_name):
        var v = ClassDB.class_get_integer_constant(type_name, value_label)
        if v == enum_value:
            return value_label
    return "unknown enum"
