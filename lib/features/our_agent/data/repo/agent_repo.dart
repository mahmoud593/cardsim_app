import 'package:games_app/features/our_agent/data/model/agent_model.dart';

abstract class AgentRepo {
  Future<AgentModel> getAgent();
}