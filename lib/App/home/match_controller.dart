import 'dart:async';

import 'package:fifa_2026_live_score_update/App/models/game_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';
import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:fifa_2026_live_score_update/Common/exeptions/app_exception.dart';
import 'package:fifa_2026_live_score_update/Common/utlis/app_utils.dart';
import 'package:fifa_2026_live_score_update/Services/game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MatchState {
  final List<GameModel> matches;
  final bool isLoading;
  final String? error;
  final bool isNetworkError;
  final LiveScoreFilter liveFilter;
  final String selectedDate;
  final String searchQuery;

  const MatchState({
    this.matches = const [],
    this.isLoading = false,
    this.error,
    this.isNetworkError = false,
    this.liveFilter = LiveScoreFilter.all,
    this.selectedDate = '',
    this.searchQuery = '',
  });

  MatchState copyWith({
    List<GameModel>? matches,
    bool? isLoading,
    String? error,
    bool? isNetworkError,
    LiveScoreFilter? liveFilter,
    String? selectedDate,
    bool clearError = false,
    String? searchQuery,
  }) {
    return MatchState(
      matches: matches ?? this.matches,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      isNetworkError: clearError
          ? false
          : (isNetworkError ?? this.isNetworkError),
      liveFilter: liveFilter ?? this.liveFilter,
      selectedDate: selectedDate ?? this.selectedDate,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final matchProvider = StateNotifierProvider<MatchController, MatchState>(
  (ref) => MatchController(),
);

final homeScrollProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

class MatchController extends StateNotifier<MatchState> {
  final _service = GameService();
  Timer? _timer;
  late final Future<void> initialLoad;

  MatchController() : super(const MatchState()) {
    initialLoad = fetch();
    _startPolling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _service.getGames();
      final dates = _uniqueDates(data);
      state = state.copyWith(
        matches: data,
        isLoading: false,
        selectedDate: state.selectedDate.isEmpty && dates.isNotEmpty
            ? dates.first
            : state.selectedDate,
      );
    } catch (e) {
      final isNetwork = e is AppException && e.isNetworkError;
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst('Exception: ', ''),
        isNetworkError: isNetwork,
      );
    }
  }

  void setLiveFilter(LiveScoreFilter f) =>
      state = state.copyWith(liveFilter: f);
  void setDate(String date) => state = state.copyWith(selectedDate: date);

  List<GameModel> filteredHomeMatches() {
    final base = state.matches;

    final filtered = switch (state.liveFilter) {
      LiveScoreFilter.all => [...base],
      LiveScoreFilter.live => base.where((m) => m.isLive).toList(),
      LiveScoreFilter.finished => base.where((m) => m.isFinished).toList(),
      LiveScoreFilter.upcoming => base.where((m) => m.isUpcoming).toList(),
    };

    // Apply search on top of filter
    final query = state.searchQuery;
    final searched = query.isEmpty
        ? filtered
        : filtered.where((m) {
            return m.homeTeamNameEn.toLowerCase().contains(query) ||
                m.awayTeamNameEn.toLowerCase().contains(query) ||
                m.homeTeamNameFa.contains(query) ||
                m.awayTeamNameFa.contains(query);
          }).toList();

    searched.sort((a, b) {
      final aDate = a.localDate ?? DateTime(9999);
      final bDate = b.localDate ?? DateTime(9999);
      return aDate.compareTo(bDate);
    });

    return searched;
  }

  List<String> fixtureDates() => _uniqueDates(state.matches);

  List<GameModel> matchesForDate() {
    if (state.selectedDate.isEmpty) return [];
    return state.matches.where((m) => m.dateKey == state.selectedDate).toList()
      ..sort((a, b) {
        final aDate = a.localDate ?? DateTime(0);
        final bDate = b.localDate ?? DateTime(0);
        return aDate.compareTo(bDate);
      });
  }

  Map<String, List<GameModel>> groupByGroup(List<GameModel> matches) {
    final map = <String, List<GameModel>>{};
    for (final m in matches) {
      final key = m.isGroupStage ? m.group : m.stageLabel;
      map.putIfAbsent(key, () => []).add(m);
    }
    for (final k in map.keys) {
      map[k]!.sort((a, b) {
        final aDate = a.localDate ?? DateTime(0);
        final bDate = b.localDate ?? DateTime(0);
        return aDate.compareTo(bDate);
      });
    }
    // Sort: group stage groups first (single letter), then knockout rounds
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) {
        final aIsGroup = a.key.length == 1;
        final bIsGroup = b.key.length == 1;
        if (aIsGroup && bIsGroup) return a.key.compareTo(b.key);
        if (aIsGroup) return -1;
        if (bIsGroup) return 1;
        return a.key.compareTo(b.key);
      }),
    );
  }

  String tabLabel(String dateKey) {
    try {
      final parts = dateKey.split('/');
      if (parts.length == 3) {
        final dt = DateTime(
          int.parse(parts[2]),
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
        return AppUtils.formatTabDate(dt);
      }
    } catch (_) {}
    return dateKey;
  }

  Future<void> _silentRefresh() async {
    try {
      final data = await _service.getGames();
      state = state.copyWith(matches: data);
    } catch (_) {}
  }

  void _startPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: AppConstants.pollIntervalSeconds),
      (_) => _silentRefresh(),
    );
  }

  List<String> _uniqueDates(List<GameModel> matches) {
    return matches
        .map((m) => m.dateKey)
        .where((d) => d.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  void setSearch(String query) {
    state = state.copyWith(searchQuery: query.trim().toLowerCase());
  }

  void clearSearch() {
    state = state.copyWith(searchQuery: '');
  }
}
