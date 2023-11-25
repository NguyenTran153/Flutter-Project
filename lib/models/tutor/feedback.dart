class TutorFeedback {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;

  TutorFeedback({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
  });
}

List<TutorFeedback> getFeedbacks() {
  return [
    TutorFeedback(
      id: "1",
      bookingId: "123",
      firstId: "456",
      secondId: "789",
      rating: 4,
      content: "The application is very easy to use and has great features.",
      createdAt: "2023-11-20",
      updatedAt: "2023-11-22",
    ),
    TutorFeedback(
      id: "2",
      bookingId: "234",
      firstId: "567",
      secondId: "890",
      rating: 5,
      content: "I'm extremely satisfied with the service provided. Highly recommended!",
      createdAt: "2023-11-18",
      updatedAt: "2023-11-21",
    ),
    TutorFeedback(
      id: "3",
      bookingId: "345",
      firstId: "678",
      secondId: "901",
      rating: 3,
      content: "There are some improvements needed in terms of user interface design.",
      createdAt: "2023-11-15",
      updatedAt: "2023-11-19",
    ),
    // Add more feedback objects here...
  ];
}