class CategoryMockData {
  static const bool useMockData = true;

  static Map<String, dynamic> getMockCategories() {
    return {
      "success": true,
      "data": [
        {
          "id": "mock-cat-1",
          "name_uz": "Sartaroshlik",
          "name_ru": "Парикмахерская",
          "name_en": "Barbershop",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2540/2540536.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-2",
          "name_uz": "Uy tozalash",
          "name_ru": "Уборка дома",
          "name_en": "House Cleaning",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2936/2936690.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-3",
          "name_uz": "Santexnik",
          "name_ru": "Сантехник",
          "name_en": "Plumbing",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/4635/4635163.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-4",
          "name_uz": "Elektrik",
          "name_ru": "Электрик",
          "name_en": "Electrician",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2933/2933245.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-5",
          "name_uz": "Konditsioner",
          "name_ru": "Кондиционер",
          "name_en": "Air Conditioning",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/3274/3274468.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-6",
          "name_uz": "Avtoyuvish",
          "name_ru": "Автомойка",
          "name_en": "Car Wash",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/3097/3097180.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-7",
          "name_uz": "Mebel ta'mirlash",
          "name_ru": "Ремонт мебели",
          "name_en": "Furniture Repair",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/2271/2271046.png",
          "parent_id": null
        },
        {
          "id": "mock-cat-8",
          "name_uz": "Go'zallik",
          "name_ru": "Красота",
          "name_en": "Beauty",
          "icon_url": "https://cdn-icons-png.flaticon.com/512/1940/1940922.png",
          "parent_id": null
        },
      ],
      "message": "Success",
      "error": null
    };
  }
}
