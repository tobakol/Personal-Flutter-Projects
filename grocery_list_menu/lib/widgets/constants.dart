import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loader(BuildContext context, bool busy) {
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

showSnackbar(BuildContext context, String? message, [String? s]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message ?? "")));
}

final jsonHeader = {
  'Content-Type': 'application/json',
};

class ConstantsUtil {
  static String generalUrl = "https://flutter-prep-da043-default-rtdb.firebaseio.com/shopping_list.json";
  static String deleteUrl(String id) {
    return "https://flutter-prep-da043-default-rtdb.firebaseio.com/shopping_list/$id.json";
  }
}
