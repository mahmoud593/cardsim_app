import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/our_agent/data/model/agent_model.dart';
import 'package:games_app/features/our_agent/data/repo/agent_repo_implement.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_state.dart';
import 'package:url_launcher/url_launcher.dart';



class OurAgentCubit extends Cubit<OurAgentStates> {
  OurAgentCubit() : super(OurAgentInitialState());

  static OurAgentCubit get(context) => BlocProvider.of(context);

  void launchWhatsApp({required String phoneNumber}) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      emit(LaunchWhatsAppErrorState());
      throw 'Could not launch $whatsappUrl';
    }

    emit(LaunchWhatsAppSuccessState());
  }

  void launchWhatsAppLink({required String link}) async {
    Uri uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      emit(LaunchWhatsAppSuccessState());
    } else {
      emit(LaunchWhatsAppErrorState());
      throw 'Could not launch $link';
    }


  }

  void launchTelegram({required String phoneNumber}) async {
    final telegramUrl = "https://t.me/$phoneNumber";

    if (await canLaunch(telegramUrl)) {
      await launch(telegramUrl);
    } else {
      emit(LaunchTelegramErrorState());
      throw 'Could not launch Telegram';
    }
    emit(LaunchTelegramSuccessState());
  }

  AgentModel agentModel = AgentModel(status: false, data: []);

  Future<void> getAgent() async{
    emit(GetAgentLoadingState());
    agentModel = AgentModel(status: false, data: []);

    try{
      agentModel = await AgentRepoImplement().getAgent();
      emit(GetAgentSuccessState());
    }catch(e){
      debugPrint("Error when get Agent =================> ${e.toString()}");
      emit(GetAgentErrorState());
    }
  }



}