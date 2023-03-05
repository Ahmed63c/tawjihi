class VideosModel {
    List<Detail> details;
    String message;
    String status;

    VideosModel({this.details, this.message, this.status});

    factory VideosModel.fromJson(Map<String, dynamic> json) {
        return VideosModel(
            details: json['details'] != null ? (json['details'] as List).map((i) => Detail.fromJson(i)).toList() : null, 
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.details != null) {
            data['details'] = this.details.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Detail {
    String created_at;
    int id;
    int material_id;
    String title;
    String updated_at;
    String video;

    Detail({this.created_at, this.id, this.material_id, this.title, this.updated_at, this.video});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            created_at: json['created_at'],
            id: json['id'],
            material_id: json['material_id'],
            title: json['title'],
            updated_at: json['updated_at'],
            video: json['video'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['material_id'] = this.material_id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        data['video'] = this.video;
        return data;
    }
}