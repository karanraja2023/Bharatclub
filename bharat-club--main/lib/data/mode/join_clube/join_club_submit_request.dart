/// user_id : "4"
/// clubs_id : "1"
/// primary_membername : "maruthu"
/// companyname : "benchmark"
/// mobile : "11231233213"
/// member_icpassport : "Y713129312"
/// email : "aa@aa.com"
/// residence_address : "brickfields"
/// spousename : "uu"
/// spouse_mobile : "111123121"
/// spouse_email : "sss@sss.com"
/// spouse_icpassport : "y172121"
/// spouse_children : "2"
/// amount : "2000"
/// bankname : "cimb"
/// payment_date : "2024-05-03"
/// reference_number : "13232"

class JoinClubSubmitRequest {
  JoinClubSubmitRequest({
      this.userId, 
      this.clubsId, 
      this.primaryMembername, 
      this.companyname, 
      this.mobile, 
      this.memberIcpassport, 
      this.email, 
      this.residenceAddress, 
      this.spousename, 
      this.spouseMobile, 
      this.spouseEmail, 
      this.spouseIcpassport, 
      this.spouseChildren, 
      this.amount, 
      this.bankname, 
      this.paymentDate, 
      this.referenceNumber,});

  JoinClubSubmitRequest.fromJson(dynamic json) {
    userId = json['user_id'];
    clubsId = json['clubs_id'];
    primaryMembername = json['primary_membername'];
    companyname = json['companyname'];
    mobile = json['mobile'];
    memberIcpassport = json['member_icpassport'];
    email = json['email'];
    residenceAddress = json['residence_address'];
    spousename = json['spousename'];
    spouseMobile = json['spouse_mobile'];
    spouseEmail = json['spouse_email'];
    spouseIcpassport = json['spouse_icpassport'];
    spouseChildren = json['spouse_children'];
    amount = json['amount'];
    bankname = json['bankname'];
    paymentDate = json['payment_date'];
    referenceNumber = json['reference_number'];
  }
  String? userId;
  String? clubsId;
  String? primaryMembername;
  String? companyname;
  String? mobile;
  String? memberIcpassport;
  String? email;
  String? residenceAddress;
  String? spousename;
  String? spouseMobile;
  String? spouseEmail;
  String? spouseIcpassport;
  String? spouseChildren;
  String? amount;
  String? bankname;
  String? paymentDate;
  String? referenceNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['clubs_id'] = clubsId;
    map['primary_membername'] = primaryMembername;
    map['companyname'] = companyname;
    map['mobile'] = mobile;
    map['member_icpassport'] = memberIcpassport;
    map['email'] = email;
    map['residence_address'] = residenceAddress;
    map['spousename'] = spousename;
    map['spouse_mobile'] = spouseMobile;
    map['spouse_email'] = spouseEmail;
    map['spouse_icpassport'] = spouseIcpassport;
    map['spouse_children'] = spouseChildren;
    map['amount'] = amount;
    map['bankname'] = bankname;
    map['payment_date'] = paymentDate;
    map['reference_number'] = referenceNumber;
    return map;
  }

}