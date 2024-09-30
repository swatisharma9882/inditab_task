import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:demo_task/utils/date_parse.dart';
import 'package:demo_task/models/data_model.dart';
import 'package:demo_task/providers/data_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Week') {
                Provider.of<DataProvider>(context, listen: false).filterByWeek();
              } else if (value == 'Month') {
                Provider.of<DataProvider>(context, listen: false).filterByMonth();
              } else {
                Provider.of<DataProvider>(context, listen: false).fetchData();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Week', 'Month', 'Date'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return dataProvider.data.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : dataList(dataProvider.data);
        },
      ),
    );
  }

  Widget dataList(List<DataModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        DateTime? parsedDate = parseDate(data[index].date);

        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data[index].title),
              Text(parsedDate != null
                  ? DateFormat('yMMMd').format(parsedDate) // Format and display date
                  : 'Invalid date')
            ],
          ),
          subtitle:Text(data[index].description),
        );
      },
    );
  }
}
