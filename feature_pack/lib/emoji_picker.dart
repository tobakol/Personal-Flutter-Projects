import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiPickerPage extends StatelessWidget {
  const EmojiPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title:const Text( "Emoji Picker Page",),
      ),
      body: Center(child: EmojiSelector(controller: TextEditingController()),) ,

    );
  }
}



class EmojiSelector extends StatefulWidget {
  final TextEditingController controller;

  EmojiSelector({super.key, required this.controller});

  @override
  State<EmojiSelector> createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showEmojiPicker(context);
      },
      child: SizedBox(
        // width: 100,
        // height: 100,
        child: Center(
          child: widget.controller.text.isEmpty
              ? Icon(Icons.emoji_emotions, size: 80,)
              : Text(
            widget.controller.text,
            style: TextStyle(fontSize: 60),
          ),
        ),
      ),
    );
  }

  Future<void> _showEmojiPicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmojiPicker(
          textEditingController: widget.controller,
          onEmojiSelected: (category, emoji) {
            setState(() {
              widget.controller.clear();
              widget.controller.text = emoji.emoji;
              Navigator.pop(context);
            });
          },
          // widget.onEmojiSelected,
          onBackspacePressed: () {
            setState(() {
              widget.controller.clear();
              Navigator.pop(context);
            });
          },
          config: const Config(
            replaceEmojiOnLimitExceed: false,
          ),
        );
      },
    );




    // Note: You can handle other logic here if needed after the emoji picker closes.
  }
}
