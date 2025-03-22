import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromMap(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserModel {
  int? id;
  String? name;
  String? username;
  String? password;
  String? created;
  String? modified;
  String? email;
  String? recuperarSenha;
  String? imagem;
  String? phone;
  dynamic excluido;
  dynamic token;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.password,
    this.created,
    this.modified,
    this.email,
    this.recuperarSenha,
    this.imagem,
    this.phone,
    this.excluido,
    this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        created: json["created"],
        modified: json["modified"],
        email: json["email"],
        recuperarSenha: json["recuperar_senha"],
        imagem: json["imagem"],
        phone: json["phone"],
        excluido: json["excluido"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "password": password,
        "created": created,
        "modified": modified,
        "email": email,
        "recuperar_senha": recuperarSenha,
        "imagem": imagem,
        "phone": phone,
        "excluido": excluido,
        "token": token,
      };

  @override
  String toString() {
    return 'Person(name: $name, username: $username, phone: $phone, email: $email, token: $token, password" $password)';
  }
}
