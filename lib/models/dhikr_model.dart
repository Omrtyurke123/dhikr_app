enum CategoryType {
  morning,
  evening,
  night,
  prayer,
  sleep,
  misc,
  istighfar,
  tasbeeh,
  salawat,
}

class DhikrModel {
  final String id;
  final String arabic;
  final String transliteration;
  final String meaning;
  final int count;
  final String? source;
  final CategoryType category;

  const DhikrModel({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.meaning,
    required this.count,
    this.source,
    required this.category,
  });
}

class DhikrCategory {
  final String id;
  final String name;
  final String icon;
  final CategoryType type;
  final List<DhikrModel> adhkar;

  const DhikrCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.adhkar,
  });
}
