import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

jsonString(Map<String, String> map) {}
Map<String, String> headers = {
  "Content-type": "application/x-www-form-urlencoded"
};

Future<List<dynamic>> fetchCats(apiUrl) async {
  var response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    return json.decode(response.body)['results'];
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<dynamic>> fetchPost(apiUrl) async {
  var response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    return json.decode(response.body)['results'];
  } else {
    throw Exception('Failed to load album');
  }
}

Future<String?> fetchPostById(apiUrl) async {
  var response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    var result = json.decode(response.body)['results'];
    //print(result);
    return result;
  } else {
    throw Exception('Failed to load Data');
  }
}

Future<List<dynamic>> fetchUsers(apiUrl) async {
  var result = await http.get(Uri.parse(apiUrl));
  return json.decode(result.body)['results'];
}
