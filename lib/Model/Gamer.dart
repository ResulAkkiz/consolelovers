import 'dart:math';

class Gamer {
  String gamerID;
  String gamerEmail;
  String? gamerName;
  String? gamerSurname;
  String? gamerAdress;
  String? gamerPhoneNumber;
  String? gamerProfilePhoto;

  Gamer(
      {required this.gamerID,
      required this.gamerEmail,
      this.gamerName,
      this.gamerSurname,
      this.gamerAdress,
      this.gamerPhoneNumber,
      this.gamerProfilePhoto});

  Map<String, dynamic> toMap() {
    return {
      'gamerID': gamerID,
      'gamerEmail': gamerEmail,
      'gamerName':
          gamerName ?? gamerEmail.substring(0, gamerEmail.indexOf('@')),
      'gamerSurname': gamerSurname ?? buildRandomNumbers(),
      'gamerAdress': gamerAdress ?? 'Empty Adrres',
      'gamerPhoneNumber': gamerPhoneNumber ?? '',
      'gamerProfilePhoto': gamerProfilePhoto ??
          'https://cdn4.iconfinder.com/data/icons/evil-icons-user-interface/64/avatar-512.png',
    };
  }

  factory Gamer.fromMap(Map<String, dynamic> map) {
    return Gamer(
        gamerID: map['gamerID'],
        gamerEmail: map['gamerEmail'],
        gamerName: map['gamerName'],
        gamerSurname: map['gamerSurname'],
        gamerAdress: map['gamerAdress'],
        gamerPhoneNumber: map['gamerPhoneNumber'],
        gamerProfilePhoto: map['gamerProfilePhoto']);
  }

  String buildRandomNumbers() {
    return (Random().nextInt(100)).toString();
  }

  @override
  String toString() {
    return 'Gamer(gamerID: $gamerID, gamerEmail: $gamerEmail, gamerName: $gamerName, gamerSurname: $gamerSurname, gamerAdress: $gamerAdress,gamerPhoneNumber: $gamerPhoneNumber,gamerProfilePhoto:$gamerProfilePhoto)';
  }
}
