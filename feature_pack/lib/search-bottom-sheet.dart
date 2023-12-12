import 'package:flutter/material.dart';

class MyTextFieldWithModalBottomSheet extends StatefulWidget {
  @override
  _MyTextFieldWithModalBottomSheetState createState() => _MyTextFieldWithModalBottomSheetState();
}


class _MyTextFieldWithModalBottomSheetState extends State<MyTextFieldWithModalBottomSheet> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];
  List<String> filteredOptions = [];


  void filterOptions(String searchQuery) {
    setState(() {
      filteredOptions = options
          .where((option) => option.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }


  void showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // readOnly: true,
                controller: _searchController,
                decoration: InputDecoration(labelText: 'Search options'),
                onChanged: filterOptions,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredOptions[index]),
                    onTap: () {
                      _textFieldController.text = filteredOptions[index];
                      Navigator.of(context).pop(); // Close the modal bottom sheet
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textFieldController,
          decoration: InputDecoration(
            labelText: 'Select an option',
            suffixIcon: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: showBottomSheet,
            ),
          ),
        ),
      ],
    );
  }}
