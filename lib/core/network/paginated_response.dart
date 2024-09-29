class PaginatedResponse<T> {
  final int pageSize;
  final int pageIndex;
  final int totalRecords;
  final int totalPages;
  final List<T> data;

  PaginatedResponse({
    required this.pageSize,
    required this.pageIndex,
    required this.totalRecords,
    required this.totalPages,
    required this.data,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    return PaginatedResponse(
      pageSize: json['pageSize'],
      pageIndex: json['pageIndex'],
      totalRecords: json['totalRecords'],
      totalPages: json['totalPages'],
      data: (json['data'] as List).map((e) => fromJson(e)).toList(),
    );
  }
}
