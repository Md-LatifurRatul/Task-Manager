class TaskCounterItem {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskCounterItem(
      {this.sId, this.title, this.description, this.status, this.createdDate});

  TaskCounterItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }
}
