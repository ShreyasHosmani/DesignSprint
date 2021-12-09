class TeamListParser {
  String teamID;
  String teamUserid;
  String teamSprintid;
  String teamNameid;
  String teamMemberName;
  String teamMemberEmail;
  String teamStatus;
  String tnID;
  String tnUserid;
  String tnSprintid;
  String tnName;
  String tnStatus;
  String userID;
  String userAuthProvider;
  String userAuthid;
  String userFullname;
  String userEmail;
  String userPassword;
  String userFCMtoken;
  String userProfilepic;
  String userPhoneno;
  String userRegistered;
  String userLastlogin;
  String userStatus;

  TeamListParser(
      {this.teamID,
        this.teamUserid,
        this.teamSprintid,
        this.teamNameid,
        this.teamMemberName,
        this.teamMemberEmail,
        this.teamStatus,
        this.tnID,
        this.tnUserid,
        this.tnSprintid,
        this.tnName,
        this.tnStatus,
        this.userID,
        this.userAuthProvider,
        this.userAuthid,
        this.userFullname,
        this.userEmail,
        this.userPassword,
        this.userFCMtoken,
        this.userProfilepic,
        this.userPhoneno,
        this.userRegistered,
        this.userLastlogin,
        this.userStatus});

  TeamListParser.fromJson(Map<String, dynamic> json) {
    teamID = json['teamID'];
    teamUserid = json['teamUserid'];
    teamSprintid = json['teamSprintid'];
    teamNameid = json['teamNameid'];
    teamMemberName = json['teamMemberName'];
    teamMemberEmail = json['teamMemberEmail'];
    teamStatus = json['teamStatus'];
    tnID = json['tnID'];
    tnUserid = json['tnUserid'];
    tnSprintid = json['tnSprintid'];
    tnName = json['tnName'];
    tnStatus = json['tnStatus'];
    userID = json['userID'];
    userAuthProvider = json['userAuthProvider'];
    userAuthid = json['userAuthid'];
    userFullname = json['userFullname'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
    userFCMtoken = json['userFCMtoken'];
    userProfilepic = json['userProfilepic'];
    userPhoneno = json['userPhoneno'];
    userRegistered = json['userRegistered'];
    userLastlogin = json['userLastlogin'];
    userStatus = json['userStatus'];
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
    data['tnID'] = this.tnID;
    data['tnUserid'] = this.tnUserid;
    data['tnSprintid'] = this.tnSprintid;
    data['tnName'] = this.tnName;
    data['tnStatus'] = this.tnStatus;
    data['userID'] = this.userID;
    data['userAuthProvider'] = this.userAuthProvider;
    data['userAuthid'] = this.userAuthid;
    data['userFullname'] = this.userFullname;
    data['userEmail'] = this.userEmail;
    data['userPassword'] = this.userPassword;
    data['userFCMtoken'] = this.userFCMtoken;
    data['userProfilepic'] = this.userProfilepic;
    data['userPhoneno'] = this.userPhoneno;
    data['userRegistered'] = this.userRegistered;
    data['userLastlogin'] = this.userLastlogin;
    data['userStatus'] = this.userStatus;
    return data;
  }
}
