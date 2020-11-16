class BaseModel {
    int details;
    String message;
    String status;

    BaseModel({this.details, this.message, this.status});

    factory BaseModel.fromJson(Map<String, dynamic> json) {
        return BaseModel(
            details: json['details'], 
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['details'] = this.details;
        data['message'] = this.message;
        data['status'] = this.status;
        return data;
    }
}