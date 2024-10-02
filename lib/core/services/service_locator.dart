import 'package:dio/dio.dart';
import 'package:games_app/features/home/data/data_source/remote_data_source.dart';
import 'package:games_app/features/home/data/repos/home_repo_imp.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/domain/repos/home_repo.dart';

final getIt = GetIt.instance;

class ServiceLocator {

  void setup() {
    getIt.registerSingleton<HomeRepo>(
      HomeRepoImp(
        RemoteDataSource(Dio()),
      ),
    );
  }
}