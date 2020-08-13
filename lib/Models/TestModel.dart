class TestModel {
    List<Detail> details;
    String message;
    String status;

    TestModel({this.details, this.message, this.status});

    factory TestModel.fromJson(Map<String, dynamic> json) {
        return TestModel(
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
    String answer1;
    String answer2;
    String answer3;
    String answer4;
    String correct_answer;
    String created_at;
    int id;
    int material_id;
    int material_unit_id;
    String pics;
    String status;
    String title;
    String updated_at;

    Detail({this.answer1, this.answer2, this.answer3, this.answer4, this.correct_answer, this.created_at, this.id, this.material_id, this.material_unit_id, this.pics, this.status, this.title, this.updated_at});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            answer1: json['answer1'],
            answer2: json['answer2'],
            answer3: json['answer3'],
            answer4: json['answer4'],
            correct_answer: json['correct_answer'],
            created_at: json['created_at'],
            id: json['id'],
            material_id: json['material_id'],
            material_unit_id: json['material_unit_id'],
            pics: json['pics'],
            status: json['status'],
            title: json['title'],
            updated_at: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['answer1'] = this.answer1;
        data['answer2'] = this.answer2;
        data['answer3'] = this.answer3;
        data['answer4'] = this.answer4;
        data['correct_answer'] = this.correct_answer;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['material_id'] = this.material_id;
        data['material_unit_id'] = this.material_unit_id;
        data['pics'] = this.pics;
        data['status'] = this.status;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}