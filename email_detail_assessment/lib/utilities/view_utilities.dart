import 'package:email_detail_assessment/utilities/widgets_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//const loader = SpinKitDualRing(color: Colors.red);
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

Widget onboardingButton({required String buttonText, required void Function()? onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(buttonText),
        const Icon(Icons.arrow_forward)
      ],
    ).spaceSymmetrically(horizontal: 16),
  );
}
