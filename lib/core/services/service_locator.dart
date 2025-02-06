import 'package:games_app/features/auth/data/data_source/register_data_source.dart';
import 'package:games_app/features/auth/data/register_repo_implement/register_repo_implement.dart';
import 'package:games_app/features/auth/domain/repo/register_repo.dart';
import 'package:games_app/features/auth/domain/use_cases/register_use_cases.dart';
import 'package:games_app/features/home/data/data_source/api_services.dart';
import 'package:games_app/features/home/data/repos/home_repo_imp.dart';
import 'package:games_app/features/withdraws/data/api/withdraws_api_services.dart';
import 'package:games_app/features/withdraws/domain/repos/withdraws_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/domain/repos/home_repo.dart';
import '../../features/withdraws/data/repos/withdraws_repo_imp.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void setup() {
    getIt.registerSingleton<ApiServices>(
      ApiServices(),
    );

    getIt.registerSingleton<HomeRepo>(
      HomeRepoImp(getIt<ApiServices>()),
    );

    getIt.registerSingleton<WithdrawsApiServices>(
      WithdrawsApiServices(),
    );

    getIt.registerSingleton<WithdrawsRepo>(
      WithdrawsRepoImp(getIt<WithdrawsApiServices>()),
    );


    getIt.registerLazySingleton<RegisterRepo>(()=>RegisterRepoImplement(registerDataSource: getIt()));


    getIt.registerLazySingleton<RegisterDataSource>(()=>RegisterDataSourceImplement());

    getIt.registerLazySingleton(()=>RegisterUseCases(getIt()));


  }
}
