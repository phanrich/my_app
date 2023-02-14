part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus appStatus;
  final Account account;

  const AppState._({required this.appStatus, this.account = Account.empty});

  const AppState.authenticated(Account account)
      : this._(
          appStatus: AppStatus.authenticated,
          account: account,
        );

  const AppState.unauthenticated()
      : this._(appStatus: AppStatus.unauthenticated);
  @override
  List<Object> get props => [appStatus, account];
}
