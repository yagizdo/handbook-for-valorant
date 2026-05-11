import 'package:objectbox/objectbox.dart';

@Entity()
class ThemeModel {
  @Id()
  int id = 0;

  String? theme;
}
