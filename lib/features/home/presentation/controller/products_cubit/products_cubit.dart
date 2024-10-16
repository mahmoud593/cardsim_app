import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/home_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.homeRepo) : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;
  //final TextEditingController amountController = TextEditingController();

  Future<void> getProducts(int companyId) async {
    emit(ProductsLoading());
    final result = await homeRepo.getProducts(companyId);
    print(result);
    result.fold(
      (l) => emit(ProductsFailure(l.error)),
      (r) => emit(ProductsSuccess(r)),
    );
  }
}
