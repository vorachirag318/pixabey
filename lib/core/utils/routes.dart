import 'package:get/get.dart';
import 'package:pixabay/ui/image_screen/fullImageScreen.dart';
import 'package:pixabay/ui/image_screen/imageListScreen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: ImageListScreen.routeName, page: () => ImageListScreen()),
  GetPage(name: FullImageScreen.routeName, page: () => FullImageScreen()),
];
