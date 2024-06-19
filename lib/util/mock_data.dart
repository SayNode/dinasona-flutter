import '../model/need.dart';

class MockData {
  static List<Need> needs = <Need>[
    Need(
      title: 'Nutritious food for my three young children',
      description:
          "Hello, I'm a single mother in Nairobi, doing my best to provide nourishing meals for my three young children.",
      beneficiaryPhotoUrl:
          'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/a8b67f4955123ecb6aeb3b65644a92dc8a9750ca',
      beneficiaryName: 'Fatima Ahmed',
      beneficiaryLocation: 'Nairobi, Kenya',
      amount: 5,
      fields: <NeedField>[NeedField.food],
      photoUrls: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
    ),
    Need(
      title: 'Funding for house construction',
      description:
          "As a father, my dream is to provide a secure home for my family. I'm reaching out for financial support to build a modest house.",
      beneficiaryPhotoUrl:
          'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/3d501811ca6d8baae4bf4d6308b4edb04e9c6d92',
      beneficiaryName: 'Rajesh Patel',
      beneficiaryLocation: 'Mumbai, India',
      amount: 10,
      fields: <NeedField>[NeedField.electricity],
      photoUrls: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
    ),
  ];
}
