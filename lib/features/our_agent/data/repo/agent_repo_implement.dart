import 'package:flutter/cupertino.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/our_agent/data/model/agent_model.dart';

import 'agent_repo.dart';

class AgentRepoImplement extends AgentRepo{
  @override
  Future<AgentModel> getAgent() async{
    final response = await HttpHelper().callService(
      url: getAgentUrl,
      responseType: ResponseType.get,
      authorization: true,
    );

    debugPrint("get Agent status >***************************************> ${response.toString()}");
    return AgentModel.fromMap(response);
  }


}