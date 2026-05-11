import 'package:core/constants/dimensions.dart';
import 'package:gap/gap.dart';

class Gaps {
  Gaps._();

  /// Value is [0]
  static const Gap g0 = Gap(Dimensions.k0);

  /// Value is [2]
  static const Gap g2 = Gap(Dimensions.k2);

  /// Value is [4]
  static const Gap g4 = Gap(Dimensions.k4);

  /// Value is [6]
  static const Gap g6 = Gap(Dimensions.k6);

  /// Value is [8]
  static const Gap g8 = Gap(Dimensions.k8);

  /// Value is [10]
  static const Gap g10 = Gap(Dimensions.k10);

  /// Value is [12]
  static const Gap g12 = Gap(Dimensions.k12);

  /// Value is [16]
  static const Gap g16 = Gap(Dimensions.k16);

  /// Value is [20]
  static const Gap g20 = Gap(Dimensions.k20);

  /// Value is [24]
  static const Gap g24 = Gap(Dimensions.k24);

  /// Value is [32]
  static const Gap g32 = Gap(Dimensions.k32);

  /// Value is [48]
  static const Gap g48 = Gap(Dimensions.k48);

  /// Creates a [Gap] with a dynamic [value].
  static Gap custom(double value) => Gap(value);

  // TODO: Remove old aliases after migrating all features to g-prefixed names
  static const Gap zero = g0;
  static const Gap xxs = g2;
  static const Gap xs = g4;
  static const Gap xsm = g6;
  static const Gap sm = g8;
  static const Gap smd = g10;
  static const Gap md = g12;
  static const Gap lg = g16;
  static const Gap xl = g24;
  static const Gap xxl = g32;
  static const Gap xxxl = g48;
}
