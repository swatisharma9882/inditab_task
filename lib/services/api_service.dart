import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo_task/models/data_model.dart';


class ApiService {
  static const String apiUrl = 'https://ixifly.in/flutter/task1';

  Future<List<DataModel>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      List<dynamic> data = jsonResponse['data'];

      // Map each element to DataModel
      return data.map((item) => DataModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
