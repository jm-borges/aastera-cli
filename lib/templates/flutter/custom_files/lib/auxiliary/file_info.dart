class FileInfo {
  String? originalUrl;
  String? fileName;

  FileInfo({this.originalUrl, this.fileName});

  factory FileInfo.fromJson(Map<String, dynamic> json) {
    return FileInfo(
      originalUrl: json['original_file'],
      fileName: json['file_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
