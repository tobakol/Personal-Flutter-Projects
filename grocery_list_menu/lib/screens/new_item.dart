import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // final groceryItemList = ref.watch(groceryItemsProvider);
    Future<Response<dynamic>?> saveToBackend(GroceryItem savedGroceryItem) async {
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 10);
      try {
        final response = await dio.post(
          ConstantsUtil.generalUrl,
          data: savedGroceryItem.toJson(),
          options: Options(headers: jsonHeader),
        );
        debugPrint(response.data.toString());

        return response;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout) {
          return Response(requestOptions: RequestOptions(), statusMessage: "Request Took Too Long");
        } else {
          return e.response;
        }
      }
    }

    saveItem() async {
      setState(() {
        _isSending = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final savedGroceryItem = GroceryItem(
            // id: DateTime.now().toString(),
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory!);

        final response = await saveToBackend(savedGroceryItem);
        if (response?.statusCode == 200) {
          final wasAdded = ref.read(groceryItemsProvider.notifier).editGroceryItemToList(savedGroceryItem);

          if (context.mounted) {
            Navigator.pop(context);
          }
        } else {
          if (context.mounted) {
            showSnackbar(context, response?.statusMessage);
          }
        }

        // debugPrint(response?.statusMessage);
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
                        decoration: const InputDecoration(),
                        onSaved: (newValue) {
                          _enteredName = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length > 50) {
                            return 'Error message';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! <= 0) {
                                return 'Error message';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredQuantity = int.parse(newValue!);
                            },
                            decoration: const InputDecoration(labelText: "Quantity"),
                            initialValue: _enteredQuantity.toString(),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const SizedBox(
                            height: 20,
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
            loader(context, _isSending)
          ],
        ),
      ),
    );
  }
}
