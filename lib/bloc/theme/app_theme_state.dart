part of 'app_theme_bloc.dart';

class AppThemeState extends Equatable {
  final bool isDark;
  const AppThemeState({required this.isDark});
  @override
  List<Object?> get props => [isDark];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDark': isDark,
    };
  }

  factory AppThemeState.fromMap(Map<String, dynamic> map) {
    return AppThemeState(
      isDark: map['isDark'],
    );
  }
}

class AppThemeStateInitial extends AppThemeState {
  const AppThemeStateInitial({required bool isDark}) : super(isDark: isDark);
}
