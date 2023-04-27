import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class FavDataModel {
  @HiveField(0)
  final int movieId;

  FavDataModel({required this.movieId});
}
