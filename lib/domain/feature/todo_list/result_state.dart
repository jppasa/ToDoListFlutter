abstract class ResultState {
  ResultState._();

  factory ResultState.success() = SyncStateSuccess;

  factory ResultState.error(String? message) = SyncStateError;
}

class SyncStateSuccess extends ResultState {
  SyncStateSuccess() : super._();
}

class SyncStateError extends ResultState {
  final String? errorMessage;

  SyncStateError(this.errorMessage) : super._();
}