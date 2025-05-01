class PendingAppointment {
  final String name;
  final String program;
  final String date;
  final String time;
  final String coach;

  PendingAppointment({
    required this.name,
    required this.program,
    required this.date,
    required this.time,
    required this.coach,
  });

  // Convert a JSON to PendingAppointment
  factory PendingAppointment.fromJson(Map<String, dynamic> json) {
    return PendingAppointment(
      name: json['name'],
      program: json['program'],
      date: json['date'],
      time: json['time'],
      coach: json['coach'],
    );
  }
}
