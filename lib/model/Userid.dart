class Userid {
  String email = "";
  Userid({
    required this.email,
  });
  Map toJson() => {
        'email': email,
      };

  Userid.fromJson(Map json) {
    email = json['email'];
  }
}
