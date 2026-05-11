import 'package:objectbox/objectbox.dart';

@Entity()
class ThemeEntity {
  @Id()
  int id = 0;

  String? theme;
}
