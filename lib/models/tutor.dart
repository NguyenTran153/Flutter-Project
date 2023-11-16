class Tutor {
  String name;
  String email;
  String avatar;
  String country;
  String phone;
  String language;
  String? specialties;
  double rating;

  Tutor({
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
      name: "Tutor 1",
      email: "tutor1@example.com",
      avatar: "avatar1.jpg",
      country: "Country 1",
      phone: "1234567891",
      language: "Language 1",
      specialties: "Specialties 1",
      rating: 4.5,
    ),
    Tutor(
      name: "Tutor 2",
      email: "tutor2@example.com",
      avatar: "avatar2.jpg",
      country: "Country 2",
      phone: "1234567892",
      language: "Language 2",
      specialties: "Specialties 2",
      rating: 3.8,
    ),
    Tutor(
      name: "Tutor 3",
      email: "tutor3@example.com",
      avatar: "avatar3.jpg",
      country: "Country 3",
      phone: "1234567893",
      language: "Language 3",
      specialties: "Specialties 3",
      rating: 4.2,
    ),
    Tutor(
      name: "Tutor 4",
      email: "tutor4@example.com",
      avatar: "avatar4.jpg",
      country: "Country 4",
      phone: "1234567894",
      language: "Language 4",
      specialties: "Specialties 4",
      rating: 3.5,
    ),
    Tutor(
      name: "Tutor 5",
      email: "tutor5@example.com",
      avatar: "avatar5.jpg",
      country: "Country 5",
      phone: "1234567895",
      language: "Language 5",
      specialties: "Specialties 5",
      rating: 4.0,
    ),
    Tutor(
      name: "Tutor 6",
      email: "tutor6@example.com",
      avatar: "avatar6.jpg",
      country: "Country 6",
      phone: "1234567896",
      language: "Language 6",
      specialties: "Specialties 6",
      rating: 4.8,
    ),
    Tutor(
      name: "Tutor 7",
      email: "tutor7@example.com",
      avatar: "avatar7.jpg",
      country: "Country 7",
      phone: "1234567897",
      language: "Language 7",
      specialties: "Specialties 7",
      rating: 3.9,
    ),
    Tutor(
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
      name: "Tutor 10",
      email: "tutor10@example.com",
      avatar: "avatar10.jpg",
      country: "Country 10",
      phone: "12345678910",
      language: "Language 10",
      specialties: "Specialties 10",
      rating: 4.2,
    ),
  ];
}