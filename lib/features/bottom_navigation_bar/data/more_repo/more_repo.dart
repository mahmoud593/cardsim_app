import 'package:games_app/features/bottom_navigation_bar/data/models/more_model.dart';

abstract class MoreRepo {
  Future<MoreModel> getMoreData({required String key});
}