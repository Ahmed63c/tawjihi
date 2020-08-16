class QAndAnswersModel {
    List<Detail> details;
    String message;
    String status;

    QAndAnswersModel({this.details, this.message, this.status});

    factory QAndAnswersModel.fromJson(Map<String, dynamic> json) {
        return QAndAnswersModel(
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
    String answer;
    String answer_pic;
    String created_at;
    int id;
    int material_id;
    int material_section_id;
    int material_unit_id;
    String pics;
    String title;
    String updated_at;

    Detail({this.answer, this.answer_pic, this.created_at, this.id, this.material_id, this.material_section_id, this.material_unit_id, this.pics, this.title, this.updated_at});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            answer: json['answer'],
            answer_pic: json['answer_pic'] != null ? json['answer_pic'] : null,
            created_at: json['created_at'] != null ? json['created_at'] : null,
            id: json['id'],
            material_id: json['material_id'],
            material_section_id: json['material_section_id'],
            material_unit_id: json['material_unit_id'],
            pics: json['pics'] != null ? json['pics'] : null,
            title: json['title'],
            updated_at: json['updated_at'] != null ? json['updated_at']: null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['answer'] = this.answer;
        data['id'] = this.id;
        data['material_id'] = this.material_id;
        data['material_section_id'] = this.material_section_id;
        data['material_unit_id'] = this.material_unit_id;
        data['title'] = this.title;
        if (this.answer_pic != null) {
            data['answer_pic'] = this.answer_pic;
        }
        if (this.created_at != null) {
            data['created_at'] = this.created_at;
        }
        if (this.pics != null) {
            data['pics'] = this.pics;
        }
        if (this.updated_at != null) {
            data['updated_at'] = this.updated_at;
        }
        return data;
    }
}