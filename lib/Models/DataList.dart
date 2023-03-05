class DataList {
    List<Detail> details;
    String message;
    String status;

    DataList({this.details, this.message, this.status});

    factory DataList.fromJson(Map<String, dynamic> json) {
        return DataList(
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
    String description;
    int id;
    int material_id;
    int material_section_id;
    String pics;
    String status;
    String title;
    String type;
    String updated_at;

    Detail({this.created_at, this.description, this.id, this.material_id, this.material_section_id, this.pics, this.status, this.title, this.type, this.updated_at});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            created_at: json['created_at'],
            description: json['description'],
            id: json['id'],
            material_id: json['material_id'],
            material_section_id: json['material_section_id'],
            pics: json['pics'],
            status: json['status'],
            title: json['title'],
            type: json['type'],
            updated_at: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['description'] = this.description;
        data['id'] = this.id;
        data['material_id'] = this.material_id;
        data['material_section_id'] = this.material_section_id;
        data['pics'] = this.pics;
        data['status'] = this.status;
        data['title'] = this.title;
        data['type'] = this.type;
        data['updated_at'] = this.updated_at;
        return data;
    }
}