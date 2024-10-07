import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_list_menu/widgets/api_services.dart';

import '../data/categories.dart';
import '../models/category.dart';
import '../models/grocery_item.dart';
import '../providers/category_providers.dart';
import '../providers/grocery_items_provider.dart';
import '../widgets/constants.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables];
  bool _isSending = false;
  @override
  Widget build(BuildContext context) {
    final categoriesMap = ref.read(categoryProvider);
    final dio = Dio();

    saveItem() async {
      setState(() {
        _isSending = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final savedGroceryItem = GroceryItem(
            //id: DateTime.now().toString(),
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory!);
        final apiService = ApiCalls(context, ref, dio, savedGroceryItem);
        final response = await apiService.saveToBackend(savedGroceryItem);

        debugPrint(response?.statusMessage);
      }
      setState(() {
        _isSending = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                          maxLength: 50,
                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(),
                          onSaved: (newValue) {
                            _enteredName = newValue!;
                          },
                          validator: (value) => ValidationUtil.validateItemName(value)),
                      const SizedBox(),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) => ValidationUtil.validateItemAmount(value),
                            onSaved: (newValue) {
                              _enteredQuantity = int.parse(newValue!);
                            },
                            decoration: const InputDecoration(labelText: "Quantity"),
                            initialValue: _enteredQuantity.toString(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownButtonFormField(
                            value: _selectedCategory,
                            items: [
                              for (final category in categoriesMap.entries)
                                DropdownMenuItem(
                                    value: category.value,
                                    child: Row(
                                      children: [
                                        Container(
                                          color: category.value.categoryColor,
                                          width: 16,
                                          height: 16,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(category.value.categoryName!)
                                      ],
                                    ))
                            ],
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedCategory = value;
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                _formKey.currentState!.reset();
                              },
                              child: const Text('Reset')),
                          ElevatedButton(
                              onPressed: () async {
                                saveItem();
                              },
                              child: const Text("Add Item"))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            ViewUtil.loader(context, _isSending)
          ],
        ),
      ),
    );
  }
}
