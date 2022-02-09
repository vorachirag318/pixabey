import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:pixabay/core/service/repo/image_repo.dart';
import 'package:pixabay/ui/image_screen/model/imageListModel.dart';

class ImageListController extends GetxController {
  GlobalKey<PaginationViewState> imageSearchPaginationKey =
      GlobalKey<PaginationViewState>();
  String _searchImage = "";

  String get searchImage => _searchImage;

  set searchImage(String value) {
    _searchImage = value;
    update();
  }

  int _page = 0;

  int get page => _page;

  set page(int value) {
    _page = value;
    update();
  }

  late bool _hasMore;

  bool get hasMore => _hasMore;

  set hasMore(bool value) {
    _hasMore = value;
    update();
  }

  List<Hit> _imageList = [];

  List<Hit> get imageList => _imageList;

  set imageList(List<Hit> value) {
    _imageList = value;
    update();
  }

  bool _loader = false;

  bool get loader => _loader;

  set loader(bool value) {
    _loader = value;
    update();
  }

  Future fetchAllImagesList() async {
    print("hello fdhfdh");
    if (imageList.isEmpty) {
      loader = true;
    }
    page++;
    var response =
        await ImageRepo.fetchImageList(page: page, search: searchImage);
    if (response != null) {
      print(page);
      loader = false;
      imageList.addAll(response.hits.map((e) => e));
      if (page * 20 < response.totalHits) {
        hasMore = true;
      } else {
        hasMore = false;
      }
    }
    update();
  }
}
