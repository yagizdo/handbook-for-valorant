final class NetworkResult<T> {
  const NetworkResult._({this.error, this.data});

  // Factory constructor for success cases
  factory NetworkResult.success(T data) {
    return NetworkResult._(data: data);
  }

  // Factory constructor for error cases
  factory NetworkResult.error({required String message, int code = 0}) {
    return NetworkResult._(
      error: BaseErrorModel(message: message, code: code),
    );
  }
  final BaseErrorModel? error;
  final T? data;

  // Method to handle success or error cases using a folding function
  R fold<R>({required R Function(BaseErrorModel? error) onError, required R Function(T? data) onSuccess}) {
    if (error != null) {
      return onError(error);
    } else {
      return onSuccess(data);
    }
  }
}

class BaseErrorModel {
  BaseErrorModel({required this.message, required this.code});
  final String message;
  final int code;
}
