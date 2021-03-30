
import 'dart:io';

class AppSubscription {

  static Future<int> checkSubscription() async {
    try {
      return 2;
    }on SocketException catch (_) {
      //"Can't reach the servers, \n Please check your internet connection.",)
      return 0;
    } catch(e){
      print(e.message);
      return 1;
    }
  }
}