import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends HydratedBloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(const AppThemeStateInitial(isDark: true)) {
    on<ThemeOnChange>(((event, emit) {
      emit(const AppThemeState(isDark: true));
    }));
    on<ThemeOffChange>(((event, emit) {
      emit(const AppThemeState(isDark: false));
    }));
  }

  @override
  AppThemeState? fromJson(Map<String, dynamic> json) {
    return AppThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppThemeState state) {
    return state.toMap();
  }
}
