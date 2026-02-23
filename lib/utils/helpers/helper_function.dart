import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class UHelperFunction {

  UHelperFunction._();

  static Color? getColor(String value) {
    if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    }else if (value == 'Silver'){
      return Colors.grey;
    }
      else {
      return null;
    }
  }

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if(hour >= 5 && hour < 12){
      return 'Good Morning';
    }else if(hour >= 12 && hour < 16){
      return 'Good Afternoon';
    }else if(hour >= 16 && hour < 19){
      return 'Good Evening';
    }else {
      return 'Good Night';
    }
  }

  // Function to convert assets to File
  static Future<File> assetToFile(String assetPath) async {
    // Load Assets bytes
    final byteData = await rootBundle.load(assetPath);
    // Get temp directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    // Write bytes to temp file
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file;
  }

}