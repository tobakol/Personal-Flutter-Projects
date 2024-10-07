import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/grocery_item.dart';
import '../providers/grocery_items_provider.dart';
import 'constants.dart';

class ApiCalls {
  BuildContext context;
  WidgetRef newRef;
  Dio dio;
  GroceryItem groceryItem;

  ApiCalls(this.context, this.newRef, this.dio, this.groceryItem);

  void deleteItem() async {
    try {
      final response = await dio.delete(ConstantsUtil.deleteUrl(groceryItem.id!));
      final wasAdded = newRef.read(groceryItemsProvider.notifier).editGroceryItemToList(groceryItem);

      debugPrint(response.statusCode.toString());
      if (response.statusCode != 200) {
        final wasAdded = newRef.read(groceryItemsProvider.notifier).editGroceryItemToList(groceryItem);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        if (context.mounted) {
          ViewUtil.showSnackbar(context, "Request took too long");
        }
      } else {
        if (context.mounted) {
          ViewUtil.showSnackbar(context, 'Error: ${e.response?.data ?? e.message}');
        }
      }
      final wasAdded = newRef.read(groceryItemsProvider.notifier).editGroceryItemToList(groceryItem);
    }
  }

  Future<Response<dynamic>?> saveToBackend(GroceryItem savedGroceryItem) async {
    dio.options.connectTimeout = const Duration(seconds: 10);
    try {
      final response =
          await dio.post(ConstantsUtil.generalUrl, data: savedGroceryItem.toJson(), options: ConstantsUtil.apiOptions);
      debugPrint(response.data.toString());

      // return response;
      if (response.statusCode == 200) {
        savedGroceryItem.id = response?.data["name"].toString();
        // debugPrint("THE NAME IS" + response?.data["name"]);

        final wasAdded = newRef.read(groceryItemsProvider.notifier).editGroceryItemToList(savedGroceryItem);

        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          ViewUtil.showSnackbar(context, response?.statusMessage);
        }
      }
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Response(requestOptions: RequestOptions(), statusMessage: "Request Took Too Long");
      } else {
        return e.response;
      }
    }
  }

  Future<void> loadItemListFromBackend(VoidCallback setBusy, VoidCallback setNotBusy) async {
    try {
      setBusy();
      final response = await dio.get(ConstantsUtil.generalUrl, options: ConstantsUtil.apiOptions);
      final Map<String, dynamic>? groceryMapListData = response.data;
      if (response.data == null) {
        setBusy;
        return;
      } else if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        final List<GroceryItem> listItems = [];
        for (final item in groceryMapListData!.entries) {
          final itemIzedMap = <String, Map<String, dynamic>>{item.key: item.value};
          final itemizedListItem = GroceryItem.fromJson(itemIzedMap);
          listItems.add(itemizedListItem);
          Future.microtask(() {
            final wasAdded = newRef.read(groceryItemsProvider.notifier).editGroceryItemToList(itemizedListItem);
            // Set initial value
          });
          setNotBusy();
        }
      } else {
        ViewUtil.showSnackbar(context, response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        if (context.mounted) {
          ViewUtil.showSnackbar(context, "Request took too long");
        }
      } else {
        if (context.mounted) {
          ViewUtil.showSnackbar(context, 'Error here is: ${e.response?.data ?? e.message}');
        }
      }
      setNotBusy();
    }
  }
}
