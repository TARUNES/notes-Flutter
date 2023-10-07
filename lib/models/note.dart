class Note {
  int id;
  String title;
  String content;
  DateTime modifiedtime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedtime,
  });
}

List<Note> samplenotes = [
  Note(
      id: 0,
      title: "Like and Subscribe",
      content: 'a free way to learn smthg',
      modifiedtime: DateTime(2023, 1, 1, 34, 5)),
  Note(
      id: 1,
      title: "Broo Mass uh Vro",
      content: 'a free way to learn smthg',
      modifiedtime: DateTime(2023, 1, 1, 34, 5)),
  Note(
      id: 2,
      title: "Cheri da Ebba",
      content: 'a free way to learn smthg',
      modifiedtime: DateTime(2023, 1, 1, 34, 5)),
  Note(
      id: 3,
      title: "Enna Thala",
      content: 'a free way to learn smthg',
      modifiedtime: DateTime(2023, 1, 1, 34, 5)),
  Note(
      id: 4,
      title: "Soup Vachiduven",
      content: 'a free way to learn smthg',
      modifiedtime: DateTime(2023, 1, 1, 34, 5)),
];
