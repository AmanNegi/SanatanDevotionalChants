import 'dart:convert';

class LyricsItem {
  final String id;
  final String lyrics;

  LyricsItem({
    required this.id,
    required this.lyrics,
  });

  LyricsItem copyWith({
    String? id,
    String? lyrics,
  }) {
    return LyricsItem(
      id: id ?? this.id,
      lyrics: lyrics ?? this.lyrics,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lyrics': lyrics,
    };
  }

  factory LyricsItem.fromMap(Map<String, dynamic> map) {
    return LyricsItem(
      id: map['id'] as String,
      lyrics: map['lyrics'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LyricsItem.fromJson(String source) =>
      LyricsItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LyricsItem(id: $id, lyrics: $lyrics)';

  @override
  bool operator ==(covariant LyricsItem other) {
    if (identical(this, other)) return true;

    return other.id == id && other.lyrics == lyrics;
  }

  @override
  int get hashCode => id.hashCode ^ lyrics.hashCode;
}
