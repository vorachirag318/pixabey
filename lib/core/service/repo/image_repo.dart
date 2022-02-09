import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pixabay/core/utils/globle.dart';
import 'package:pixabay/ui/image_screen/model/imageListModel.dart';

class ImageRepo {
  static Future<ImagesListModel?> fetchImageList(
      {required int page, required String search}) async {
    try {
      bool connection = await checkConnection();

      debugPrint("dfds");
      if (connection) {
        String url =
            "https://pixabay.com/api/?key=25050907-a71039efb1f58bc579af5b67f&q=$search&image_type=photo&page=$page";
        var response = await http.get(
          Uri.parse(url),
        );
        return ImagesListModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
