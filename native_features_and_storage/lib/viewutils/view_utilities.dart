import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final loader = const SpinKitDualRing(color: Colors.red);
showSnackbar(BuildContext context, String? message, [String? s]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message ?? "")));
}

Widget loaderPage(
  BuildContext context,
) {
  return Container(
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
  );
}
