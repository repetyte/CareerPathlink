class CV {
  final int id;
  final String studentNo;
  final String fileName;
  final String uploadPath;
  final DateTime uploadedAt;

  CV({
    required this.id,
    required this.studentNo,
    required this.fileName,
    required this.uploadPath,
    required this.uploadedAt,
  });

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      id: json['id'],
      studentNo: json['student_no'],
      fileName: json['file_name'],
      uploadPath: json['upload_path'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }
}
