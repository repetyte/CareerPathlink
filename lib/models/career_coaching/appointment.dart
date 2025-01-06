class Service {
  final int id;
  final String serviceName;
  final String description;
  final String
      programName; // This can be linked to the programs table in the database
  final DateTime createdAt;

  Service({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.programName,
    required this.createdAt,
  });

  // Factory constructor to create a Service object from a JSON response
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
      description: json['description'],
      programName: json['program_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert the Service object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_name': serviceName,
      'description': description,
      'program_name': programName,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
