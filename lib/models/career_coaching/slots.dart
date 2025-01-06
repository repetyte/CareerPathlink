class Slot {
  final int id;
  final int coachId;
  final String date;
  final String time;
  final String status; // 'available' or 'booked'

  Slot({
    required this.id,
    required this.coachId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'],
      coachId: json['coach_id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}
