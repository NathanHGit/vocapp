class Voc {
  late final int id;
  late final String lemma;
  late final String inflections;
  late final String translation;
  late final DateTime date;
  late final String pos;
  late int weight;

  Voc(
      {required this.id,
      required this.lemma,
      required this.inflections,
      required this.translation,
      required this.date,
      required this.pos,
      required this.weight});

  Voc.fromMap(Map map) {
    id = map['id'];
    lemma = map['lemma'];
    inflections = map['inflections'];
    translation = map['translation'];
    date = map['date'] == null ? new DateTime.now() : map['date'];
    pos = map['name'];
    weight = map['weight'] == null ? 0 : map['weight'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lemma': lemma,
      'inflections': inflections,
      'translation': translation,
      'date': date,
      'pos': pos,
      'weight': weight,
    };
  }

  String getPos() {
    return pos.substring(0, 1).toUpperCase() + '.';
  }
}
