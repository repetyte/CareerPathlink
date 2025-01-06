class BarChartData {
  final int day;
  final double pending;
  final double inProgress;
  final double complete;

  BarChartData({
    required this.day,
    required this.pending,
    required this.inProgress,
    required this.complete,
  });

  factory BarChartData.fromJson(Map<String, dynamic> json) {
    return BarChartData(
      day: json[
          'day'], // Assume day corresponds to an integer (0=Mon, 1=Tue, etc.)
      pending: json['pending'].toDouble(),
      inProgress: json['in progress'].toDouble(),
      complete: json['complete'].toDouble(),
    );
  }
}
