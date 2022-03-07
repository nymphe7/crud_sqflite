

class Contact {
  int? id;
  String name;
  String mobile;

  Contact({this.id, required this.name, required this.mobile});

  factory Contact.fromMap(Map<String, dynamic> json) =>
      Contact(id: json['id'], name: json['name'], mobile: json['mobile']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'mobile': mobile};
  }
}
