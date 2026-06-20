import 'package:fifa_2026_live_score_update/App/fixture/fixtures_page.dart';
import 'package:fifa_2026_live_score_update/App/group/group_page.dart';
import 'package:fifa_2026_live_score_update/App/home/home_page.dart';
import 'package:fifa_2026_live_score_update/App/root/root_controller.dart';
import 'package:fifa_2026_live_score_update/App/teams/teams_page.dart';
import 'package:fifa_2026_live_score_update/App/venues/venue_page.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(navTabProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentTab.index,
        children: const [
          HomePage(),
          FixturesPage(),
          GroupsPage(),
          VenuesPage(),
          TeamsPage(),
        ],
      ),
      bottomNavigationBar: _BottomNav(currentTab: currentTab),
    );
  }
}

class _BottomNav extends ConsumerWidget {
  final NavTab currentTab;
  const _BottomNav({required this.currentTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: NavTab.values.map((tab) {
              final isActive = currentTab == tab;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => ref.read(navTabProvider.notifier).state = tab,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _iconFor(tab),
                        size: 22,
                        color: isActive ? AppColors.gold : AppColors.textSecondary,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _labelFor(tab),
                        style: AppTextStyles.navLabel.copyWith(
                          color: isActive ? AppColors.gold : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(NavTab t) => switch (t) {
    NavTab.home     => Icons.home_outlined,
    NavTab.fixtures => Icons.calendar_today_outlined,
    NavTab.groups   => Icons.shield_outlined,
    NavTab.venues   => Icons.place_outlined,
    NavTab.teams    => Icons.people_outline,
  };

  String _labelFor(NavTab t) => switch (t) {
    NavTab.home     => 'Home',
    NavTab.fixtures => 'Fixtures',
    NavTab.groups   => 'Groups',
    NavTab.venues   => 'Venues',
    NavTab.teams    => 'Teams',
  };
}
