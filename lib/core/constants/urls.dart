class UrlConstants {
  static const String baseUrl = 'https://cardsim.net';

  static const String token =
      '44SBJqp3HCpSDDriVEPS70NXH2i1BSDcPJxb1Qp2dfcb27a4';

  static const String companiesUrl = '$baseUrl/api/companies?search=&category=';

  static const String categoriesUrl = '$baseUrl/api/categories';

  static const String searchUrl = '$baseUrl/api/companies?search=';

  static String productsUrl(int companyId) =>
      '$baseUrl/api/products/$companyId';
}
