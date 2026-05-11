import 'package:core/constants/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_cubit.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_state.dart';
import 'package:handbook_for_valorant/product/widgets/settings/product_settings_group.dart';
import 'package:handbook_for_valorant/product/widgets/settings/product_settings_tile.dart';
import 'package:theme_module/theme_module.dart';

class DataSection extends StatelessWidget {
  const DataSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return ProductSettingsGroup(label: LocaleKeys.settings_section_data.tr(), children: const [_ClearCacheTile()]);
  }
}

class _ClearCacheTile extends StatelessWidget {
  const _ClearCacheTile();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, bool>(
      selector: (state) => state.isClearingCache,
      builder: (context, isClearingCache) {
        if (isClearingCache) {
          return ProductSettingsTile.action(
            label: LocaleKeys.settings_data_clearCache.tr(),
            icon: Icons.delete_outline,
            onTap: () {},
            trailing: SizedBox(
              width: CustomWidgetDimensions.clearCacheIndicatorSize,
              height: CustomWidgetDimensions.clearCacheIndicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: CustomWidgetDimensions.clearCacheIndicatorStrokeWidth,
                color: context.colorScheme.primary,
              ),
            ),
          );
        }
        return ProductSettingsTile.action(
          label: LocaleKeys.settings_data_clearCache.tr(),
          icon: Icons.delete_outline,
          onTap: () => context.read<ProfileCubit>().clearCache(),
        );
      },
    );
  }
}
