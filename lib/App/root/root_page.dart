import 'package:fifa_2026_live_score_update/App/fixture/fixtures_page.dart';
import 'package:fifa_2026_live_score_update/App/group/group_page.dart';
import 'package:fifa_2026_live_score_update/App/home/home_page.dart';
import 'package:fifa_2026_live_score_update/App/home/match_controller.dart';
import 'package:fifa_2026_live_score_update/App/root/root_controller.dart';
import 'package:fifa_2026_live_score_update/App/teams/team_controller.dart';
import 'package:fifa_2026_live_score_update/App/teams/teams_page.dart';
import 'package:fifa_2026_live_score_update/App/venues/venue_controller.dart';
import 'package:fifa_2026_live_score_update/App/venues/venue_page.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 10));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
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

class _BottomNav extends ConsumerStatefulWidget {
  final NavTab currentTab;
  const _BottomNav({required this.currentTab});

  @override
  ConsumerState<_BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<_BottomNav> {
  void _onTabTapped(NavTab tab) {
    final current = ref.read(navTabProvider);

    if (tab == current) {
      // Same tab tapped again, scroll to top
      _scrollToTop(tab);
    } else {
      ref.read(navTabProvider.notifier).state = tab;
    }
  }

  void _scrollToTop(NavTab tab) {
    switch (tab) {
      case NavTab.home:
        final c = ref.read(homeScrollProvider);
        if (c.hasClients) {
          c.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      case NavTab.venues:
        final c = ref.read(venueScrollProvider);
        if (c.hasClients) {
          c.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      case NavTab.teams:
        final c = ref.read(teamScrollProvider);
        if (c.hasClients) {
          c.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(navTabProvider);

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
                  onTap: () =>
                      _onTabTapped(tab), // changed from direct state set
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _iconFor(tab),
                        size: 22,
                        color: isActive
                            ? AppColors.gold
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _labelFor(tab),
                        style: AppTextStyles.navLabel.copyWith(
                          color: isActive
                              ? AppColors.gold
                              : AppColors.textSecondary,
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
    NavTab.home => Icons.home_outlined,
    NavTab.fixtures => Icons.calendar_today_outlined,
    NavTab.groups => Icons.shield_outlined,
    NavTab.venues => Icons.place_outlined,
    NavTab.teams => Icons.people_outline,
  };

  String _labelFor(NavTab t) => switch (t) {
    NavTab.home => 'Home',
    NavTab.fixtures => 'Fixtures',
    NavTab.groups => 'Groups',
    NavTab.venues => 'Venues',
    NavTab.teams => 'Teams',
  };
}
