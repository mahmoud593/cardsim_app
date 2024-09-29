import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);



}