class DecisionMakerParser {
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

  DecisionMakerParser(
      {this.userID,
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

  DecisionMakerParser.fromJson(Map<String, dynamic> json) {
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
