import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
    String name;
    String email;
    String msg;

    Contact({
        required this.name,
        required this.email,
        required this.msg,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        email: json["email"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "msg": msg,
    };
}