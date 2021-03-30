import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/base/event_object.dart';
import '../utils/api_utils.dart';

Future<EventObject> getCategories() async {
  try {
    String apiUrl = ApiConstants.baseUrl + ApiOperations.categories;
    var headers = {'Authorization': ApiConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
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
    String apiUrlx = ApiConstants.baseUrl +
        ApiOperations.questions +
        "?category=$category&level=$level&limit=$limit";
    Uri apiUrl = new Uri.http(ApiConstants.baseUrl, ApiOperations.questions, { "category" : "$category", "level" : "$level", "limit" : "$limit" });

    print(apiUrl.toString());

    http.Response response = await http.get(apiUrl);

    if (response != null) {
      if (response.statusCode == ApiResponseCode.scOK &&
          response.body != null) {
        List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(
            json.decode(response.body)["results"]);
        return EventObject(
            id: EventConstants.requestSuccessful, object: questions);
      } else
        return EventObject(id: EventConstants.requestUnsuccessful);
    } else
      return EventObject();
  } catch (Exception) {
    return EventObject();
  } on TimeoutException catch (_) {
    return EventObject(id: EventConstants.requestUnsuccessful);
  }
}

Future<EventObject> getTrivia(
    int category, String difficulty, int limit) async {
  try {
    int level = 1;
    if (difficulty == 'medium')
      level = 2;
    else if (difficulty == 'hard') level = 3;
    
    String apiUrlx = ApiConstants.baseUrl +
        ApiOperations.questions +
        "?category=$category&level=$level&limit=$limit";
    Uri apiUrl = new Uri.http(ApiConstants.baseUrl, ApiOperations.questions, { "category" : "$category", "level" : "$level", "limit" : "$limit" });

    print(apiUrl.toString());
    
    http.Response response = await http.get(apiUrl);
    if (response != null) {
      if (response.statusCode == ApiResponseCode.scOK &&
          response.body != null) {
        List<Map<String, dynamic>> trivia = List<Map<String, dynamic>>.from(
            json.decode(response.body)["results"]);
        return EventObject(
            id: EventConstants.requestSuccessful, object: trivia);
      } else
        return EventObject(id: EventConstants.requestUnsuccessful);
    } else
      return EventObject();
  } catch (Exception) {
    return EventObject();
  }
}
