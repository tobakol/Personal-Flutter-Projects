import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewUtil {
  static Widget loader(BuildContext context, bool busy) {
    return busy
        ? Container(
            color: const Color.fromARGB(255, 42, 51, 59).withOpacity(0.8),
            height: MediaQuery.of(context).size.height,
            child: Center(child: SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? const Color.fromARGB(255, 147, 229, 250) : Colors.green,
                  ),
                );
              },
            )),
          )
        : const SizedBox.shrink();
  }

  static showSnackbar(BuildContext context, String? message, [String? s]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message ?? "")));
  }
}

class ConstantsUtil {
  static Options apiOptions = Options(
    headers: {
      'Content-Type': 'application/json',
    },
  );
  static String generalUrl = "https://flutter-prep-da043-default-rtdb.firebaseio.com/shopping_list.json";
  static String deleteUrl(String id) {
    return "https://flutter-prep-da043-default-rtdb.firebaseio.com/shopping_list/$id.json";
  }
}

class ValidationUtil {
  static String? validateItemAmount(String? itemAmount) {
    if (itemAmount == null ||
        itemAmount.isEmpty ||
        int.tryParse(itemAmount) == null ||
        int.tryParse(itemAmount)! <= 0) {
      return 'Items can not be empty';
    }
    return null;
  }

  static String? validateItemName(String? itemName) {
    if (itemName == null || itemName.isEmpty || itemName.trim().length <= 1 || itemName.trim().length > 50) {
      return 'Name can not be empty or pass 50 characters';
    }
    return null;
  }
}
