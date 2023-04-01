import 'dart:convert';

class MusicItem {
  final String id;
  final String title;
  final String singer;
  final String image;
  final String source;
  late String audioUrl;

  MusicItem({
    required this.id,
    required this.title,
    required this.singer,
    required this.image,
    required this.source,
    this.audioUrl = "",
  });

  MusicItem copyWith({
    String? id,
    String? title,
    String? singer,
    String? image,
    String? source,
    String? audioUrl,
  }) {
    return MusicItem(
      id: id ?? this.id,
      title: title ?? this.title,
      singer: singer ?? this.singer,
      image: image ?? this.image,
      source: source ?? this.source,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'singer': singer,
      'image': image,
      'source': source,
      'audioUrl': audioUrl,
    };
  }

  factory MusicItem.fromMap(Map<String, dynamic> map) {
    return MusicItem(
      id: map['id'] as String,
      title: map['title'] as String,
      singer: map['singer'] as String,
      image: map['image'] as String,
      source: map['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicItem.fromJson(String source) =>
      MusicItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MusicItem(id: $id, title: $title, singer: $singer, image: $image, source: $source)';
  }

  @override
  bool operator ==(covariant MusicItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.singer == singer &&
        other.image == image &&
        other.source == source &&
        other.audioUrl == audioUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        singer.hashCode ^
        image.hashCode ^
        source.hashCode ^
        audioUrl.hashCode;
  }
}
