import 'package:diktionary/screen/search/search_controller.dart';
import 'package:get/get.dart';

class SearchViewBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => SearchViewController(),
    );
  }
}
