import 'package:flutter_bloc/flutter_bloc.dart';
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



}