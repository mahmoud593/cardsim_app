class UrlConstants {
  static const String baseUrl = 'https://cardsim.net';

  // static const String token =
  //     '44SBJqp3HCpSDDriVEPS70NXH2i1BSDcPJxb1Qp2dfcb27a4';

  static const String companiesUrl = '$baseUrl/api/companies?search=&name=';

  static const String categoriesUrl = '$baseUrl/api/categories';

  static const String searchUrl = '$baseUrl/api/companies?search=';

  static const String loginWithGoogleUrl = '$baseUrl/api/login/google';

  static const String logoutUrl = '$baseUrl/api/logout';

  static const String forgetPasswordUrl = '$baseUrl/api/forget-password';

  static const String checkIdFieldUrl = '$baseUrl/api/orders/check-field';

  static const String createOrderUrl = '$baseUrl/api/orders/create';

  static const String getPaymentMethodUrl = '$baseUrl/api/payment-methods';

  static const String getCurrencyUrl = '$baseUrl/api/currencies';

  static const String getAllTransactionUrl = '$baseUrl/api/transactions';

  static const String createCustomCode = '$baseUrl/api/voucher-charge';

  static const String createTransaction = '$baseUrl/api/new-transaction';

  static const String getAllClients = '$baseUrl/api/dist/clients';

  static const String addClient = '$baseUrl/api/dist/clients/create';

  static const String createWithdrawUrl = '$baseUrl/api/dist/withdraws/new';

  static const String getLevelsUrl = '$baseUrl/api/levels-info';

  static String productsUrl(int companyId) =>
      '$baseUrl/api/products/$companyId';

  static const String withdrawsUrl =
      '$baseUrl/api/dist/withdraws?search=&page=1';

  static const String clientOrdersUrl =
      '$baseUrl/api/dist/client-orders?search=';

  static const String createCouponUrl =
      '$baseUrl/dist/vouchers/new';

  static getUserOrdersUrl(String search, String status) => '$baseUrl/orders?search=$search&status=$status';
  static getCouponsUrl(String search) => '$baseUrl/api/dist/vouchers?search=$search&page';
}
