import 'package:fifa_2026_live_score_update/App/models/team_model.dart';
import 'package:fifa_2026_live_score_update/Services/team_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TeamState {
  final List<TeamModel> teams;
  final bool isLoading;
  final String? error;
  final String selectedGroup;

  const TeamState({
    this.teams = const [],
    this.isLoading = false,
    this.error,
    this.selectedGroup = 'All',
  });

  TeamState copyWith({
    List<TeamModel>? teams,
    bool? isLoading,
    String? error,
    String? selectedGroup,
    bool clearError = false,
  }) {
    return TeamState(
      teams: teams ?? this.teams,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedGroup: selectedGroup ?? this.selectedGroup,
    );
  }

  List<String> get groupFilters {
    final names = teams.map((t) => t.group).toSet().toList()..sort();
    return ['All', ...names];
  }

  Map<String, List<TeamModel>> get teamsByGroup {
    final filtered = selectedGroup == 'All'
        ? teams
        : teams.where((t) => t.group == selectedGroup);
    final map = <String, List<TeamModel>>{};
    for (final t in filtered) {
      map.putIfAbsent(t.group, () => []).add(t);
    }
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  TeamModel? findById(String id) {
    try {
      return teams.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}

final teamProvider = StateNotifierProvider<TeamController, TeamState>((ref) {
  return TeamController();
});

final teamScrollProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

class TeamController extends StateNotifier<TeamState> {
  final _service = TeamService();
  late final Future<void> initialLoad; 

  TeamController() : super(const TeamState()) {
    initialLoad = fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _service.getTeams();
      state = state.copyWith(teams: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void selectGroup(String g) => state = state.copyWith(selectedGroup: g);
}
