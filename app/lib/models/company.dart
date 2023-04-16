class Company {
  static const _annonnymousImg =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Anonymous.svg/1200px-Anonymous.svg.png';

  final int id;
  final String name;
  final String logoUrl;
  final String description;
  final String slug;
  final String? phoneNumber;
  final String? fax;
  final String? email;
  final String? url;
  final String? urlTwitter;
  final String? urlFacebook;
  final String? urlLinkedin;

  const Company(
    this.id,
    this.name,
    this.logoUrl,
    this.description,
    this.slug,
    this.phoneNumber,
    this.fax,
    this.email,
    this.url,
    this.urlTwitter,
    this.urlFacebook,
    this.urlLinkedin,
  );

  factory Company.fromJson(Map<String, dynamic> jsonMap) {
    return Company(
      jsonMap['id'],
      jsonMap['name'],
      jsonMap['id'] == 1 ? _annonnymousImg : jsonMap['logo'],
      jsonMap['description'] ??= '',
      jsonMap['slug'],
      jsonMap.containsKey('phone') ? jsonMap['phone']?.toString() : null,
      jsonMap.containsKey('fax') ? jsonMap['fax']?.toString() : null,
      jsonMap.containsKey('email') ? jsonMap['email'] : null,
      jsonMap.containsKey('url') ? jsonMap['url'] : null,
      jsonMap.containsKey('url_twitter') ? jsonMap['url_twitter'] : null,
      jsonMap.containsKey('url_facebook') ? jsonMap['url_facebook'] : null,
      jsonMap.containsKey('url_linkedin') ? jsonMap['url_linkedin'] : null,
    );
  }

  static List<Company> fromJsonList(List<dynamic> list) {
    List<Company> companies = List<Company>.empty(growable: true);
    for (var e in list) {
      Map<String, dynamic> jsonMap = e as Map<String, dynamic>;
      companies.add(Company.fromJson(jsonMap));
    }
    return companies;
  }
}
