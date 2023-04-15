import 'package:itflowapp/models/company.dart';
import 'package:test/test.dart';

void main() {
  test('Company.fromJson should return a valid Company object', () {
    final json = {
      "id": 1,
      "name": "Acme Inc.",
      "logo": "",
      "description": "A company that makes stuff",
      "slug": "acme-inc",
      "phone": "123-456-7890",
      "fax": "123-456-7891",
      "email": "info@acme.com",
      "url": "https://www.acme.com",
      "url_twitter": "https://twitter.com/acme",
      "url_facebook": "https://www.facebook.com/acme",
      "url_linkedin": "https://www.linkedin.com/company/acme"
    };

    final company = Company.fromJson(json);

    expect(company.id, 1);
    expect(company.name, "Acme Inc.");
    expect(company.logoUrl,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Anonymous.svg/1200px-Anonymous.svg.png");
    expect(company.description, "A company that makes stuff");
    expect(company.slug, "acme-inc");
    expect(company.phoneNumber, "123-456-7890");
    expect(company.fax, "123-456-7891");
    expect(company.email, "info@acme.com");
    expect(company.url, "https://www.acme.com");
    expect(company.urlTwitter, "https://twitter.com/acme");
    expect(company.urlFacebook, "https://www.facebook.com/acme");
    expect(company.urlLinkedin, "https://www.linkedin.com/company/acme");
  });
}
