import 'package:fifa_2026_live_score_update/App/home/match_controller.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_card_shimmer.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_filter.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_list.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_icon_button.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_top_bar.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isSearching = false;

  void _openSearch() => setState(() => _isSearching = true);

  void _closeSearch() {
    setState(() => _isSearching = false);
    ref.read(matchProvider.notifier).clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(matchProvider);

    return Scaffold(
      appBar: AppTopBar(
        showLogo: true,
        isSearching: _isSearching,
        onSearchChanged: ref.read(matchProvider.notifier).setSearch,
        onSearchClose: _closeSearch,
        actions: [
          AppIconButton(icon: Icons.search_outlined, onTap: _openSearch),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (state.isLoading && state.matches.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heading(),
                const SizedBox(height: 48),
                const MatchCardShimmer(),
              ],
            );
          }
          if (state.error != null && state.matches.isEmpty) {
            return ErrorStateWidget(
              message: state.error!,
              onRetry: () => ref.read(matchProvider.notifier).fetch(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(matchProvider.notifier).fetch(),
            color: AppColors.gold,
            backgroundColor: AppColors.surface,
            child: ListView(
              children: [
                if (!_isSearching) _heading(),
                if (!_isSearching) const SizedBox(height: 4),
                if (!_isSearching) const FilterRow(),
                if (!_isSearching) const SizedBox(height: 8),
                const MatchList(),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _heading() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Text(
        'LIVE SCORES',
        style: TextStyle(
          fontFamily: 'BarlowCondensed',
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.gold,
          letterSpacing: 0.08,
        ),
      ),
    );
  }
}
