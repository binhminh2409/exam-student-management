class Subject {
  String name;
  List<int> scores;

  Subject(this.name, this.scores);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'scores': scores,
    };
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      json['name'],
      List<int>.from(json['scores'])
    );
  }
}
