class Task {
  String id;
  String title;
  bool isDone;

  Task({required this.id, required this.title, required this.isDone});

  // Optional: Add toJson and fromJson methods for easier serialization/deserialization
  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'title': title,
  //       'isDone': isDone,
  //     };

//   factory Task.fromJson(Map<String, dynamic> json) {
//     return Task(
//       id: json['id'],
//       title: json['title'],
//       isDone: json['isDone'],
//     );
//   }
}
