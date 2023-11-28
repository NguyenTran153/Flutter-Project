class Tutor {
  int id;
  String name;
  String email;
  String avatar;
  String country;
  String phone;
  String language;
  String? specialties;
  double rating;

  Tutor({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.language,
    required this.specialties,
    required this.rating,
  });
}

List<Tutor> getTutors() {
  return [
    Tutor(
      id: 1,
      name: "Tutor 1",
      email: "tutor1@example.com",
      avatar: "https://plus.unsplash.com/premium_photo-1674180786953-4223a4208d9a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      country: "Vietnam",
      phone: "1234567891",
      language: "Language 1",
      specialties: "Math, Physics, Chemistry",
      rating: 4.5,
    ),
    Tutor(
      id: 2,
      name: "Tutor 2",
      email: "tutor2@example.com",
      avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      country: "Country 2",
      phone: "1234567892",
      language: "Language 2",
      specialties: "Math, Physics, Chemistry",
      rating: 3.8,
    ),
    Tutor(
      id: 3,
      name: "Tutor 3",
      email: "tutor3@example.com",
      avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      country: "Vietnam",
      phone: "1234567893",
      language: "Language 3",
      specialties: "Specialties 3",
      rating: 2.1,
    ),
    Tutor(
      id: 4,
      name: "Tutor 4",
      email: "tutor4@example.com",
      avatar: "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      country: "Vietname",
      phone: "1234567894",
      language: "Language 4",
      specialties: "Math, Physics, Chemistry",
      rating: 3.5,
    ),
    Tutor(
      id: 5,
      name: "Tutor 5",
      email: "tutor5@example.com",
      avatar: "https://plus.unsplash.com/premium_photo-1658527049634-15142565537a?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      country: "Country 5",
      phone: "1234567895",
      language: "Language 5",
      specialties: "Specialties 5",
      rating: 4.0,
    ),
    Tutor(
      id: 6,
      name: "Tutor 6",
      email: "tutor6@example.com",
      avatar: "avatar6.jpg",
      country: "Country 6",
      phone: "1234567896",
      language: "Language 6",
      specialties: "History",
      rating: 4.8,
    ),
    Tutor(
      id: 7,
      name: "Tutor 7",
      email: "tutor7@example.com",
      avatar: "avatar7.jpg",
      country: "Vietnam",
      phone: "1234567897",
      language: "Language 7",
      specialties: "Specialties 7",
      rating: 3.9,
    ),
    Tutor(
      id: 8,
      name: "Tutor 8",
      email: "tutor8@example.com",
      avatar: "avatar8.jpg",
      country: "Country 8",
      phone: "1234567898",
      language: "Language 8",
      specialties: "Specialties 8",
      rating: 4.1,
    ),
    Tutor(
      id: 9,
      name: "Tutor 9",
      email: "tutor9@example.com",
      avatar: "avatar9.jpg",
      country: "Country 9",
      phone: "1234567899",
      language: "Language 9",
      specialties: "Specialties 9",
      rating: 4.7,
    ),
    Tutor(
      id: 10,
      name: "Tutor 10",
      email: "tutor10@example.com",
      avatar: "avatar10.jpg",
      country: "Country 10",
      phone: "12345678910",
      language: "Math, Physics",
      specialties: "Specialties 10",
      rating: 4.2,
    ),
  ];
}