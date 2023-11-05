import 'package:hive/hive.dart';
part 'fav_dao.g.dart';

@HiveType(typeId: 2)
class FavDao {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int id;
  FavDao({required this.name, required this.id});
}
