class Slot {
  final int id;
  final int coachId;
  final String date;
  final String time;
  final String status;

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
      date: json['date'], // Assuming 'date' is a string like "2024-12-28"
      time: json['time'], // Assuming 'time' is a string like "10:00:00"
      status: json['status'], // "available" or "booked"
    );
  }

  get availableSlots => null;
}
