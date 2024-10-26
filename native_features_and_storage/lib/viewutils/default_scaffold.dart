import 'package:native_features_and_storage/viewutils/view_utilities.dart';

import 'widgets_extensions.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatefulWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? body;
  final bool busy;

  const DefaultScaffold({super.key, this.title, this.actions, this.body, this.busy = false});

  @override
  State<DefaultScaffold> createState() => _DefaultScaffoldState();
}

class _DefaultScaffoldState extends State<DefaultScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(backgroundColor: Colors.black, actions: widget.actions, title: Text(widget.title ?? "")),
            body: widget.body ?? const Placeholder().paddingSymmetric(horizontal: 16, vertical: 20),
          ),
          if (widget.busy)
            loaderPage(
              context,
            )
        ],
      ),
    );
  }
}
