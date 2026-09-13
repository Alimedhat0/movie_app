// class CreditsModel {
//   final int id;
//   final List<Cast> cast;
//   final List<Crew> crew;

//   CreditsModel({required this.id, required this.cast, required this.crew});

//   factory CreditsModel.fromJson(Map<String, dynamic> json) {
//     return CreditsModel(
//       id: json['id'],
//       cast: (json['cast'] as List).map((e) => Cast.fromJson(e)).toList(),
//       crew: (json['crew'] as List).map((e) => Crew.fromJson(e)).toList(),
//     );
//   }
// }

// class Cast {
//   final int id;
//   final String name;
//   final String character;

//   Cast({required this.id, required this.name, required this.character});

//   factory Cast.fromJson(Map<String, dynamic> json) {
//     return Cast(
//       id: json['id'],
//       name: json['name'],
//       character: json['character'] ?? '',
//     );
//   }
// }

// class Crew {
//   final int id;
//   final String name;
//   final String job;

//   Crew({required this.id, required this.name, required this.job});

//   factory Crew.fromJson(Map<String, dynamic> json) {
//     return Crew(id: json['id'], name: json['name'], job: json['job'] ?? '');
//   }
// }

class MovieCreditsModel {
  final int id;
  final List<Cast> cast;
  final List<Crew> crew;

  MovieCreditsModel({required this.id, required this.cast, required this.crew});

  factory MovieCreditsModel.fromJson(Map<String, dynamic> json) {
    return MovieCreditsModel(
      id: json['id'],
      cast: (json['cast'] as List).map((e) => Cast.fromJson(e)).toList(),
      crew: (json['crew'] as List).map((e) => Crew.fromJson(e)).toList(),
    );
  }
}

class Cast {
  final int id;
  final String name;
  final String character;
  final String? profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      name: json['name'],
      character: json['character'] ?? "",
      profilePath: json['profile_path'] ?? "",
    );
  }
}

class Crew {
  final int id;
  final String name;
  final String job;
  final String? profilePath;

  Crew({
    required this.id,
    required this.name,
    required this.job,
    this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json['id'],
      name: json['name'],
      job: json['job'] ?? "",
      profilePath: json['profile_path'] ?? "",
    );
  }
}
