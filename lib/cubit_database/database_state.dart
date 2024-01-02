part of 'database_cubit.dart';

@immutable
sealed class DatabaseState {}

final class InitDatabaseState extends DatabaseState {}
final class LoadDatabaseState extends DatabaseState {}
