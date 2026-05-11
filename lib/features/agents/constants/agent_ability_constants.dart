import 'package:gen/gen.dart';

class AgentAbilityConstants {
  AgentAbilityConstants._();

  static String get sectionTitle => LocaleKeys.agents_section_abilities.tr().toUpperCase();

  static const Map<String, String> abilitySlotKeys = {
    'Ability1': 'Q',
    'Ability2': 'E',
    'Grenade': 'C',
    'Ultimate': 'X',
  };
}
