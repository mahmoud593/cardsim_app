part of 'companies_cubit.dart';

@immutable
sealed class CompaniesState {}

final class CompaniesInitial extends CompaniesState {}

final class CompaniesLoading extends CompaniesState {}

final class CompaniesSuccess extends CompaniesState {
  final List<CompaniesEntity>? companies;
  CompaniesSuccess(this.companies);
}

final class CompaniesFailure extends CompaniesState {
  final String? message;

  CompaniesFailure(this.message);
}
