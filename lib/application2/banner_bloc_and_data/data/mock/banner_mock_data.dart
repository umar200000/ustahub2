class BannerMockData {
  static const bool useMockData = false;

  static Map<String, dynamic> getMockBanners() {
    return {
      "success": true,
      "data": [
        {
          "id": "mock-banner-1",
          "title": "50% chegirma!",
          "subtitle": "Barcha uy tozalash xizmatlariga",
          "image_url":
              "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800",
        },
        {
          "id": "mock-banner-2",
          "title": "Yangi foydalanuvchilar uchun",
          "subtitle": "Birinchi buyurtmangizga 30% chegirma",
          "image_url":
              "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800",
        },
        {
          "id": "mock-banner-3",
          "title": "Premium xizmatlar",
          "subtitle": "Eng yaxshi mutaxassislar sizning xizmatingizda",
          "image_url":
              "https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800",
        },
        {
          "id": "mock-banner-4",
          "title": "Konditsioner mavsumi",
          "subtitle": "Konditsioner tozalash va ta'mirlash xizmatlari",
          "image_url":
              "https://images.unsplash.com/photo-1631545806609-1de5b6bff814?w=800",
        },
      ],
      "message": "Success",
      "error": null,
    };
  }

  static final Map<String, Map<String, dynamic>> _bannerDetails = {
    "mock-banner-1": {
      "id": "mock-banner-1",
      "title": "50% chegirma!",
      "subtitle": "Barcha uy tozalash xizmatlariga",
      "description": """
Hurmatli mijozlar!

Biz sizga ajoyib yangilik taqdim etamiz - barcha uy tozalash xizmatlarimizga 50% chegirma!

Bu aksiya quyidagi xizmatlarni o'z ichiga oladi:
• Standart uy tozalash
• Chuqur tozalash (general cleaning)
• Ofis tozalash
• Oyna tozalash
• Gilam yuvish

Aksiya shartlari:
- Aksiya 2026-yil 28-fevral sanasigacha amal qiladi
- Minimal buyurtma summasi: 100,000 so'm
- Bir mijoz bir marta foydalanishi mumkin
- Boshqa chegirmalar bilan birga qo'llanilmaydi

Buyurtma berish uchun ilovamiz orqali xizmatni tanlang va "CLEAN50" promo kodini kiriting.

Toza va qulay uy - baxtli oila!
      """,
      "image_url":
          "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800",
    },
    "mock-banner-2": {
      "id": "mock-banner-2",
      "title": "Yangi foydalanuvchilar uchun",
      "subtitle": "Birinchi buyurtmangizga 30% chegirma",
      "description": """
UstaHub ilovasiga xush kelibsiz!

Yangi foydalanuvchilar uchun maxsus taklif - birinchi buyurtmangizga 30% chegirma!

Bu chegirma barcha xizmatlarimizga amal qiladi:
• Sartaroshlik xizmatlari
• Uy tozalash
• Santexnik ishlari
• Elektrik ishlari
• Konditsioner xizmatlari
• Avtomobil yuvish
• Mebel ta'mirlash
• Go'zallik xizmatlari

Qanday foydalanish mumkin:
1. Ro'yxatdan o'ting
2. O'zingizga kerakli xizmatni tanlang
3. Buyurtma berishda "WELCOME30" promo kodini kiriting
4. 30% chegirmadan bahramand bo'ling!

Eslatma: Chegirma faqat birinchi buyurtma uchun amal qiladi.

UstaHub - ishonchli xizmatlar, sifatli natija!
      """,
      "image_url":
          "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800",
    },
    "mock-banner-3": {
      "id": "mock-banner-3",
      "title": "Premium xizmatlar",
      "subtitle": "Eng yaxshi mutaxassislar sizning xizmatingizda",
      "description": """
Premium sifat - Premium xizmat!

UstaHub Premium - bu eng yuqori sifatli xizmatlar to'plami.

Premium xizmat nimalarni o'z ichiga oladi:
• Tasdiqlangan va sertifikatlangan mutaxassislar
• Kafolatli natija
• 24/7 qo'llab-quvvatlash
• Tez va qulay buyurtma
• Maxsus chegirmalar va bonuslar

Nima uchun Premium tanlash kerak:
✓ Barcha mutaxassislar sinov va sertifikatsiyadan o'tgan
✓ Sifatga 100% kafolat beramiz
✓ Muammo bo'lsa, bepul qayta xizmat ko'rsatamiz
✓ Premium mijozlar uchun ustuvor navbat

Premium obuna narxi: oyiga 50,000 so'm

Premium obunaga qo'shiling va eng yaxshi xizmatlardan bahramand bo'ling!
      """,
      "image_url":
          "https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800",
    },
    "mock-banner-4": {
      "id": "mock-banner-4",
      "title": "Konditsioner mavsumi",
      "subtitle": "Konditsioner tozalash va ta'mirlash xizmatlari",
      "description": """
Yoz mavsumiga tayyormisiz?

Konditsioner xizmatlariga maxsus narxlar!

Taklif qilinayotgan xizmatlar:
• Konditsioner tozalash - 150,000 so'mdan
• Freon to'ldirish - 200,000 so'mdan
• Konditsioner ta'mirlash - 250,000 so'mdan
• Yangi konditsioner o'rnatish - 300,000 so'mdan

Nima uchun konditsionerni tozalash kerak:
- Salqin havo sifatini yaxshilash
- Elektr energiyasini tejash (30% gacha)
- Konditsioner umrini uzaytirish
- Allergiya va kasalliklardan himoya

Maxsus takliflar:
🎁 2 ta va undan ko'p konditsioner tozalashga 20% chegirma
🎁 Konditsioner o'rnatishda tozalash bepul
🎁 Doimiy mijozlarga 15% chegirma

Hoziroq buyurtma bering va issiq kunlarga tayyor bo'ling!

Aksiya: 2026-yil 31-mart sanasigacha
      """,
      "image_url":
          "https://images.unsplash.com/photo-1631545806609-1de5b6bff814?w=800",
    },
  };

  static Map<String, dynamic> getMockBannerDetails(String id) {
    final details = _bannerDetails[id];

    if (details != null) {
      return {"success": true, "data": details, "message": "Success"};
    }

    // Fallback to first banner if id not found
    return {
      "success": true,
      "data": _bannerDetails.values.first,
      "message": "Success",
    };
  }
}
