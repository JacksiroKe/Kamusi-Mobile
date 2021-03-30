//This file declares the strings used throughout the app

/// Shared Preference Keys for this app
class SharedPreferenceKeys {
  static const String appUser = "app_user";
  static const String appDatabaseLoaded = "app_dbase_loaded";
  static const String darkMode = "app_dark_mode";
  static const String triviaSubscribed = "app_trivia_subscribed";
  static const String triviaSubscriptionMode = "app_trivia_subscription_mode";
  static const String triviaSubscriptionDeadline =
      "app_trivia_subscription_deadline";
}

/// General language strings that are used throught the application majoryly in Kiswahili language
class AppStrings {
  static const String appIcon = "assets/images/appicon.png";
  static const String appName = "Kamusi Ya Kiswahili";
  static const String appVersion = " v1.4.8";
  static const String appSlogan = "Kiswahili Kitukuzwe";
  static const String inProgress = "Inaendelea ...";
  static const String gettingReady = "Subiri kiasi ...";
  static const String somePatience = "Eish! ... Subiri kidogo ...";
  static const String words = 'maneno';
  static const String proverbs = 'methali';
  static const String sayings = 'misemo';
  static const String idioms = 'nahau';
  static const String searches = 'matafuto';
  static const String trivia = 'trivia';

  static const String revCatKey = 'danXhdPXSzsDcJgElNAexHaGnvsPMSqY';

  static const String campaign =
      "\n\n#KamusiYaKiswahili #KiswahiliKitukuzwe \n\nhttps://play.google.com/store/apps/details?id=com.kazibora.kamusi ";
  static const String synonyms_for = "\n\nVisawe (synonyms) vya neno ";
  static const String searchNow = "Tafuta ";
  static const String searchHint = "Tafuta Maneno ya Kiswahili";
  static const String favourited = "Maneno Uliyoyapenda";
  static const String history = "Historia yako";

  static const String nothing =
      'Ala! Yaani hivi kumbe hamna chochote huku!\nHebu fanya jambo ...';

  static const String copyThis = "Nakili kwa Clipboard";
  static const String shareThis = "Shiriki";

  static const String okayGotIt = "Sawa";
  static const String retry = "Jaribu Tena";

  static const String idiomCopied = "Nahau imenakiliwa kwa clipboard!";
  static const String sayingCopied = "Msemo umenakiliwa kwa clipboard!";
  static const String proverbCopied = "Methali imenakiliwa kwa clipboard!";
  static const String wordCopied = "Neno limenakiliwa kwa clipboard!";
  static const String wordLiked = " limependwa!";
  static const String wordDisliked = " limetolewa kwa vipendwa!";

  static const String darkMode = "Mandhari Meusi";

  static const String donateActionButton = "CHANGIA";
  static const String laterActionButton = "BAADAYE";

  static String donateDialogTitle = "CHANGIA SASA";
  static const String donateDialogMessage =
      "Kamusi ya Kiswahili ni kitumizi cha bure cha kuwezesha watumizi kama wewe waelimike na kufuzu katika lugha ya Kiswahili." +
          " Sisi ni shirika lisilo la faida na tunategemea watu kama wewe kutusaidia kuweka Kamusi bure bila ya matangazo ya kibiashara kwa mamilioni ya watu ulimwenguni";

  static const String donateTabPage = "Tuunge Mkono kwa Mchango";

  static const String donateTab1Title = "M-Pesa";
  static const String donateTab1Content = "PAYBILL: 891300\n\nAKAUNTI: 34489";

  static const String donateTab2Title = "Equitel";
  static const String donateTab2Content =
      "NAMBARI YA BIASHARA:\n\t891300\n\nAKAUNTI: 34489";

  static const String donateTab3Title = "Airtel";
  static const String donateTab3Content =
      "JINA LA BIASHARA:\n\tMCHANGA\n\nAKAUNTI: 34489";

  static const String donateTab4Title = "PayPal";
  static const String donateTab4Content =
      "ANWANI:\n\ttunaboresha [at] gmail.com";

  static const String helpTabPage = "Usaidizi na Mawasiliano";

  static const String helpTab1Title = "Wasiliana";
  static const String helpTab1Content =
      "<p>SIMU: +2547 - </p><hr><p>BARUA PEPE: tunaboresha [at] gmail.com </p><hr> <p>TOVUTI: <a href=\"https://kazibora.github.io\">kazibora.github.io</a></p>";

  static const String helpTab2Title = "Reviews";
  static const String helpTab2Content =
      "Iwapo unafurahia kitumizi (app) chetu au haufurahii tafadhali tujulishe kwa kuacha review yako kwenye <a href=\"https://play.google.com/store/apps/details?id=com.kazibora.kamusi\">Google Play Store</a>";

  static const String helpTab3Title = "Open Source";
  static const String helpTab3Content =
      "Iwapo wewe ni Msanidi Kitumizi (App Developer), source code ya kitumizi hiki yapatikana bila malipo kwenye GitHub:</br></br> <a href=\"https://github.com/kazibora/kamusi\">github.com/kazibora/kamusi</a>";

  static const String howToUse = "Jinsi ya Kutumia Kitumizi";
  static const String howToSearch1 = "Kutafuta words";
  static const String howToSearch2 =
      "Guza sehemu nyeupe iliyoonyeshwa kwa mstari mwekundu ili kufungua skrini ya kutafuta words. " +
          "Tafadhali zingatia kuwa utafutaji ni wa words pekee";
  static const String aboutApp = "Kuhusu Kitumizi";

  static const String favoritesTab = "Vipendwa";
  static const String searchTab = "Tafuta";
  static const String triviaTab = "TriviaScreen";

  static const String triviaTitle = "Trivia ya Kamusi";

  static const String triviaPage = "Makundi ya Trivia";
  static const String triviaListPage = "Trivia za Awali";
  static const String triviaPageDescription =
      "Chagua kundi la Trivia ili kuanza";
  static const String triviaList = "Trivia Zangu za Awali";
  static const String triviaListDescription =
      "Pitia au Rudia Trivia Zako za Awali";
  static const String triviaLeaderboard = "Orodha ya Kuongoza";
  static const String triviaLeaderboardDescription =
      "Orodha za wanao ongoza (leaderboard)";
  static const String triviaSettings = "Mipangilio ya Trivia";
  static const String triviaSettingsDescription = "Badili Mipangilio ya Trivia";
  static const String triviaSubscription = "Usajili (Subscription)";
  static const String triviaSubscriptionDescription =
      "Tazama Usajili (Manage Subscription)";
  static const String triviaSubscribe = "Jisajili (Subscribe) kwa huduma hii";

  static const String triviaPageInstruction = "Chagua kundi ili kuanza";
  static const String triviaQuizInstruction = "Chagua Idadi ya Maswali";
  static const String triviaLevelInstruction = "Chagua Kiwango cha Ugumu";
  static const String triviaStart = "Anza!";
  static const String triviaCartegory = "Kundi: ";
  static const String triviaEasy = "Rahisi";
  static const String triviaMedium = "Wastani";
  static const String triviaHard = "Ngumu";

  static const String justaMinute = "Hebu kidogo ...";
  static const String areYouleaving =
      "Hivi una hakika unataka kuondoka kutoka kwenye Trivia?\n\n Iwapo utarejea hapa itakubidi uanze Trivia upya!";
  static const String yes = "Ndio";
  static const String no = "Hapana";
  static const String next = "Lijalo";
  static const String submit = "Maliza";
  static const String selectAnswer = "Sharti uchague jibu ili kuendelea.";

  static const String answers = "Majibu";
  static const String triviaDetails = "Malelezo ya Trivia";
  static const String triviaCategory = "Kikundi/Mada";
  static const String triviaLevel = "Kiwango";
  static const String resultsScreen = "Matokeo ya Trivia";
  static const String totalQuestions = "Jumla ya Maswali";
  static const String score = "Alama";
  static const String correctAnswers = "Majibu Sahihi";
  static const String gotoHomescreen = "Rejea kwa Trivia";
  static const String checkAnswers = "Angalia Majibu";
  static const String done = "Malizia";
  static const String correctAnswer = "Jibu Sawa: ";
  static const String yourAnswer = "Jibu Lako: ";

  static const String subscriptionTrial = "Subscription ya Trial";
  static const String subscription3months = "Subscription ya Miezi 3";
  static const String subscription6months = "Subscription ya Miezi 6";
  static const String subscription1year = "Subscription ya Mwaka 1";
  static const String subscribe = "Jisajili";
  static const String subscribeNow = "Jisajili (Subscribe)";
}
