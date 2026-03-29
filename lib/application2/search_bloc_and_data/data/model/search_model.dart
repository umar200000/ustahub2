import 'package:ustahub/application2/service_bloc_and_data/data/model/service_model.dart';

class SearchListResponse {
  final bool? success;
  final List<ServicesModel>? data;
  final String? message;
  final dynamic error;

  SearchListResponse({this.success, this.data, this.message, this.error});

  factory SearchListResponse.fromJson(Map<String, dynamic> json) =>
      SearchListResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<ServicesModel>.from(
                json["data"].map((x) => ServicesModel.fromJson(x)),
              ),
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? null
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "error": error,
  };
}
