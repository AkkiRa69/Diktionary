import 'package:diktionary/screen/home/home_view.dart';
import 'package:diktionary/screen/search/search_binding.dart';
import 'package:diktionary/screen/search/search_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: HomeViewBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => SearchView(),
      binding: SearchViewBinding(),
    ),
  ];
}
