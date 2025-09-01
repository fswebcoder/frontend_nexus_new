
class GeneralResponse<T> {
    bool? success;
    int? statusCode;
    DateTime? timestamp;
    String? path;
    String? message;
    T? data;

    GeneralResponse({
        this.success,
        this.statusCode,
        this.timestamp,
        this.path,
        this.message,
        this.data,
    });

  factory GeneralResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
    ) {
      return GeneralResponse<T>(
        success: json['success'] ?? false,
        statusCode: json['statusCode'] ?? 0,
        timestamp: DateTime.parse(json['timestamp']),
        path: json['path'] ?? '',
        message: json['message'] ?? '',
        data: json['data'] != null ? fromJsonT(json['data']) : null,
      );
    }


     Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'statusCode': statusCode,
      'timestamp': timestamp?.toIso8601String(),
      'path': path,
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
