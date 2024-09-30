import 'package:flutter/material.dart';
import 'package:demo_task/utils/date_parse.dart';
import 'package:demo_task/models/data_model.dart';
import 'package:demo_task/services/api_service.dart';


class DataProvider extends ChangeNotifier {
  List<DataModel> _data = [];
  List<DataModel> _filteredData = [];
  final ApiService _apiService = ApiService();

  List<DataModel> get data => _filteredData;

  Future<void> fetchData() async {
    try {
      _data = await _apiService.fetchData();

      // Sort the initial data by date in ascending order
      _data.sort((a, b) {
        DateTime? dateA = parseDate(a.date);
        DateTime? dateB = parseDate(b.date);
        return (dateA != null && dateB != null)
            ? dateA.compareTo(dateB)
            : 0; // Return 0 if dates are null
      });

      _filteredData = _data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }


  void filterByDateRange(DateTime start, DateTime end) {
    _filteredData = _data.where((item) {
      DateTime? itemDate = parseDate(item.date);
      return itemDate != null && itemDate.isAfter(start) && itemDate.isBefore(end);
    }).toList();

    // Sort the filtered data by date in ascending order
    _filteredData.sort((a, b) {
      DateTime? dateA = parseDate(a.date);
      DateTime? dateB = parseDate(b.date);
      return (dateA != null && dateB != null)
          ? dateA.compareTo(dateB)
          : 0; // Return 0 if dates are null
    });

    notifyListeners();
  }



  void filterByWeek() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday));
    filterByDateRange(startOfWeek, endOfWeek);
  }

  void filterByMonth() {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
    filterByDateRange(startOfMonth, endOfMonth);
  }
}
