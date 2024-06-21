import '../model/beneficiary.dart';
import '../model/need.dart';

class MockData {
  static List<Need> needs = <Need>[
    Need(
      title: 'Nutritious food for my three young children',
      description:
          "Hello, I'm a single mother in Nairobi, doing my best to provide nourishing meals for my three young children.",
      beneficiary: Beneficiary(
        name: 'Fatima Ahmed',
        location: 'Nairobi, Kenya',
        email: 'fatime_ahmed@gmail.com',
        photoUrl:
            'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/a8b67f4955123ecb6aeb3b65644a92dc8a9750ca',
        dateOfBirth: DateTime(1985, 5, 12),
        gender: Gender.female,
        bio:
            "I'm Fatima, a dedicated single mother from Nairobi, Kenya. Striving to provide my three young children with nutritious meals and a loving home, I embrace resilience and determination. Your support can make a lasting impact, helping us build a brighter future together.",
      ),
      amount: 5,
      fields: <NeedField>[NeedField.food],
      photoUrls: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      fulfilled: false,
    ),
    Need(
      title: 'Funding for house construction',
      description:
          "As a father, my dream is to provide a secure home for my family. I'm reaching out for financial support to build a modest house.",
      beneficiary: Beneficiary(
        photoUrl:
            'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/3d501811ca6d8baae4bf4d6308b4edb04e9c6d92',
        name: 'Rajesh Patel',
        location: 'Mumbai, India',
        email: 'rajesh@abcde.com',
        dateOfBirth: DateTime(1978, 8, 23),
        gender: Gender.male,
        bio: '...',
      ),
      amount: 10,
      fields: <NeedField>[NeedField.electricity],
      photoUrls: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      fulfilled: false,
    ),
    Need(
      title: 'Test Data Title',
      description: 'Test Data Title Description',
      beneficiary: Beneficiary(
        photoUrl:
            'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/3d501811ca6d8baae4bf4d6308b4edb04e9c6d92',
        name: 'Test Data Name',
        location: 'Sydney, Australia',
        email: '123@abcde.com',
        dateOfBirth: DateTime(1977, 8, 23),
        gender: Gender.male,
        bio: 'Test Data Bio',
      ),
      amount: 12,
      fields: <NeedField>[NeedField.bread],
      photoUrls: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      fulfilled: true,
    ),
  ];
}
