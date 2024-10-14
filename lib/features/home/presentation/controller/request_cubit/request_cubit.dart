
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/repos/home_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/check_field_entity.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit(this.homeRepo) : super(RequestInitial());
  final HomeRepo homeRepo;

  Future<void> checkIdField(String playerId, String type) async {
    emit(CheckFieldLoading());
    final result = await homeRepo.checkField(playerId, type);

    result.fold(
          (l) => emit(CheckFieldFailure(l.error)),
          (r) => emit(CheckFieldSuccess(r)),
    );
  }
}
