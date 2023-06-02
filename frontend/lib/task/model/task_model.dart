class Task {
  final String title;
  final String detail;
  final bool status;
  final String id;
  final String due_date;
  final String date_created;
  final String farmname;
  final String assgined_to;

  Task({
    required this.title,
    required this.detail,
    required this.status,
    required this.id,
    required this.due_date,
    required this.date_created,
    required this.farmname,
    required this.assgined_to,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      detail: json['detail'],
      status: json['status'],
      id: json['_id'],
      due_date: json['due_date'],
      date_created: json['date_created'],
      farmname: json['farmname'],
      assgined_to: json['assgined_to'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'detail': detail,
      'status': status ? 1 : 0,
      "taskid": id,
      "due_date": due_date,
      "date_created": date_created,
      "farmname": farmname,
      "assgined_to": assgined_to,
    };
  }
}
