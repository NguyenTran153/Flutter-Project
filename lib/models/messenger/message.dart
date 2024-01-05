class MessageData {
  int? count;
  List<MessageRow>? rows;

  MessageData({this.count, this.rows});

  MessageData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((row) {
        rows!.add(MessageRow.fromJson(row));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((row) => row.toJson()).toList();
    }
    return data;
  }
}

class MessageRow {
  String? id;
  String? content;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  FromInfo? fromInfo;
  ToInfo? toInfo;

  MessageRow({
    this.id,
    this.content,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.fromInfo,
    this.toInfo,
  });

  MessageRow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fromInfo = json['fromInfo'] != null ? FromInfo.fromJson(json['fromInfo']) : null;
    toInfo = json['toInfo'] != null ? ToInfo.fromJson(json['toInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['content'] = content;
    data['isRead'] = isRead;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (fromInfo != null) {
      data['fromInfo'] = fromInfo!.toJson();
    }
    if (toInfo != null) {
      data['toInfo'] = toInfo!.toJson();
    }
    return data;
  }
}

class FromInfo {
  String? id;
  String? name;

  FromInfo({this.id, this.name});

  FromInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ToInfo {
  String? id;
  String? name;

  ToInfo({this.id, this.name});

  ToInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
