class UserModel {
    Details details;
    String message;
    String status;
    UserModel({this.details, this.message, this.status});
    factory UserModel.fromJson(Map<String, dynamic> json) {
        return UserModel(
            details: json['details'] != null ? Details.fromJson(json['details']) : null,
            message: json['message'], 
            status: json['status'], 
        );
    }
}

class User {
    String area;
    String contact_number;
    String created_at;
    String email;
    String email_verified_at;
    int id;
    String lang;
    String major;
    String name;
    String parent_contact_number;
    String school;
    String status;
    String type;
    String updated_at;

    User({this.area, this.contact_number, this.created_at, this.email, this.email_verified_at, this.id, this.lang, this.major, this.name, this.parent_contact_number, this.school, this.status, this.type, this.updated_at});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            area: json['area'],
            contact_number: json['contact_number'],
            created_at: json['created_at'],
            email: json['email'],
            email_verified_at: json['email_verified_at'] != null ?json['email_verified_at'] : null,
            id: json['id'],
            lang: json['lang'],
            major: json['major'],
            name: json['name'],
            parent_contact_number: json['parent_contact_number'],
            school: json['school'],
            status: json['status'],
            type: json['type'],
            updated_at: json['updated_at'],
        );
    }
}


class Details {
    String access_token;
    int expires_in;
    String token_type;
    User user;
    List<Configuration> configuration;
    String appVersion;

    Details({this.access_token, this.expires_in, this.token_type, this.user,this.configuration,this.appVersion});

    factory Details.fromJson(Map<String, dynamic> json) {
        return Details(
            access_token: json['access_token'],
            expires_in: json['expires_in'],
            token_type: json['token_type'],
            appVersion: json['appVersion'],

            user: json['user'] != null ? User.fromJson(json['user']) : null,
            configuration: json['configuration'] != null ?
            (json['configuration'] as List).map((i) => Configuration.fromJson(i)).toList() : null,

        );
    }
}

class Configuration {
    int id;
    String name;
    String value;

    Configuration({this.id, this.name, this.value});

    factory Configuration.fromJson(Map<String, dynamic> json) {
        return Configuration(
            id: json['id'],
            name: json['name'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['value'] = this.value;
        return data;
    }
}