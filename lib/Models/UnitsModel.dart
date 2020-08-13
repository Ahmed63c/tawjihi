class UnitsModel {
    List<Detail> details;
    String message;
    String status;

    UnitsModel({this.details, this.message, this.status});

    factory UnitsModel.fromJson(Map<String, dynamic> json) {
        return UnitsModel(
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
    String name;
    String status;
    String term;
    String updated_at;

    Detail({this.created_at, this.id, this.material_id, this.name, this.status, this.term, this.updated_at});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            created_at: json['created_at'],
            id: json['id'],
            material_id: json['material_id'],
            name: json['name'],
            status: json['status'],
            term: json['term'],
            updated_at: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['material_id'] = this.material_id;
        data['name'] = this.name;
        data['status'] = this.status;
        data['term'] = this.term;
        data['updated_at'] = this.updated_at;
        return data;
    }
}