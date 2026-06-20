import 'package:fifa_2026_live_score_update/App/models/group_model.dart';
import 'package:fifa_2026_live_score_update/Services/group_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class GroupState {
  final List<GroupModel> groups;
  final bool isLoading;
  final String? error;
  final String selectedGroup;

  const GroupState({
    this.groups = const [],
    this.isLoading = false,
    this.error,
    this.selectedGroup = 'A',
  });

  GroupState copyWith({
    List<GroupModel>? groups,
    bool? isLoading,
    String? error,
    String? selectedGroup,
    bool clearError = false,
  }) {
    return GroupState(
      groups: groups ?? this.groups,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedGroup: selectedGroup ?? this.selectedGroup,
    );
  }

  GroupModel? get currentGroup {
    try {
      return groups.firstWhere((g) => g.name == selectedGroup);
    } catch (_) {
      return groups.isEmpty ? null : groups.first;
    }
  }

  List<String> get groupNames => groups.map((g) => g.name).toList();
}

final groupProvider = StateNotifierProvider<GroupController, GroupState>((ref) {
  return GroupController();
});

class GroupController extends StateNotifier<GroupState> {
  final _service = GroupService();

  GroupController() : super(const GroupState()) {
    fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _service.getGroups();
      state = state.copyWith(
        groups: data,
        isLoading: false,
        selectedGroup: data.isNotEmpty ? data.first.name : 'A',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void selectGroup(String name) => state = state.copyWith(selectedGroup: name);
}

