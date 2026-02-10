import 'package:flutter/material.dart';

final List<Map<String, dynamic>> categories = [
  {'title': 'Plumber', 'icon': Icons.plumbing},
  {'title': 'Electrician', 'icon': Icons.electrical_services},
  {'title': 'Cleaner', 'icon': Icons.cleaning_services},
  {'title': 'Painter', 'icon': Icons.format_paint},
  {'title': 'Carpenter', 'icon': Icons.handyman},
  {'title': 'Electrician', 'icon': Icons.electrical_services},
  {'title': 'Cleaner', 'icon': Icons.cleaning_services},
];

final List<Map<String, dynamic>> serviceProviders = [
  {
    'name': 'Rustam Ergashev',
    'profession': 'Furniture Assembly Specialist',
    'distance': 2.3,
    'rating': 4.6,
    'reviewCount': 150,
    'duration': '30-45 min',
    'priceFrom': 50000,
    'isVerified': true,
    'isAvailable': true,
    'mainImageUrl':
        'https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=800',
    'image2Url':
        'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
    'image3Url':
        'https://images.unsplash.com/photo-1504148455328-c376907d081c?w=400',
    'description':
        'Professional furniture assembly specialist with 10+ years of experience.',
    'services': [
      {
        'name': 'Furniture Assembly',
        'description': 'Professional furniture assembly service',
        'price': '50,000 - 150,000 UZS',
      },
      {
        'name': 'Cabinet Installation',
        'description': 'Wall and floor cabinet installation',
        'price': '80,000 - 200,000 UZS',
      },
      {
        'name': 'Custom Woodworks',
        'description': 'Custom wooden furniture works',
        'price': '200,000 - 500,000 UZS',
      },
    ],
    'phoneNumber': '+998 (99) 123-45-67',
    'language': 'Uzbek, Russian, English',
    'location': 'Tashkent, Sergeli',
    'yearsExperience': 10,
    'completedJobs': 189,
  },
  {
    'name': 'Kamila Sharipova',
    'profession': 'Professional Cleaner',
    'distance': 1.5,
    'rating': 4.8,
    'reviewCount': 230,
    'duration': '20-30 min',
    'priceFrom': 80000,
    'isVerified': true,
    'isAvailable': false,
    'mainImageUrl':
        'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800',
    'image2Url':
        'https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?w=400',
    'image3Url':
        'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=400',
    'description':
        'Expert cleaning professional specializing in deep cleaning and home maintenance.',
    'services': [
      {
        'name': 'Deep Cleaning',
        'description': 'Complete home deep cleaning service',
        'price': '250,000 - 500,000 UZS',
      },
      {
        'name': 'Regular Cleaning',
        'description': 'Standard home cleaning service',
        'price': '120,000 - 200,000 UZS',
      },
      {
        'name': 'Window Cleaning',
        'description': 'Professional window cleaning',
        'price': '80,000 - 150,000 UZS',
      },
    ],
    'phoneNumber': '+998 (90) 234-56-78',
    'language': 'Uzbek, Russian',
    'location': 'Tashkent, Chilanzar',
    'yearsExperience': 7,
    'completedJobs': 230,
  },
  {
    'name': 'Davron Karimov',
    'profession': 'Licensed Electrician',
    'distance': 3.8,
    'rating': 4.7,
    'reviewCount': 175,
    'duration': '40-60 min',
    'priceFrom': 100000,
    'isVerified': true,
    'isAvailable': true,
    'mainImageUrl':
        'https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=800',
    'image2Url':
        'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=400',
    'image3Url':
        'https://images.unsplash.com/photo-1504148455328-c376907d081c?w=400',
    'description':
        'Certified electrician with expertise in residential and commercial electrical work.',
    'services': [
      {
        'name': 'Electrical Repair',
        'description': 'Fix all types of electrical issues',
        'price': '100,000 - 300,000 UZS',
      },
      {
        'name': 'Installation Services',
        'description': 'Install lighting, outlets, and switches',
        'price': '80,000 - 250,000 UZS',
      },
      {
        'name': 'Wiring & Rewiring',
        'description': 'Complete home wiring solutions',
        'price': '500,000 - 2,000,000 UZS',
      },
    ],
    'phoneNumber': '+998 (91) 345-67-89',
    'language': 'Uzbek, Russian, English',
    'location': 'Tashkent, Yunusabad',
    'yearsExperience': 12,
    'completedJobs': 175,
  },
  {
    'name': 'Alisher Nazarov',
    'profession': 'Expert Plumber',
    'distance': 2.7,
    'rating': 4.5,
    'reviewCount': 145,
    'duration': '35-50 min',
    'priceFrom': 70000,
    'isVerified': false,
    'isAvailable': true,
    'mainImageUrl':
        'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=800',
    'image2Url':
        'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
    'image3Url':
        'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=400',
    'description':
        'Experienced plumber specializing in residential plumbing repairs and installations.',
    'services': [
      {
        'name': 'Pipe Repair',
        'description': 'Fix leaks and broken pipes',
        'price': '70,000 - 200,000 UZS',
      },
      {
        'name': 'Drain Cleaning',
        'description': 'Unclog drains and sewers',
        'price': '50,000 - 150,000 UZS',
      },
      {
        'name': 'Fixture Installation',
        'description': 'Install sinks, toilets, and faucets',
        'price': '80,000 - 250,000 UZS',
      },
    ],
    'phoneNumber': '+998 (93) 456-78-90',
    'language': 'Uzbek, Russian',
    'location': 'Tashkent, Mirzo Ulugbek',
    'yearsExperience': 8,
    'completedJobs': 145,
  },
  {
    'name': 'Nilufar Abdullayeva',
    'profession': 'Interior Painter',
    'distance': 4.2,
    'rating': 4.9,
    'reviewCount': 198,
    'duration': '45-60 min',
    'priceFrom': 120000,
    'isVerified': true,
    'isAvailable': false,
    'mainImageUrl':
        'https://images.unsplash.com/photo-1562259949-e8e7689d7828?w=800',
    'image2Url':
        'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=400',
    'image3Url':
        'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=400',
    'description':
        'Professional painter with artistic touch and attention to detail.',
    'services': [
      {
        'name': 'Interior Painting',
        'description': 'Paint walls, ceilings, and trim',
        'price': '120,000 - 400,000 UZS',
      },
      {
        'name': 'Exterior Painting',
        'description': 'Paint building exteriors',
        'price': '200,000 - 800,000 UZS',
      },
      {
        'name': 'Decorative Painting',
        'description': 'Special finishes and designs',
        'price': '150,000 - 500,000 UZS',
      },
    ],
    'phoneNumber': '+998 (94) 567-89-01',
    'language': 'Uzbek, Russian, English',
    'location': 'Tashkent, Yakkasaray',
    'yearsExperience': 6,
    'completedJobs': 198,
  },
];
