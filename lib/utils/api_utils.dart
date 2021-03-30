class ApiConstants {
  static const String octetStream = "application/octet-stream";
  static const String baseUrl = "http://kamusi.appsmata.com/";
  static const String bearerToken =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGM4NDQxYmM4ZjRkNWQ1NjViYTg0MDk4OWQ0NDIwNzFjZjUxYWJmZWYyNWFlY2Y1ZGM0ODMwOTc0ZWFmMGI0NWUwNWM1NWY3ODUxYzc0ZDYiLCJpYXQiOjE2MTUyOTMxMjgsIm5iZiI6MTYxNTI5MzEyOCwiZXhwIjoxNjQ2ODI5MTI4LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.RUGcJ0jH1RXGdvxQu3Ee_dZxqy-NQ36Wtmrh3vYguWLMEdS0sJBpdaxG353tCLpOvn09cjuA6YKw_I9dkr9n0D_a3kKrDXM6yI43O7RJAYZpjHpl1uaNwLulXajbtiO4ogDqpDW2b23hx7hxwcJtOFJBcs2SE-F--9ZJgCshMazUa45DxBf6v7GCRs4BmAyPwbztO7b1RP7RJBSwovzO7nEloDye3SytKGe2S0tEiKGeMCoe30qNSZTWnBSaWFxcWmOERy9RbPEi45vm5CkW_ZG8FQ5S1iVuE0VjEnMHzbCxFzli0xTcezmvcOzK-fj1i3cq83UAcSdPLqCxWrN9w-F6DxWeFET6TGef8u8EuXTvtyvEib-RRhcG3Y4OXjj9N5eM_DLZhwnb6-tngvnUSTfwBd5muPEsAU7nUCOFum0HHnqc2u1j_2Z82fQ1GrRr7r4cKmLPhIiZbyjnbPATPnb-VSYv8kAB8JwBhP6LbXkUR3lJRHxzO8gsCsTqsllJa2SA2Ey_LC65CA9RCMIJpW_XyRVgcsbLBqoz6w5ytqWtNmABt5t8iDiIQB8PiUTzkW5O6CKlyl0tn5lpZ-3Nj6ROAiwkbbme5FrqlW9BmCsvgtf-xC5xzJx3ZMETNECOvOf7OB_3Q0Behi6ux0nMrYjJMC1vedOAWBqMplE3clo";
  //static const String baseUrl = "http://192.168.43.16/kamusi-web/public/";
}

class ApiStrings {
  static const String areYouConnected = "Je, umeunganishwa?";
  static const String noConnection = "Hauna Mwungano wa Mtandao";
  static const String noInternetConnection =
      "Masalale! Hili linavunja moyo sana. Huonekani kuwa na mwungano imara wa mtandao.\n\n" +
          "Tafadhali jiunge na mtandao imara kupitia kwa Wi-Fi or Data ya Simu halafu jaribu tena.";
}

class ApiOperations {
  static const String success = "success";
  static const String failure = "failure";
  static const String suspended = "suspended";
  static const String unpermited = "unpermited";
  static const String missing = "missing";
  static const String invalid = "invalid";
  static const String already = "already";

  static const String login = "login";
  static const String register = "register";
  static const String changePassword = "chgpass";

  static const String categories = "api/categories";
  static const String questions = "api/questions";
  static const String trivia = "api/trivia";
}

class EventConstants {
  static const int noInternetConnection = 0;

  static const int requestSuccessful = 300;
  static const int requestUnsuccessful = 301;
  static const int requestNotFound = 302;
  static const int requestSuspended = 303;
  static const int requestUnpermited = 304;
  static const int requestInvalid = 305;

  static const int userSigninSuccessful = 500;
  static const int userSigninUnsuccessful = 501;
  static const int userNotFound = 502;
  static const int userSignupSuccessful = 503;
  static const int userSignupUnsuccessful = 504;
  static const int userAlreadyRegistered = 505;
  static const int signupSuspended = 506;
  static const int signupUnpermited = 507;
  static const int changePasswordSuccessful = 508;
  static const int changePasswordUnsuccessful = 509;
  static const int invalidOldPassword = 510;
}

class ApiResponseCode {
  static const int scOK = 200;
}
