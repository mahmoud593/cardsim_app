import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/repos/home_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/companies_entity.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit(this.homeRepo) : super(CompaniesInitial());



  final HomeRepo homeRepo;

  Future<void> getCompanies({String? category, String? query}) async {
    emit(CompaniesLoading());

    final result = await homeRepo.getCompanies();

    result.fold(
      (l) => emit(CompaniesFailure(l.error)),
      (r) {
        var filteredCompanies = r;
        if (category != null) {
          filteredCompanies = filteredCompanies
              .where((company) => company.category == category)
              .toList();
        }
        if (query != null && query.isNotEmpty) {
          filteredCompanies = filteredCompanies
              .where((company) =>
                  company.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        print('Call getCompanies');
        emit(CompaniesSuccess(filteredCompanies));
      },
    );
  }
}

// Future<void> getCompanies([String? category]) async {
//   emit(CompaniesLoading());
//   final result = await homeRepo.getCompanies();
//
//   result.fold(
//     (l) => emit(CompaniesFailure(l.error)),
//     (r) {
//       final filteredCompanies = category == null
//           ? r
//           : r.where((company) => company.category == category).toList();
//
//       emit(CompaniesSuccess(filteredCompanies));
//     },
//   );
// }

// void searchCompanies(String query) async {
//   if (query.isEmpty) {
//     emit(CompaniesInitial());
//     return;
//   }
//   try {
//     emit(CompaniesLoading());
//     final companies = await fetchCompaniesByQuery(query);
//     emit(CompaniesSuccess(companies));
//   } catch (error) {
//     emit(CompaniesError("Error loading companies."));
//   }
// }
