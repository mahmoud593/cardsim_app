import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/categories_entity.dart';
import '../../../domain/repos/home_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.homeRepo) : super(CategoriesInitial());

  final HomeRepo homeRepo;

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    final result = await homeRepo.getCategories();
    result.fold(
          (l) => emit(CategoriesFailure(l.error)),
          (r) {
            print('Call Categories');
            emit(CategoriesSuccess(r));
          }
    );
  }

}
