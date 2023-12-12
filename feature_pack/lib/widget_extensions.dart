import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget padding({double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(padding: EdgeInsets.only(bottom: bottom, top: top, left: left, right: right), child: this);
  }

  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget addSpace({double x = 0, double y = 0}) {
    return SizedBox(width: x, height: y);
  }

  Widget replace(Widget widget, bool when) {
    return when ? widget : this;
  }

  Widget hideIf(bool when) {
    return when ? const SizedBox() : this;
  }

  Widget center() {
    return Center(child: this);
  }

  Widget greyOut() {
    return AbsorbPointer(
      child: Opacity(
        opacity: 0.5,
        child: this,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String removeUnderscores() {
    return replaceAll('_', ' ');
  }

  String hideMiddleCharacters({int numOfHiddenCharacters = 0}) {
    if (numOfHiddenCharacters <= 0) {
      return this; // Return the original string if the number of characters to hide is non-positive
    }

    if (length < numOfHiddenCharacters) {
      return this; // Return the original string if there aren't enough characters to hide
    }

    final int middleStartIndex = (length - numOfHiddenCharacters) ~/ 2;
    final int middleEndIndex = middleStartIndex + numOfHiddenCharacters;

    final String prefix = substring(0, middleStartIndex);
    final String suffix = substring(middleEndIndex);

    return '$prefix${'*' * numOfHiddenCharacters}$suffix';
  }

  String hideEndCharacters({int numOfHiddenCharacters = 0}) {
    if (numOfHiddenCharacters <= 0) {
      return this; // Return the original string if the number of characters to hide is non-positive
    }

    if (length < numOfHiddenCharacters) {
      return this; // Return the original string if there aren't enough characters to hide
    }

    final int startIndex = length - numOfHiddenCharacters;
    final String prefix = substring(0, startIndex);
    return '$prefix${'*' * numOfHiddenCharacters}';
  }

  String hideStartCharacters(int numOfHiddenCharacters) {
    if (numOfHiddenCharacters <= 0) {
      return this; // Return the original string if the number of characters to hide is non-positive
    }

    final String hidden = '*' * numOfHiddenCharacters;
    final String suffix = substring(numOfHiddenCharacters);

    return '$hidden$suffix';
  }

  String addSpacingAfterElements({int numOfElements = 0}) {
    if (numOfElements <= 0 || numOfElements >= length) {
      return this; // Return the original string if the number of elements is invalid
    }

    final List<String> elements = split('');

    for (int i = numOfElements; i < elements.length; i += numOfElements + 1) {
      elements.insert(i, " ");
    }

    return elements.join();
  }

  String replaceAllInstancesOfChar(String charToRemove, String replacementChar) {
    return replaceAll(charToRemove, replacementChar);
  }

  String truncateWithEllipses(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}...';
    }
  }

  String insertIntoNewLines(int charactersPerLine) {
    if (charactersPerLine <= 0 || charactersPerLine >= length) {
      return this; // Return the original string if charactersPerLine is invalid.
    }
    final List<String> lines = [];
    final words = split(' '); // Split the string into words
    String currentLine = '';

    for (final word in words) {
      if (currentLine.isEmpty) {
        currentLine = word;
      } else if ((currentLine.length + 1 + word.length) <= charactersPerLine) {
        currentLine += ' $word'; // Add a space and the word
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines.join('\n');
  }
}

///alfOfTheNumberOfCharactersToHide
///

extension DecorativeTextStyle on TextStyle {
  TextStyle underlineWithSpace(
      {required Color textColor, TextDecorationStyle? underlineType = TextDecorationStyle.solid}) {
    return copyWith(
        shadows: [
          Shadow(
            color: textColor,
            offset: Offset(0, -3),
          ),
        ],
        decorationThickness: 1,
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        decorationStyle: underlineType,
        decorationColor: textColor);
  }

  TextStyle underlineWithNoSpace(
      {required Color textColor, TextDecorationStyle? underlineType = TextDecorationStyle.solid}) {
    return copyWith(
        shadows: [
          Shadow(
            color: textColor,
            offset: Offset(0, -2),
          ),
        ],
        decorationThickness: 1,
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        decorationStyle: underlineType,
        decorationColor: textColor);
  }
}
