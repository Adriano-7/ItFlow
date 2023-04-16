import 'package:itflowapp/models/job.dart';
import 'package:test/test.dart';

void main() {
  test('Job.fromJson should correctly parse json', () {
    final json = {
      'id': 1,
      'company': {
        'id': 1,
        'name': 'Acme Inc.',
        'location': {
          'id': '1',
          'name': 'San Francisco',
        },
        'slug': 'acme-inc',
      },
      'companyId': 1,
      'title': 'Software Engineer',
      'body': 'We are looking for a software engineer to join our team...',
      'ref': 'ABC123',
      'wage': 100000,
      'types': [
        {
          'id': '1',
          'name': 'Full-time',
        },
        {
          'id': '2',
          'name': 'Remote',
        },
      ],
      'contracts': [
        {
          'id': '1',
          'name': 'Permanent',
        },
        {
          'id': '2',
          'name': 'Contract',
        },
      ],
      'locations': [
        {
          'id': '1',
          'name': 'San Francisco',
        },
        {
          'id': '2',
          'name': 'New York',
        },
      ],
      'allowRemote': true,
      'publishedAt': '2023-04-15T10:30:00.000Z',
      'updatedAt': '2023-04-15T11:30:00.000Z',
      'slug': 'software-engineer',
    };

    final job = Job.fromJson(json);

    expect(job.id, 1);
    expect(job.company?.id, 1);
    expect(job.company?.name, 'Acme Inc.');
    expect(job.locations?[0].id, '1');
    expect(job.locations?[0].name, 'San Francisco');
    expect(job.companyId, 1);
    expect(job.title, 'Software Engineer');
    expect(
        job.body, 'We are looking for a software engineer to join our team...');
    expect(job.ref, 'ABC123');
    expect(job.wage, 100000);
    expect(job.types?.length, 2);
    expect(job.types?[0].id, '1');
    expect(job.types?[0].name, 'Full-time');
    expect(job.types?[1].id, '2');
    expect(job.types?[1].name, 'Remote');
    expect(job.contracts?.length, 2);
    expect(job.contracts?[0].id, '1');
    expect(job.contracts?[0].name, 'Permanent');
    expect(job.contracts?[1].id, '2');
    expect(job.contracts?[1].name, 'Contract');
    expect(job.locations?.length, 2);
    expect(job.locations?[0].id, '1');
    expect(job.locations?[0].name, 'San Francisco');
    expect(job.locations?[1].id, '2');
    expect(job.locations?[1].name, 'New York');
    expect(job.allowsRemote, true);
    expect(job.publishedAt?.toString(), '2023-04-15 10:30:00.000Z');
    expect(job.updatedAt?.toString(), '2023-04-15 11:30:00.000Z');
    expect(job.slug, 'software-engineer');
  });
}
