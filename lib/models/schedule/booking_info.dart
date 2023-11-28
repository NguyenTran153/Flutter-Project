class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  bool? isDeleted;

  BookingInfo({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    this.isDeleted,
  });
}

List<BookingInfo> getBookingInfoList() {
  return [
    BookingInfo(
      id: "1",
      userId: "user_1",
      scheduleDetailId: "schedule_1",
      tutorMeetingLink: "https://tutor-link-1.com",
      studentMeetingLink: "https://student-link-1.com",
      studentRequest: "I need help with math",
      tutorReview: "Great session!",
      scoreByTutor: 4,
      createdAt: "2023-01-01T10:00:00",
      updatedAt: "2023-01-01T12:30:00",
      recordUrl: "https://record-url-1.com",
      isDeleted: false,
    ),
    BookingInfo(
      id: "2",
      userId: "user_2",
      scheduleDetailId: "schedule_2",
      tutorMeetingLink: "https://tutor-link-2.com",
      studentMeetingLink: "https://student-link-2.com",
      studentRequest: "I need help with science",
      tutorReview: "Excellent explanation!",
      scoreByTutor: 5,
      createdAt: "2023-01-02T09:45:00",
      updatedAt: "2023-01-02T11:15:00",
      recordUrl: "https://record-url-2.com",
      isDeleted: false,
    ),
    BookingInfo(
      id: "3",
      userId: "user_3",
      scheduleDetailId: "schedule_3",
      tutorMeetingLink: "https://tutor-link-3.com",
      studentMeetingLink: "https://student-link-3.com",
      studentRequest: "I need help with history",
      tutorReview: "Good communication skills!",
      scoreByTutor: 3,
      createdAt: "2023-01-03T15:20:00",
      updatedAt: "2023-01-03T17:00:00",
      recordUrl: "https://record-url-3.com",
      isDeleted: false,
    ),
  ];
}
