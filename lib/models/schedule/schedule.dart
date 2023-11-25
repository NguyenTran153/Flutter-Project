class Schedule {
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;


  Schedule({
    this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
  });
}

List<Schedule> getSchedules() {
  return [
    Schedule(
      id: "1",
      tutorId: "123",
      startTime: "08:00 AM",
      endTime: "10:00 AM",
      startTimestamp: 1679798400,
      endTimestamp: 1679809200,
      createdAt: "2023-11-20",
      isBooked: true,
    ),
    Schedule(
      id: "2",
      tutorId: "456",
      startTime: "02:00 PM",
      endTime: "04:00 PM",
      startTimestamp: 1679852400,
      endTimestamp: 1679863200,
      createdAt: "2023-11-22",
      isBooked: false,
    ),
    Schedule(
      id: "3",
      tutorId: "789",
      startTime: "10:30 AM",
      endTime: "12:30 PM",
      startTimestamp: 1679706600,
      endTimestamp: 1679717400,
      createdAt: "2023-11-25",
      isBooked: true,
    ),
    Schedule(
      id: "4",
      tutorId: "101",
      startTime: "03:00 PM",
      endTime: "05:00 PM",
      startTimestamp: DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
      endTimestamp: DateTime.now().add(Duration(days: 1, hours: 2)).millisecondsSinceEpoch,
      createdAt: "2023-11-26",
      isBooked: false,
    ),
    Schedule(
      id: "5",
      tutorId: "202",
      startTime: "10:00 AM",
      endTime: "12:00 PM",
      startTimestamp: DateTime.now().add(Duration(days: 2)).millisecondsSinceEpoch,
      endTimestamp: DateTime.now().add(Duration(days: 2, hours: 2)).millisecondsSinceEpoch,
      createdAt: "2023-11-27",
      isBooked: true,
    ),
    // Add more schedule objects here...
  ];
}