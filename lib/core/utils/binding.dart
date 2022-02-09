import 'package:get/get.dart';
import 'package:pixabay/ui/image_screen/controller/imageListController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageListController>(() => ImageListController(), fenix: true);
  }
}
