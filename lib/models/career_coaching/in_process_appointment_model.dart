class InProcessAppointment {
  final String name;
  final String program;
  final String date;
  final String time;
  final String coach;

  InProcessAppointment({
    required this.name,
    required this.program,
    required this.date,
    required this.time,
    required this.coach,
  });

  factory InProcessAppointment.fromJson(Map<String, dynamic> json) {
    return InProcessAppointment(
      name: json['name'],
      program: json['program_request'], // Adjusted to match the response key
      date: json['date_request'], // Adjusted to match the response key
      time: json['time_request'], // Adjusted to match the response key
      coach: json['coach'] ??
          '', // Added coach field, it should come from the response
    );
  }
}
