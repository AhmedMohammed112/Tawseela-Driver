import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectionChecker
{
  Future<bool> get hasConnection;
}

class ConnectionCheckerImpl implements ConnectionChecker
{
  final InternetConnectionChecker internetConnectionChecker;

  ConnectionCheckerImpl(this.internetConnectionChecker);

  @override
  Future<bool> get hasConnection => internetConnectionChecker.hasConnection;
}