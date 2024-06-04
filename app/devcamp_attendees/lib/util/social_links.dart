List<Link> socialLinks = [
  Link(
    linkType: 'twitter',
    url: "https://twitter.com/sumithpdd",
    text: "Twitter",
  ),
  Link(
    linkType: "linkedin",
    url: "https://linkedin.com/sumithpdd",
    text: "LinkedIn",
  ),
];

class Link {
  String linkType;
  String url;
  String text;

  Link({
    required this.linkType,
    required this.url,
    required this.text,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        linkType: json["linkType"],
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "linkType": linkType,
        "url": url,
        "text": text,
      };

  Link copyWith({
    String? linkType,
    String? url,
    String? text,
  }) {
    return Link(
      linkType: linkType ?? this.linkType,
      url: url ?? this.url,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'linkType': linkType,
      'url': url,
      'text': text,
    };
  }

  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      linkType: map['linkType'] as String,
      url: map['url'] as String,
      text: map['text'] as String,
    );
  }

  @override
  String toString() => 'Link(linkType: $linkType, url: $url, text: $text)';

  @override
  bool operator ==(covariant Link other) {
    if (identical(this, other)) return true;

    return other.linkType == linkType && other.url == url && other.text == text;
  }

  @override
  int get hashCode => linkType.hashCode ^ url.hashCode ^ text.hashCode;
}
