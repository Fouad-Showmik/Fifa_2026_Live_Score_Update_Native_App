
import 'package:fifa_2026_live_score_update/App/models/stadium_model.dart';
import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:fifa_2026_live_score_update/Services/stadium_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class VenueState {
  final List<StadiumModel> stadiums;
  final bool               isLoading;
  final String?            error;
  final StadiumCountry     selectedCountry;

  const VenueState({
    this.stadiums        = const [],
    this.isLoading       = false,
    this.error,
    this.selectedCountry = StadiumCountry.all,
  });

  VenueState copyWith({
    List<StadiumModel>? stadiums,
    bool?               isLoading,
    String?             error,
    StadiumCountry?     selectedCountry,
    bool                clearError = false,
  }) {
    return VenueState(
      stadiums:        stadiums        ?? this.stadiums,
      isLoading:       isLoading       ?? this.isLoading,
      error:           clearError      ? null : (error ?? this.error),
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }

  List<StadiumModel> get filtered => switch (selectedCountry) {
    StadiumCountry.all    => stadiums,
    StadiumCountry.usa    => stadiums.where((s) => s.isUSA).toList(),
    StadiumCountry.canada => stadiums.where((s) => s.isCanada).toList(),
    StadiumCountry.mexico => stadiums.where((s) => s.isMexico).toList(),
  };

  StadiumModel? findById(String id) {
    try { return stadiums.firstWhere((s) => s.id == id); } catch (_) { return null; }
  }
}


final venueProvider = StateNotifierProvider<VenueController, VenueState>((ref) {
  return VenueController();
});

final venueScrollProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

class VenueController extends StateNotifier<VenueState> {
  final _service = StadiumService();

  VenueController() : super(const VenueState()) {
    fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _service.getStadiums();
      state = state.copyWith(stadiums: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void selectCountry(StadiumCountry c) => state = state.copyWith(selectedCountry: c);
}

