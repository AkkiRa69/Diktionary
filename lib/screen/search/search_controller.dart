import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchViewController extends GetxController {
  var txtdata = {}.obs; // Reactive Map to automatically update UI
  var isLoading = false.obs; // Reactive loading state
  final TextEditingController wordController = TextEditingController();

  void fetchUrbanDictionaryDefinition(String word) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await http.get(
        Uri.parse("http://api.urbandictionary.com/v0/define?term=$word"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        txtdata.value = data; // Update reactive txtdata map
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  // Function to format text with bold for text inside square brackets
  Widget formatText(String text, Function(String) onTextTap) {
    // Regular expression to find text inside square brackets
    RegExp regExp = RegExp(r'\[([^\]]+)\]');
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    List<TextSpan> textSpans = [];
    int lastMatchEnd = 0;

    // Iterate through all matches
    for (RegExpMatch match in matches) {
      // Text before the current match
      if (match.start > lastMatchEnd) {
        textSpans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ));
      }

      // Text inside the brackets (bold and clickable)
      textSpans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Handle tap on the blue text
              onTextTap(match.group(1)!);
            },
        ),
      );

      lastMatchEnd = match.end;
    }

    // Text after the last match
    if (lastMatchEnd < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: const TextStyle(color: Colors.black),
      ));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
