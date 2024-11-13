import '../../domain/entities/check_field_entity.dart';

class CheckFieldModel extends CheckFieldEntity {
  CheckFieldModel(
    super.result,
    super.playerId,
    super.playerName,
    super.message,
  );

  factory CheckFieldModel.fromJson(Map<String, dynamic> json) {
    return CheckFieldModel(
      json['result'],
      json['player_id'] ?? '',
      json['player_name'] ?? '',
      json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'player_id': playerId,
      'player_name': playerName,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'CheckFieldModel(result: $result, playerId: $playerId, playerName: $playerName, message: $message)';
  }
}
