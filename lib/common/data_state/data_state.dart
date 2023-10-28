abstract class DataState<T> {
  final T? data;
  final String? error;

  const DataState({
    this.data,
    this.error,
  });
}

class DataSuccess<T> extends DataState {
  DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState {
  DataFailed(String error) : super(error: error);
}
