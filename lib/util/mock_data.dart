import '../model/beneficiary.dart';
import '../model/currency_model.dart';
import '../model/need.dart';

class MockData {
  static List<Need> needs = <Need>[
    Need(
      id: 1,
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
      areasOfInterest: <AreaOfInterest>[AreaOfInterest.food],
      images: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      status: NeedStatus.draft,
    ),
    Need(
      id: 2,
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
      areasOfInterest: <AreaOfInterest>[AreaOfInterest.food],
      images: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      status: NeedStatus.ongoing,
    ),
    Need(
      id: 3,
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
      areasOfInterest: <AreaOfInterest>[AreaOfInterest.food],
      images: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      status: NeedStatus.past,
    ),
    Need(
      id: 4,
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
      areasOfInterest: <AreaOfInterest>[AreaOfInterest.electricity],
      images: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      status: NeedStatus.ongoing,
    ),
    Need(
      id: 5,
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
      areasOfInterest: <AreaOfInterest>[AreaOfInterest.electricity],
      images: <String>[
        'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
      ],
      status: NeedStatus.ongoing,
    ),
  ];

  static List<CurrencyModel> currency = <CurrencyModel>[
    CurrencyModel(
      imageUrl: 'assets/images/switzerland.png',
      name: 'Swiss Frank',
      code: 'CHF',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/australia.png',
      name: 'Australian Dollar',
      code: 'AUD',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/great_britain.png',
      name: 'British Pound',
      code: 'GBP',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/canada.png',
      name: 'Canadian Dollar',
      code: 'CAD',
    ),
  ];
}
