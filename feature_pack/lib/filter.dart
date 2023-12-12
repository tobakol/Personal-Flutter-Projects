import 'package:flutter/material.dart';


class FilteredContainerListScreen extends StatefulWidget {
  @override
  _FilteredContainerListScreenState createState() =>
      _FilteredContainerListScreenState();
}
class _FilteredContainerListScreenState
    extends State<FilteredContainerListScreen> {
  List<Map<String, dynamic>> data = [
    {'name': 'Item 1', 'credit': true, 'debit': false},
    {'name': 'Item 2', 'credit': false, 'debit': true},
    {'name': 'Item 3', 'credit': true, 'debit': false},
    {'name': 'Item 4', 'credit': false, 'debit': true},
    {'name': 'Item 5', 'credit': true, 'debit': false},
    {'name': 'Item 6', 'credit': false, 'debit': true},
    {'name': 'Item 7', 'credit': true, 'debit': false},
    {'name': 'Item 8', 'credit': false, 'debit': true},
  ];

  FilterOption selectedFilter = FilterOption.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Container List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: PageController(
                viewportFraction:
                0.8, // Adjust this value to control visibility of neighboring containers
              ),
              itemCount: 5, // Replace with the number of containers you have
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.blue, // Background color of containers
                  width: 200.0, // Adjust the width as needed
                  child: Center(
                    child: Text(
                      'Container $index',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                );
              },
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: filteredData(selectedFilter).length,
              //     itemBuilder: (context, index) {
              //       Map<String, dynamic> item = filteredData(selectedFilter)[index];
              //
              //       return ListTile(
              //         title: Text(item['name']),
              //       );
              //     },
              //   ),
              // ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFilterOptions();
        },
        child: Icon(Icons.filter_list),
      ),
    );
  }

  List<Map<String, dynamic>> filteredData(FilterOption filter) {
    switch (filter) {
      case FilterOption.credit:
        return data.where((item) => item['credit'] == true).toList();
      case FilterOption.debit:
        return data.where((item) => item['debit'] == true).toList();
      default:
        return data;
    }
  }

  void showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('All'),
              onTap: () {
                setState(() {
                  selectedFilter = FilterOption.all;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Credit'),
              onTap: () {
                setState(() {
                  selectedFilter = FilterOption.credit;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Debit'),
              onTap: () {
                setState(() {
                  selectedFilter = FilterOption.debit;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
}

enum FilterOption { all, credit, debit }
