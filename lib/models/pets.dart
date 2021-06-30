class Pets {
  String id;
  String ownerId;
  String imgUrl;
  String name;
  String gender;
  String age;
  String category;
  String location;
  String breed;
  String description;
  DateTime postedAt;

  Pets({
    this.id,
    this.ownerId,
    this.imgUrl,
    this.name,
    this.gender,
    this.age,
    this.category,
    this.location,
    this.breed,
    this.description,
    this.postedAt,
  });

  Pets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    imgUrl = json['imgUrl'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    category = json['category'];
    location = json['location'];
    breed = json['breed'];
    description = json['description'];
    postedAt = json['postedAt'].toDate();
  }
}