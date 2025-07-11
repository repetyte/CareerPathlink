class Coach1 {
  final int id;
  final String coachName;
  final String coachRole;
  final String imageUrl;

  Coach1({
    required this.id,
    required this.coachName,
    this.coachRole = 'Career Advisor', // Default value
    this.imageUrl = '', // Default empty string
  });

  factory Coach1.fromJson(Map<String, dynamic> json) {
    return Coach1(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      coachName: json['coach_name']?.toString() ?? 'Unknown Coach',
      coachRole: json['coach_role']?.toString() ?? 'Career Advisor',
      imageUrl: json['image_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coach_name': coachName,
      'coach_role': coachRole,
      'image_url': imageUrl,
    };
  }
}