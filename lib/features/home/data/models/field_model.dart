import '../../domain/entities/field_entity.dart';

class FieldModel extends FieldEntity {
  FieldModel({
    super.name,
    super.fieldCheck,
    super.fieldCheckType,
    super.fieldCheckRequired,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      name: json['name'] as String?,
      fieldCheck: json['field_check'] as bool?,
      fieldCheckType: json['field_check_type'] as String?,
      fieldCheckRequired: json['field_check_required'] as bool?,
    );
  }

  @override
  String toString() =>
      'FieldModel(name: $name, fieldCheck: $fieldCheck, fieldCheckType: $fieldCheckType, fieldCheckRequired: $fieldCheckRequired)';
}
