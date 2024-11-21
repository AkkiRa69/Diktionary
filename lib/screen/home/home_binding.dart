part of 'home_view.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewController());
  }
}
