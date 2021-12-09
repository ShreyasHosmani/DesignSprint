class MembersListParser {
  String teamID;
  String teamUserid;
  String teamSprintid;
  String teamNameid;
  String teamMemberName;
  String teamMemberEmail;
  String teamStatus;

  MembersListParser(
      {this.teamID,
        this.teamUserid,
        this.teamSprintid,
        this.teamNameid,
        this.teamMemberName,
        this.teamMemberEmail,
        this.teamStatus});

  MembersListParser.fromJson(Map<String, dynamic> json) {
    teamID = json['teamID'];
    teamUserid = json['teamUserid'];
    teamSprintid = json['teamSprintid'];
    teamNameid = json['teamNameid'];
    teamMemberName = json['teamMemberName'];
    teamMemberEmail = json['teamMemberEmail'];
    teamStatus = json['teamStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamID'] = this.teamID;
    data['teamUserid'] = this.teamUserid;
    data['teamSprintid'] = this.teamSprintid;
    data['teamNameid'] = this.teamNameid;
    data['teamMemberName'] = this.teamMemberName;
    data['teamMemberEmail'] = this.teamMemberEmail;
    data['teamStatus'] = this.teamStatus;
    return data;
  }
}
