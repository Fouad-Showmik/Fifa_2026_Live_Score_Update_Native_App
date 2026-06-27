
import 'package:fifa_2026_live_score_update/App/venues/venue_controller.dart';
import 'package:fifa_2026_live_score_update/App/venues/widgets/venu_card.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_top_bar.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/empty_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/error_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/filter_pill.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VenuesPage extends ConsumerWidget {
  const VenuesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(venueProvider);

    return Scaffold(
      appBar: const AppTopBar(
        title: 'Venues',
        // actions: [AppIconButton(icon: Icons.map_outlined, onTap: () {})],
      ),
      body: Builder(builder: (_) {
        if (state.isLoading && state.stadiums.isEmpty) return const LoadingWidget();
        if (state.error != null && state.stadiums.isEmpty) {
          return ErrorStateWidget(
            message: state.error!,
            onRetry: () => ref.read(venueProvider.notifier).fetch(),
          );
        }
        return Column(
          children: [
            const SizedBox(height: 4),
            _CountryFilter(
              selected: state.selectedCountry,
              total: state.stadiums.length,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Builder(builder: (_) {
                final list = state.filtered;
                if (list.isEmpty) {
                  return const EmptyStateWidget(
                    message: 'No venues for this region',
                    icon: Icons.stadium_outlined,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => ref.read(venueProvider.notifier).fetch(),
                  color: AppColors.gold,
                  backgroundColor: AppColors.surface,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: list.length,
                        itemBuilder: (_, i) => VenueCard(stadium: list[i]),
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

class _CountryFilter extends ConsumerWidget {
  final StadiumCountry selected;
  final int total;
  const _CountryFilter({required this.selected, required this.total});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: StadiumCountry.values.map((c) {
          final lbl = c == StadiumCountry.all ? 'All ($total)' : c.displayName;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterPill(
              label: lbl,
              isActive: selected == c,
              onTap: () => ref.read(venueProvider.notifier).selectCountry(c),
            ),
          );
        }).toList(),
      ),
    );
  }
}
