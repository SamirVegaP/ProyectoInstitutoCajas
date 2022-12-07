import 'package:intl/intl.dart';

class User {
  late String useId;
  late String useName;
  late int useAge;
  late String useEmail;
  late String usePhone;
  late String useCarrier;
  late String usePhrase;
  late String useImg;
  late String useBirthday;

  User({
    this.useId = "",
    required this.useName,
    required this.useAge,
    required this.useEmail,
    required this.usePhone,
    required this.useCarrier,
    required this.usePhrase,
    required this.useImg,
    required this.useBirthday,
  });
  Map<String, dynamic> toJson() => {
        "useId": useId,
        "useName": useName,
        "useAge": useAge,
        "useEmail": useEmail,
        "usePhone": usePhone,
        "useCarrier": useCarrier,
        "usePhrase": usePhrase,
        "useImg": useImg,
        "useBirthday": useBirthday,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        useId: json['useId'],
        useName: json['useName'],
        useAge: json['useAge'],
        useEmail: json['useEmail'],
        usePhone: json['usePhone'],
        useCarrier: json['useCarrier'],
        usePhrase: json['usePhrase'],
        useImg: json['useImg'],
        useBirthday: json['useBirthday'],
      );
}
