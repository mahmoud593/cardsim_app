import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/level_structure/data/models/level_model.dart';
import 'package:games_app/features/level_structure/presentation/controller/level_states.dart';

class LevelCubit extends Cubit<LevelStates> {

  LevelCubit() : super(LevelInitialState());

  static LevelCubit get(context) => BlocProvider.of(context);

  HttpHelper httpHelper = HttpHelper();

  List<LevelStructure> levels=[];

  Future<void> getLevelStructure() async {

    emit(LevelStructureLoadingState());

    try{

      var response= await httpHelper.callService(
        url: UrlConstants.getLevelsUrl,
        responseType: ResponseType.get,
        authorization: false,
      );

      response.forEach((element) {
        levels.add(LevelStructure.fromJson(element));
      });
      print(levels[0].name);
      emit(LevelStructureSuccessState());


    }catch(e){

      emit(LevelStructureErrorState());
    }


  }
}