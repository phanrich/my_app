part of 'app_theme_bloc.dart';

abstract class AppThemeEvent extends Equatable {
  const AppThemeEvent();
  @override
  List<Object?> get props => [];
}

class ThemeOffChange extends AppThemeEvent {}

class ThemeOnChange extends AppThemeEvent {}
