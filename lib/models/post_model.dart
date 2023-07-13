class PostModel {
  String department, description, id, link, title;

  PostModel({
    required this.department,
    required this.description,
    required this.id,
    required this.link,
    required this.title,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      department: map['department'].toString(),
      description: map['description'].toString(),
      id: map['id'].toString(),
      link: map['link'].toString(),
      title: map['title'].toString(),
    );
  }
}
