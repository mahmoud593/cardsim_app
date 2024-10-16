
const String baseUrl = 'https://cardsim.net/api';

const String registerUrl = '$baseUrl/register';

const String loginUrl = '$baseUrl/access';

const String getUserInfoUrl = '$baseUrl/me';
// order API url
String getUserOrdersUrl(String search, String status) => '$baseUrl/orders?search=$search&status=$status';








