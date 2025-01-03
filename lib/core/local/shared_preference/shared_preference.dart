import 'package:shared_preferences/shared_preferences.dart';


class UserDataFromStorage {

  static late bool firstTime;
  static late bool userIsGuest;
  static late bool userIsLogin;

  static late bool themeIsDarkMode=false;
  static late bool onBoardingIsOpen;
  static late bool distCustomEarning;
  static late String userPhoneTypeFromStorage;
  static String languageCodeFromStorage='ar';
  static String appCurrencyFromStorage='USD';
  static String languageNameFromStorage="langArabic";
  static late String fullNameFromStorage;
  static late String userTokenFromStorage;
  static late String emailFromStorage;
  static late String phoneNumberFromStorage;
  static late String countryFromStorage;
  static late String addressFromStorage;
  static late String educationalDegreeFromStorage;
  static late String postCodeFromStorage;
  static late String genderFromStorage;
  static late String dateOfBrithFromStorage;
  static late String cityFromStorage;
  static late String uIdFromStorage;
  static late double balanceFromStorage;
  static late double cReductionFromStorage;
  static late double detectionFromStorage;
  static late double suspendedBalanceFromStorage;
  static late double orderWaiting;
  static late double orderRefuse;
  static late double allOrders;
  static late double progressWaiting;


  static setFirstTimeApp(bool value) {
    firstTime=value;
    _setData();
  }


  static setOnBoardingOpened(bool value) {
    onBoardingIsOpen=value;
    _setData();
  }


  static setUserIsGuest(bool block) {
    userIsGuest = block;
    _setData();
  }static setUserIsLogin(bool block) {
    userIsLogin = block;
    _setData();
  }
  static setThemeIsDarkMode(bool darkMode) {
    themeIsDarkMode = darkMode;
    _setData();
  }

  static setDistCustomEarning(bool value) {
    distCustomEarning = value;
    _setData();
  }

  static  setPhoneType(String value)  {
    userPhoneTypeFromStorage=value;
    _setData();
  }


  static  setUserTokenFromStorage(String token)  {
    userTokenFromStorage=token;
    _setData();
  }

  static  setAppLanguageCode(String value)  {
    languageCodeFromStorage=value;
    _setData();
  }


  static  setFullName(String value)  {
    fullNameFromStorage=value;
    _setData();
  }

  static  setEmail(String value)  {
    emailFromStorage=value;
    _setData();
  }


  static  setPhoneNumber(String value)  {
    phoneNumberFromStorage=value;
    _setData();
  }
  static  setAppCurrency(String value)  {
    appCurrencyFromStorage=value;
    _setData();
  }
  static  setCountry(String value)  {
    countryFromStorage=value;
    _setData();
  }
  static  setAddress(String value)  {
    addressFromStorage=value;
    _setData();
  }
  static  setEducationalDegree(String value)  {
    educationalDegreeFromStorage=value;
    _setData();
  }
  static  setPostCode(String value)  {
    postCodeFromStorage=value;
    _setData();
  }

  static  setGender(String value)  {
    genderFromStorage=value;
    _setData();
  }

  static setBalance(double value)  {
    balanceFromStorage=value;
    _setData();
  }

  static setCReduction(double value)  {
    cReductionFromStorage=value;
    _setData();
  }

  static setDetection(double value)  {
    detectionFromStorage=value;
    _setData();
  }

  static setSuspendedBalance(double value)  {
    suspendedBalanceFromStorage=value;
    _setData();
  }

  static setOrdersWaiting(double value)  {
    orderWaiting=value;
    _setData();
  }

  static setOrdersRefuse(double value)  {
    orderRefuse=value;
    _setData();
  }


  static setAllOrders(double value)  {
    allOrders=value;
    _setData();
  }

  static setProgressWaiting(double value)  {
    progressWaiting=value;
    _setData();
  }


  static  setDateOfBrith(String value)  {
    dateOfBrithFromStorage=value;
    _setData();
  }
  static  setCity(String value)  {
    cityFromStorage=value;
    _setData();
  }

  static  setUid(String value)  {
    uIdFromStorage=value;
    _setData();
  }

  /// this function to remove all storage
  static removeAllDataFromStorage() async{
    final prefs= await SharedPreferences.getInstance();
    await prefs.clear();
  }
  /// this function to remove any data from local storage by key
  static removeDataFromStorage(String key) async{
    final prefs= await SharedPreferences.getInstance();
    await prefs.remove(key);
  }


  //#region private
  static void _setData()async {

    final prefs= await SharedPreferences.getInstance();
    prefs.setBool("userIsGuest",userIsGuest);
    prefs.setBool("userIsLogin",userIsLogin);
    prefs.setBool("firstTime",firstTime);
    prefs.setBool("themeIsDarkMode",themeIsDarkMode);
    prefs.setBool("onBoardingIsOpen",onBoardingIsOpen);
    prefs.setBool("distCustomEarning",distCustomEarning);
    prefs.setString("languageCodeFromStorage",languageCodeFromStorage);
    prefs.setString("languageNameFromStorage",languageNameFromStorage);
    prefs.setString("userTokenFromStorage",userTokenFromStorage);
    prefs.setString("appCurrencyFromStorage",appCurrencyFromStorage);
    prefs.setString("fullNameFromStorage",fullNameFromStorage);
    prefs.setString("emailFromStorage",emailFromStorage);
    prefs.setString("phoneNumberFromStorage",phoneNumberFromStorage);
    prefs.setString("countryFromStorage",countryFromStorage);
    prefs.setString("addressFromStorage",addressFromStorage);
    prefs.setString("educationalDegreeFromStorage",educationalDegreeFromStorage);
    prefs.setString("postCodeFromStorage",postCodeFromStorage);
    prefs.setString("genderFromStorage",genderFromStorage);
    prefs.setString("dateOfBrithFromStorage",dateOfBrithFromStorage);
    prefs.setString("cityFromStorage",cityFromStorage);
    prefs.setString("uIdFromStorage",uIdFromStorage);
    prefs.setDouble("cReductionFromStorage",cReductionFromStorage);
    prefs.setDouble("balanceFromStorage",balanceFromStorage);
    prefs.setDouble("detectionFromStorage",detectionFromStorage);
    prefs.setDouble("suspendedBalanceFromStorage",suspendedBalanceFromStorage);
    prefs.setDouble("orderWaiting",orderWaiting);
    prefs.setDouble("allOrders",allOrders);
    prefs.setDouble("orderRefuse",orderRefuse);
    prefs.setDouble("progressWaiting",progressWaiting);

  }


  static   getData() async {

    final prefs = await SharedPreferences.getInstance();
    userIsGuest = prefs.getBool("userIsGuest")?? true;
    userIsLogin = prefs.getBool("userIsLogin")?? false;
    firstTime = prefs.getBool("firstTime")?? true;
    themeIsDarkMode = prefs.getBool("themeIsDarkMode")?? false;
    onBoardingIsOpen = prefs.getBool("onBoardingIsOpen")?? false;
    distCustomEarning = prefs.getBool("distCustomEarning")?? false;
    languageCodeFromStorage = prefs.getString("languageCodeFromStorage")??'ar';
    languageNameFromStorage = prefs.getString("languageNameFromStorage")??'langArabic';
    userPhoneTypeFromStorage = prefs.getString("userPhoneTypeFromStorage")??'';
    appCurrencyFromStorage = prefs.getString("appCurrencyFromStorage")??'USD';
    fullNameFromStorage = prefs.getString("fullNameFromStorage")??'';
    userTokenFromStorage = prefs.getString("userTokenFromStorage")??'';
    emailFromStorage = prefs.getString("emailFromStorage")??'';
    phoneNumberFromStorage = prefs.getString("phoneNumberFromStorage")??'';
    countryFromStorage = prefs.getString("countryFromStorage")??'';
    addressFromStorage = prefs.getString("addressFromStorage")??'';
    educationalDegreeFromStorage = prefs.getString("educationalDegreeFromStorage")??'';
    postCodeFromStorage = prefs.getString("postCodeFromStorage")??'';
    genderFromStorage = prefs.getString("genderFromStorage")??'';
    dateOfBrithFromStorage = prefs.getString("dateOfBrithFromStorage")??'';
    cityFromStorage = prefs.getString("cityFromStorage")??'';
    uIdFromStorage = prefs.getString("uIdFromStorage")??'';
    cReductionFromStorage = prefs.getDouble("cReductionFromStorage")??0.0;
    balanceFromStorage = prefs.getDouble("balanceFromStorage")??0.0;
    detectionFromStorage = prefs.getDouble("detectionFromStorage")??0.0;
    suspendedBalanceFromStorage = prefs.getDouble("suspendedBalanceFromStorage")??0.0;
    orderRefuse = prefs.getDouble("orderRefuse")??0.0;
    orderWaiting = prefs.getDouble("orderWaiting")??0.0;
    allOrders = prefs.getDouble("allOrders")??0.0;
    progressWaiting = prefs.getDouble("progressWaiting")??0.0;
  }

//#endregion

}
