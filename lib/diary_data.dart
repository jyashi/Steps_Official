class DiaryData {
  String? savedDate;
  String? savedMemo;

  DiaryData({this.savedDate, this.savedMemo});

  Map<String, dynamic> toJson() {
    return {
      "savedDate": savedDate,
      "savedMemo": savedMemo,
    };
  }

  DiaryData.fromJson(Map<String, dynamic> json) {
    savedDate = json["savedDate"];
    savedMemo = json["savedMemo"];
  }
}
