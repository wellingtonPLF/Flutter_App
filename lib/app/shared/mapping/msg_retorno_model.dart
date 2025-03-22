import 'dart:convert';

MsgRetorno msgRetornoFromJson(String str) => MsgRetorno.fromMap(json.decode(str));

String msgRetornoToJson(MsgRetorno data) => json.encode(data.toMap());

class MsgRetorno {
  String? status;
  String? message;
  String? jwt;
  String? refresh;
  String? email;
  int? expireAt;

  MsgRetorno({
    this.status,
    this.message,
    this.jwt,
    this.refresh,
    this.email,
    this.expireAt,
  });

  factory MsgRetorno.fromMap(Map<String, dynamic> json) => MsgRetorno(
        status: json["status"],
        message: json["message"],
        jwt: json["jwt"],
        refresh: json["refresh"],
        email: json["email"],
        expireAt: json["expireAt"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "jwt": jwt,
        "refresh": refresh,
        "email": email,
        "expireAt": expireAt,
      };

  @override
  String toString() {
    return "MsgRetorno( status: $status, message: $message, jwt: $jwt, refresh: $refresh, email: $email, expireAt: $expireAt)";
  }
}
