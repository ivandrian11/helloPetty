class Users {
  String id;
  String photoURL;
  String displayName;
  String email;
  String phoneNumber;

  Users({
    this.id,
    this.photoURL,
    this.displayName,
    this.email,
    this.phoneNumber,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoURL = json['photoURL'];
    displayName = json['displayName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}
