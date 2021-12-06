class DiaryData {
  String? savedDate;
  String? savedMemo;
  String? savedPath;

  DiaryData({this.savedDate, this.savedMemo, this.savedPath});

  Map<String, dynamic> toJson() {
    return {
      "savedDate": savedDate,
      "savedMemo": savedMemo,
      "savedPath": savedPath,
    };
  }

  DiaryData.fromJson(Map<String, dynamic> json) {
    savedDate = json["savedDate"];
    savedMemo = json["savedMemo"];
    savedPath = json["savedPath"];
  }
}
