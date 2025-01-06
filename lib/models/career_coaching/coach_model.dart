class Coach {
  final int id;
  final String name;

  Coach({required this.id, required this.name});

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(id: json['id'], name: json['name']);
  }
}
