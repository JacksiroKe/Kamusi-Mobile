import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/base/event_object.dart';
import '../utils/strings/strings.dart';

Future<EventObject> getCategories() async {
  String apiUrl = ApiConstants.baseUrl + ApiOperations.categories;
  var headers = {'Authorization': ApiConstants.bearerToken};
  var request = http.Request('GET', Uri.parse(apiUrl));
  request.headers.addAll(headers);
  try {
    
    http.StreamedResponse response = await request.send();

    if (response.statusCode == ApiResponseCode.scOK) {
      String apiResponse = await response.stream.bytesToString();

      List<Map<String, dynamic>> categories =
          List<Map<String, dynamic>>.from(json.decode(apiResponse)["results"]);
      return EventObject(
          id: EventConstants.requestSuccessful, object: categories);
    } else {
      return EventObject(id: EventConstants.requestUnsuccessful);
    }
  } catch (Exception) {
    return EventObject();
  } on TimeoutException catch (_) {
    return EventObject(id: EventConstants.requestUnsuccessful);
  }
}

Future<EventObject> getQuestions(int category, int level, int limit) async {
  try {
    String apiUrl = ApiConstants.baseUrl + ApiOperations.questions +
        "?category=$category&level=$level&limit=$limit";
    var request = http.Request('GET', Uri.parse(apiUrl));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == ApiResponseCode.scOK) {
      String apiResponse = await response.stream.bytesToString();

      List<Map<String, dynamic>> categories =
          List<Map<String, dynamic>>.from(json.decode(apiResponse)["results"]);
      return EventObject(
          id: EventConstants.requestSuccessful, object: categories);
    } else {
      return EventObject(id: EventConstants.requestUnsuccessful);
    }
  } catch (Exception) {
    return EventObject();
  } on TimeoutException catch (_) {
    return EventObject(id: EventConstants.requestUnsuccessful);
  }
}
