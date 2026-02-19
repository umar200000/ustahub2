import 'package:ustahub/application2/banner_bloc_and_data/data/model/banner_model.dart';
import 'package:ustahub/application2/category_bloc_and_data/data/model/category_model.dart';
import 'package:ustahub/application2/company_bloc_and_data/data/model/company_model.dart';
import 'package:ustahub/application2/details_service/data/model/details_model.dart';
import 'package:ustahub/application2/service_bloc_and_data/data/model/service_model.dart';

class MockData {
  MockData._();

  static final Map<String, dynamic> bannersJson = {
    "success": true,
    "message": "Mock data",
    "data": [
      {
        "id": "mock-banner-1",
        "title": "Professional xizmatlar",
        "subtitle": "Eng yaxshi ustalar sizning xizmatingizda",
        "image_url": "https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800"
      },
      {
        "id": "mock-banner-2",
        "title": "Tez va sifatli",
        "subtitle": "24/7 xizmat ko'rsatish",
        "image_url": "https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=800"
      },
      {
        "id": "mock-banner-3",
        "title": "Kafolatlangan sifat",
        "subtitle": "Ishonchli va professional yondashuv",
        "image_url": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800"
      }
    ]
  };

  static final Map<String, dynamic> categoriesJson = {
    "success": true,
    "message": "Mock data",
    "data": [
      {
        "id": "mock-cat-1",
        "name_uz": "Elektrik",
        "name_ru": "Электрик",
        "name_en": "Electrician",
        "icon_url": "https://cdn-icons-png.flaticon.com/512/2933/2933245.png",
        "parent_id": null
      },
      {
        "id": "mock-cat-2",
        "name_uz": "Santexnik",
        "name_ru": "Сантехник",
        "name_en": "Plumber",
        "icon_url": "https://cdn-icons-png.flaticon.com/512/4635/4635163.png",
        "parent_id": null
      },
      {
        "id": "mock-cat-3",
        "name_uz": "Tozalash",
        "name_ru": "Уборка",
        "name_en": "Cleaning",
        "icon_url": "https://cdn-icons-png.flaticon.com/512/2954/2954918.png",
        "parent_id": null
      },
      {
        "id": "mock-cat-4",
        "name_uz": "Ta'mirlash",
        "name_ru": "Ремонт",
        "name_en": "Repair",
        "icon_url": "https://cdn-icons-png.flaticon.com/512/2219/2219822.png",
        "parent_id": null
      },
      {
        "id": "mock-cat-5",
        "name_uz": "Bo'yoqchi",
        "name_ru": "Маляр",
        "name_en": "Painter",
        "icon_url": "https://cdn-icons-png.flaticon.com/512/1048/1048944.png",
        "parent_id": null
      },
      {
        "id": "mock-cat-6",
        "name_uz": "Konditsioner",
        "name_ru": "Кондиционер",
        "name_en": "AC Service",
        "icon_url": "https://cdn-icons-png.flaticon.com/512/3274/3274199.png",
        "parent_id": null
      }
    ]
  };

  static final Map<String, dynamic> companiesJson = {
    "success": true,
    "message": "Mock data",
    "data": {
      "items": [
        {
          "id": "mock-company-1",
          "name": "ProFix",
          "logo_url": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
          "description": "Professional ta'mirlash xizmatlari",
          "rating": 4.8
        },
        {
          "id": "mock-company-2",
          "name": "CleanMaster",
          "logo_url": "https://cdn-icons-png.flaticon.com/512/3135/3135789.png",
          "description": "Tozalash xizmatlari",
          "rating": 4.6
        },
        {
          "id": "mock-company-3",
          "name": "ElektroPro",
          "logo_url": "https://cdn-icons-png.flaticon.com/512/3135/3135768.png",
          "description": "Elektrik ishlari",
          "rating": 4.9
        },
        {
          "id": "mock-company-4",
          "name": "AquaService",
          "logo_url": "https://cdn-icons-png.flaticon.com/512/3135/3135823.png",
          "description": "Santexnika xizmatlari",
          "rating": 4.7
        },
        {
          "id": "mock-company-5",
          "name": "CoolAir",
          "logo_url": "https://cdn-icons-png.flaticon.com/512/3135/3135745.png",
          "description": "Konditsioner servisi",
          "rating": 4.5
        }
      ],
      "total": 5,
      "skip": 0,
      "limit": 20,
      "has_more": false
    }
  };

  static final Map<String, dynamic> servicesJson = {
    "success": true,
    "message": "Mock data",
    "data": [
      {
        "id": "mock-service-1",
        "provider_id": "mock-company-1",
        "title_uz": "Uy ta'mirlash",
        "title_ru": "Ремонт дома",
        "title_en": "Home Repair",
        "description_uz": "Professional uy ta'mirlash xizmatlari",
        "base_price": "150000",
        "max_price": "500000",
        "status": "active",
        "primary_image_url": "https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400",
        "category_name_uz": "Ta'mirlash",
        "currency_code": "UZS",
        "currency_symbol": "so'm"
      },
      {
        "id": "mock-service-2",
        "provider_id": "mock-company-2",
        "title_uz": "Uy tozalash",
        "title_ru": "Уборка дома",
        "title_en": "House Cleaning",
        "description_uz": "Chuqur tozalash xizmatlari",
        "base_price": "100000",
        "max_price": "300000",
        "status": "active",
        "primary_image_url": "https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400",
        "category_name_uz": "Tozalash",
        "currency_code": "UZS",
        "currency_symbol": "so'm"
      },
      {
        "id": "mock-service-3",
        "provider_id": "mock-company-3",
        "title_uz": "Elektrik ishlari",
        "title_ru": "Электромонтаж",
        "title_en": "Electrical Work",
        "description_uz": "Simlar o'rnatish va ta'mirlash",
        "base_price": "80000",
        "max_price": "400000",
        "status": "active",
        "primary_image_url": "https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400",
        "category_name_uz": "Elektrik",
        "currency_code": "UZS",
        "currency_symbol": "so'm"
      },
      {
        "id": "mock-service-4",
        "provider_id": "mock-company-4",
        "title_uz": "Santexnika ta'miri",
        "title_ru": "Ремонт сантехники",
        "title_en": "Plumbing Repair",
        "description_uz": "Kran, quvur va boshqa santexnika ta'miri",
        "base_price": "70000",
        "max_price": "350000",
        "status": "active",
        "primary_image_url": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400",
        "category_name_uz": "Santexnik",
        "currency_code": "UZS",
        "currency_symbol": "so'm"
      },
      {
        "id": "mock-service-5",
        "provider_id": "mock-company-5",
        "title_uz": "Konditsioner o'rnatish",
        "title_ru": "Установка кондиционера",
        "title_en": "AC Installation",
        "description_uz": "Konditsioner o'rnatish va texnik xizmat",
        "base_price": "200000",
        "max_price": "600000",
        "status": "active",
        "primary_image_url": "https://images.unsplash.com/photo-1631545806609-3c99be5be99a?w=400",
        "category_name_uz": "Konditsioner",
        "currency_code": "UZS",
        "currency_symbol": "so'm"
      },
      {
        "id": "mock-service-6",
        "provider_id": "mock-company-1",
        "title_uz": "Devor bo'yash",
        "title_ru": "Покраска стен",
        "title_en": "Wall Painting",
        "description_uz": "Professional bo'yash xizmatlari",
        "base_price": "120000",
        "max_price": "450000",
        "status": "active",
        "primary_image_url": "https://images.unsplash.com/photo-1562259949-e8e7689d7828?w=400",
        "category_name_uz": "Bo'yoqchi",
        "currency_code": "UZS",
        "currency_symbol": "so'm"
      }
    ]
  };

  // Service details mock data
  static final Map<String, Map<String, dynamic>> serviceDetailsJson = {
    "mock-service-1": {
      "success": true,
      "message": "Mock data",
      "data": {
        "id": "mock-service-1",
        "provider_id": "mock-company-1",
        "category_id": "mock-cat-4",
        "title_uz": "Uy ta'mirlash",
        "title_ru": "Ремонт дома",
        "title_en": "Home Repair",
        "description_uz":
            "Professional uy ta'mirlash xizmatlari. Bizning tajribali ustalarimiz sizning uyingizni yangilaydi va barcha ta'mirlash ishlarini sifatli bajaradi. Devorlarni ta'mirlash, pol yotqizish, shift ishlari va boshqa ko'plab xizmatlar.",
        "description_ru":
            "Профессиональные услуги по ремонту дома. Наши опытные мастера обновят ваш дом и качественно выполнят все ремонтные работы.",
        "description_en":
            "Professional home repair services. Our experienced craftsmen will renovate your home and perform all repair work with quality.",
        "base_price": "150000",
        "max_price": "500000",
        "status": "active",
        "average_rating": 4.8,
        "total_bookings": 156,
        "total_reviews": 89,
        "currency_code": "UZS",
        "currency_symbol": "so'm",
        "category": {
          "id": "mock-cat-4",
          "name_uz": "Ta'mirlash",
          "name_ru": "Ремонт",
          "name_en": "Repair",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2219/2219822.png",
          "parent_id": null
        },
        "images": [
          {
            "id": "img-1",
            "image_url":
                "https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800",
            "is_primary": true
          },
          {
            "id": "img-2",
            "image_url":
                "https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=800",
            "is_primary": false
          },
          {
            "id": "img-3",
            "image_url":
                "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?w=800",
            "is_primary": false
          }
        ],
        "provider": {
          "id": "mock-company-1",
          "name": "ProFix",
          "logo_url":
              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
          "is_verified": true
        }
      }
    },
    "mock-service-2": {
      "success": true,
      "message": "Mock data",
      "data": {
        "id": "mock-service-2",
        "provider_id": "mock-company-2",
        "category_id": "mock-cat-3",
        "title_uz": "Uy tozalash",
        "title_ru": "Уборка дома",
        "title_en": "House Cleaning",
        "description_uz":
            "Chuqur tozalash xizmatlari. Uyingizni professional tarzda tozalaymiz. Barcha xonalar, mebel, oyna va boshqa yuzalarni tozalash kiradi.",
        "description_ru":
            "Услуги глубокой уборки. Профессионально очистим ваш дом. Включает уборку всех комнат, мебели, окон и других поверхностей.",
        "description_en":
            "Deep cleaning services. We will professionally clean your home. Includes cleaning of all rooms, furniture, windows and other surfaces.",
        "base_price": "100000",
        "max_price": "300000",
        "status": "active",
        "average_rating": 4.6,
        "total_bookings": 234,
        "total_reviews": 167,
        "currency_code": "UZS",
        "currency_symbol": "so'm",
        "category": {
          "id": "mock-cat-3",
          "name_uz": "Tozalash",
          "name_ru": "Уборка",
          "name_en": "Cleaning",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2954/2954918.png",
          "parent_id": null
        },
        "images": [
          {
            "id": "img-1",
            "image_url":
                "https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800",
            "is_primary": true
          },
          {
            "id": "img-2",
            "image_url":
                "https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?w=800",
            "is_primary": false
          }
        ],
        "provider": {
          "id": "mock-company-2",
          "name": "CleanMaster",
          "logo_url":
              "https://cdn-icons-png.flaticon.com/512/3135/3135789.png",
          "is_verified": true
        }
      }
    },
    "mock-service-3": {
      "success": true,
      "message": "Mock data",
      "data": {
        "id": "mock-service-3",
        "provider_id": "mock-company-3",
        "category_id": "mock-cat-1",
        "title_uz": "Elektrik ishlari",
        "title_ru": "Электромонтаж",
        "title_en": "Electrical Work",
        "description_uz":
            "Simlar o'rnatish va ta'mirlash. Rozetkalar, lyustralar, elektr panellarini o'rnatish va ta'mirlash. Xavfsiz va sifatli elektrik ishlari.",
        "description_ru":
            "Установка и ремонт проводки. Установка и ремонт розеток, люстр, электрощитов. Безопасные и качественные электромонтажные работы.",
        "description_en":
            "Wiring installation and repair. Installation and repair of sockets, chandeliers, electrical panels. Safe and quality electrical work.",
        "base_price": "80000",
        "max_price": "400000",
        "status": "active",
        "average_rating": 4.9,
        "total_bookings": 312,
        "total_reviews": 245,
        "currency_code": "UZS",
        "currency_symbol": "so'm",
        "category": {
          "id": "mock-cat-1",
          "name_uz": "Elektrik",
          "name_ru": "Электрик",
          "name_en": "Electrician",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2933/2933245.png",
          "parent_id": null
        },
        "images": [
          {
            "id": "img-1",
            "image_url":
                "https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=800",
            "is_primary": true
          },
          {
            "id": "img-2",
            "image_url":
                "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800",
            "is_primary": false
          }
        ],
        "provider": {
          "id": "mock-company-3",
          "name": "ElektroPro",
          "logo_url":
              "https://cdn-icons-png.flaticon.com/512/3135/3135768.png",
          "is_verified": true
        }
      }
    },
    "mock-service-4": {
      "success": true,
      "message": "Mock data",
      "data": {
        "id": "mock-service-4",
        "provider_id": "mock-company-4",
        "category_id": "mock-cat-2",
        "title_uz": "Santexnika ta'miri",
        "title_ru": "Ремонт сантехники",
        "title_en": "Plumbing Repair",
        "description_uz":
            "Kran, quvur va boshqa santexnika ta'miri. Suv quvurlarini o'rnatish, kranlarni ta'mirlash, unitaz va vannalarni o'rnatish.",
        "description_ru":
            "Ремонт кранов, труб и другой сантехники. Установка водопроводных труб, ремонт кранов, установка унитазов и ванн.",
        "description_en":
            "Repair of faucets, pipes and other plumbing. Installation of water pipes, faucet repair, installation of toilets and bathtubs.",
        "base_price": "70000",
        "max_price": "350000",
        "status": "active",
        "average_rating": 4.7,
        "total_bookings": 189,
        "total_reviews": 134,
        "currency_code": "UZS",
        "currency_symbol": "so'm",
        "category": {
          "id": "mock-cat-2",
          "name_uz": "Santexnik",
          "name_ru": "Сантехник",
          "name_en": "Plumber",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/4635/4635163.png",
          "parent_id": null
        },
        "images": [
          {
            "id": "img-1",
            "image_url":
                "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800",
            "is_primary": true
          }
        ],
        "provider": {
          "id": "mock-company-4",
          "name": "AquaService",
          "logo_url":
              "https://cdn-icons-png.flaticon.com/512/3135/3135823.png",
          "is_verified": true
        }
      }
    },
    "mock-service-5": {
      "success": true,
      "message": "Mock data",
      "data": {
        "id": "mock-service-5",
        "provider_id": "mock-company-5",
        "category_id": "mock-cat-6",
        "title_uz": "Konditsioner o'rnatish",
        "title_ru": "Установка кондиционера",
        "title_en": "AC Installation",
        "description_uz":
            "Konditsioner o'rnatish va texnik xizmat. Barcha turdagi konditsionerlarni o'rnatish, tozalash va ta'mirlash xizmatlari.",
        "description_ru":
            "Установка и обслуживание кондиционеров. Услуги по установке, чистке и ремонту всех типов кондиционеров.",
        "description_en":
            "Air conditioner installation and maintenance. Services for installation, cleaning and repair of all types of air conditioners.",
        "base_price": "200000",
        "max_price": "600000",
        "status": "active",
        "average_rating": 4.5,
        "total_bookings": 98,
        "total_reviews": 67,
        "currency_code": "UZS",
        "currency_symbol": "so'm",
        "category": {
          "id": "mock-cat-6",
          "name_uz": "Konditsioner",
          "name_ru": "Кондиционер",
          "name_en": "AC Service",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/3274/3274199.png",
          "parent_id": null
        },
        "images": [
          {
            "id": "img-1",
            "image_url":
                "https://images.unsplash.com/photo-1631545806609-3c99be5be99a?w=800",
            "is_primary": true
          }
        ],
        "provider": {
          "id": "mock-company-5",
          "name": "CoolAir",
          "logo_url":
              "https://cdn-icons-png.flaticon.com/512/3135/3135745.png",
          "is_verified": false
        }
      }
    },
    "mock-service-6": {
      "success": true,
      "message": "Mock data",
      "data": {
        "id": "mock-service-6",
        "provider_id": "mock-company-1",
        "category_id": "mock-cat-5",
        "title_uz": "Devor bo'yash",
        "title_ru": "Покраска стен",
        "title_en": "Wall Painting",
        "description_uz":
            "Professional bo'yash xizmatlari. Devorlar, shiftlar va boshqa yuzalarni bo'yash. Sifatli materiallar va tajribali ustalar.",
        "description_ru":
            "Профессиональные услуги покраски. Покраска стен, потолков и других поверхностей. Качественные материалы и опытные мастера.",
        "description_en":
            "Professional painting services. Painting walls, ceilings and other surfaces. Quality materials and experienced craftsmen.",
        "base_price": "120000",
        "max_price": "450000",
        "status": "active",
        "average_rating": 4.8,
        "total_bookings": 145,
        "total_reviews": 112,
        "currency_code": "UZS",
        "currency_symbol": "so'm",
        "category": {
          "id": "mock-cat-5",
          "name_uz": "Bo'yoqchi",
          "name_ru": "Маляр",
          "name_en": "Painter",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/1048/1048944.png",
          "parent_id": null
        },
        "images": [
          {
            "id": "img-1",
            "image_url":
                "https://images.unsplash.com/photo-1562259949-e8e7689d7828?w=800",
            "is_primary": true
          },
          {
            "id": "img-2",
            "image_url":
                "https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=800",
            "is_primary": false
          }
        ],
        "provider": {
          "id": "mock-company-1",
          "name": "ProFix",
          "logo_url":
              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
          "is_verified": true
        }
      }
    },
  };

  // Parsed models from JSON
  static BannerModel get banners => BannerModel.fromJson(bannersJson);
  static CategoryData get categories => CategoryData.fromJson(categoriesJson);
  static CompanyResponse get companies => CompanyResponse.fromJson(companiesJson);
  static ServicesData get services => ServicesData.fromJson(servicesJson);

  // Get service details by ID
  static DetailsServiceModel? getServiceDetails(String serviceId) {
    final json = serviceDetailsJson[serviceId];
    if (json != null) {
      return DetailsServiceModel.fromJson(json);
    }
    // Return first service as fallback for unknown IDs
    return DetailsServiceModel.fromJson(serviceDetailsJson.values.first);
  }
}
