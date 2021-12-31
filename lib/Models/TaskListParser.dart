class TaskListParser {
  String pttID;
  String pptUserid;
  String pptPrototypeid;
  String pptSprintid;
  String pptTasktext;
  String pptDuedate;
  String pptStatus;

  TaskListParser(
      {this.pttID,
        this.pptUserid,
        this.pptPrototypeid,
        this.pptSprintid,
        this.pptTasktext,
        this.pptDuedate,
        this.pptStatus});

  TaskListParser.fromJson(Map<String, dynamic> json) {
    pttID = json['pttID'];
    pptUserid = json['pptUserid'];
    pptPrototypeid = json['pptPrototypeid'];
    pptSprintid = json['pptSprintid'];
    pptTasktext = json['pptTasktext'];
    pptDuedate = json['pptDuedate'];
    pptStatus = json['pptStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pttID'] = this.pttID;
    data['pptUserid'] = this.pptUserid;
    data['pptPrototypeid'] = this.pptPrototypeid;
    data['pptSprintid'] = this.pptSprintid;
    data['pptTasktext'] = this.pptTasktext;
    data['pptDuedate'] = this.pptDuedate;
    data['pptStatus'] = this.pptStatus;
    return data;
  }
}
