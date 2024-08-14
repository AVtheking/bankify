class Success {
  final String message;
  final dynamic data;
  Success({
    required this.message,
    this.data,
  });

  @override
  String toString() => message;
}
