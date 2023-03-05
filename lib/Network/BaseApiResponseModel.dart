class BaseResponse {
  String message;
  String status;
  BaseResponse({ this.message, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'],
      status: json['status'],
    );
  }

}