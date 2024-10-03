import 'package:games_app/features/home/data/data_source/api_services.dart';
import 'package:games_app/features/home/data/repos/home_repo_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void setup() {
    getIt.registerSingleton<ApiServices>(
      ApiServices(),
    );
    getIt.registerSingleton<HomeRepoImp>(
      HomeRepoImp(
        getIt<ApiServices>(),
      ),
    );
  }
}
