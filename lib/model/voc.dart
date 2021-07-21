class Voc {
  late final int id;
  late final String lemma;
  late final String inflections;
  late final String translation;
  late final DateTime date;
  late final String pos;

  Voc(
      {required this.id,
      required this.lemma,
      required this.inflections,
      required this.translation,
      required this.date,
      required this.pos});

  /*Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lemma': lemma,
      'inflections': inflections,
      'translation': translation,
      'date': date,
      'pos': pos,
      'status': status,
    };
  }

  Voc.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    lemma = map['lemma'];
    inflections = map['inflections'];
    translation = map['translation'];
    date = map['date'];
    pos = map['pos'];
    status = map['status)'];
  }*/

  Voc.fromMap(Map map) {
    id = map['id'];
    lemma = map['lemma'];
    inflections = map['inflections'];
    translation = map['translation'];
    date = map['date'] == null ? new DateTime.now() : map['date'];
    pos = map['name'];
  }

  String getPos() {
    return pos.substring(0, 1).toUpperCase() + '.';
  }
}
