import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organization/alert/app_alert.dart';
import 'package:organization/common/constant/app_constant.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/data/mode/banner_list/banner_list.dart';
import 'package:organization/data/mode/cms_page/cms_page_request.dart';
import 'package:organization/data/mode/cms_page/contact_us_response.dart';
import 'package:organization/data/mode/cms_page/event_response.dart';
import 'package:organization/data/mode/dashboard/dashboard_response.dart';
import 'package:organization/data/mode/event_attendance/event_attendance_response.dart';
import 'package:organization/data/mode/event_details_model/event_details_response_model.dart';
import 'package:organization/data/mode/event_model/event_apply_response.dart';
import 'package:organization/data/mode/event_model/event_payment_submit_request.dart';
import 'package:organization/data/mode/event_one_model/participant_submit_response.dart';
import 'package:organization/data/mode/event_qr_scan/qr_details_response.dart';
import 'package:organization/data/mode/forgot_password/forgot_password_delete_response.dart';
import 'package:organization/data/mode/join_clube/join_club_response.dart';
import 'package:organization/data/mode/join_clube/join_club_submit_response.dart';
import 'package:organization/data/mode/member_list/member_list_response.dart';
import 'package:organization/data/mode/membership_type/membership_type_response.dart';
import 'package:organization/data/mode/profile_pic/profile_pic_response.dart';
import 'package:organization/data/mode/profile_response/profile_response.dart';
import 'package:organization/data/mode/profile_response/profile_update_response.dart';
import 'package:organization/data/mode/registration/registration_response.dart';
import 'package:organization/data/mode/sponsor_event/sponsor_event_attach_response.dart';
import 'package:organization/screens/about_us/about_us_model.dart';
import 'package:organization/screens/gallery/model/gallery_model.dart';
import '../web_response.dart';
import '../web_response_failed.dart';
import 'api_adapter.dart';
import 'api_dio_provider.dart';
import 'api_provider.dart';

class AllApiImpl implements IApiRepository {
  WebProvider mWebProvider = WebProvider();
  late WebResponseSuccess mWebResponseSuccess;
  late WebResponseFailed mWebResponseFailed;

  Map processResponseToJson(Response response) {
    var responseBody = response.body;
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonEncode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 200 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseBody;
      case 400:
        Map responseJson = json.decode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 400 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseJson;
      case 403:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 403 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseJson;
      case 404:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 404 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseJson;
      case 500:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 500 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseJson;
      case 502:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 502 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseJson;
      case 503:
        Map responseJson = json.decode(WebConstants.statusCode503Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 503 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseJson;
      default:
        var responseJson = jsonEncode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint(
            "Webservices 200 decoded Response $responseJson",
            wrapWidth: 3072,
          );
        }
        return responseBody;
    }
  }

  ///post Registration
  @override
  Future<WebResponseSuccess> postRegistration(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
      WebConstants.actionRegistration,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      RegistrationResponse mRegistrationResponse =
          RegistrationResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mRegistrationResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post Registration
  ///post Login - FIXED VERSION without progress dialog
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
      WebConstants.actionLogin,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);

    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        statusMessage: "",
        error: true,
      );
    } else {
      RegistrationResponse mRegistrationResponse =
          RegistrationResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mRegistrationResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  Future<WebResponseSuccess> postChangePassword(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
      WebConstants.actionChangePassword,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      RegistrationResponse mRegistrationResponse =
          RegistrationResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mRegistrationResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post Profile Update
  @override
  Future<WebResponseSuccess> postProfileUpdate(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
      WebConstants.actionProfileUpdate,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      ProfileUpdateResponse mProfileUpdateResponse =
          ProfileUpdateResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mProfileUpdateResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post Registration
  @override
  Future<WebResponseSuccess> postProfile() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionProfile,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      ProfileResponse mProfileResponse = ProfileResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mProfileResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post Registration
  @override
  Future<WebResponseSuccess> postDashboard() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionDashboard,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      DashboardResponse mDashboardResponse = DashboardResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mDashboardResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///cms Page
  @override
  Future<WebResponseSuccess> postCmsPage(dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
      WebConstants.actionCmsPage,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      dynamic dResponse = getResponse(
        processResponseToJson(cases),
        exhibitorsListRequest,
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: dResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  getResponse(Map processResponseToJson, CmsPageRequest sRequest) {
    if (CmsPageRequestType.CONTACT.name == sRequest.name) {
      ContactUsResponse mContactUsResponse = ContactUsResponse.fromJson(
        processResponseToJson,
      );
      return mContactUsResponse;
    } else if (CmsPageRequestType.EVENTS.name == sRequest.name) {
      EventResponse mEventResponse = EventResponse.fromJson(
        processResponseToJson,
      );
      return mEventResponse;
    } else if (CmsPageRequestType.GALLERY.name == sRequest.name) {
      GalleryResponse mGalleryResponse = GalleryResponse.fromJson(
        processResponseToJson,
      );
      return mGalleryResponse;
    } else if (CmsPageRequestType.ABOUT_US.name == sRequest.name) {
      AboutUsResponse mAboutUsResponse = AboutUsResponse.fromJson(
        processResponseToJson,
      );
      return mAboutUsResponse;
    } else {}
  }

  ///JoinClubs
  Future<WebResponseSuccess> postJoinClubs() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionJoinClubs,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      JoinClubResponse mJoinClubData = JoinClubResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mJoinClubData,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///postImage
  Future<WebResponseSuccess> postImage(String filePart) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await WebHttpProvider().postWithAuthAndNoRequestAndAttachment(
      WebConstants.actionUploadProfileImage,
      filePath: filePart,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        jsonDecode(cases.body.toString()),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      ProfilePicResponse mProfilePicResponse = ProfilePicResponse.fromJson(
        jsonDecode(cases.body),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mProfilePicResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///MemberList
  @override
  Future<WebResponseSuccess> postMemberList() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionMemberList,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      MemberListResponse mMemberListResponse = MemberListResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mMemberListResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///BannerList
  @override
  Future<WebResponseSuccess> postBannerList() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionBannerList,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      BannerListResponse mBannerListResponse = BannerListResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mBannerListResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post join club
  Future<WebResponseSuccess> postJoinClubSubmit(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
      WebConstants.actionJoinClubSubmit,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      JoinClubSubmitResponse mJoinClubSubmitResponse =
          JoinClubSubmitResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mJoinClubSubmitResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post events
  @override
  Future<WebResponseSuccess> postEventsSubmit(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionEventSubmit,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      EventApplyResponse mEventApplyResponse = EventApplyResponse.fromJson(
        processResponseToJson(cases),
      );

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventApplyResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      EventApplyResponse mEventApplyResponse = EventApplyResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventApplyResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  //event details
  @override
  Future<WebResponseSuccess> postEventDetails() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionEventDetails,
    );
    AppAlert.hideLoadingDialog(Get.context!);

    //   final sampleJson = {
    //     "statusCode": 200,
    //     "error": false,
    //     "statusMessage": "Success",
    //     "data": {
    //       "response": {
    //         "id": 1,
    //         "title": "Annual Dinner",
    //         "description": "Join us for an unforgettable evening filled with entertainment, fine dining, and celebration.",
    //         "start_date": "2024-12-10",
    //         "end_date": "2024-12-10",
    //         "status": 1,
    //         "created_by": 101,
    //         "modified_by": 102,
    //         "created_at": "2024-01-15T08:30:00Z",
    //         "updated_at": "2024-05-20T14:45:00Z",
    //         "deleted_at": null,
    //         "member_adult_age": "18-60",
    //         "member_adult_amount": 150.00,
    //         "member_child_status": 1,
    //         "member_child_age": "5-17",
    //         "member_child_amount": 75.00,
    //         "guest_adult_age": "18-60",
    //         "guest_adult_amount": 200.00,
    //         "guest_child_status": 1,
    //         "guest_child_age": "5-17",
    //         "guest_child_amount": 100.00,
    //         "food_status": 1,
    //         "subscription_status": 0
    //       },
    //       "message": "Event details loaded successfully"
    //     }
    //   };

    //         EventDetailResponse mEventDetailResponse = EventDetailResponse.fromJson(sampleJson);

    // return WebResponseSuccess(
    //   statusCode: sampleJson['statusCode'] as int?,
    //   error: sampleJson['error'] as bool?,
    //   statusMessage: sampleJson['statusMessage'] as String?,
    //   data: mEventDetailResponse,
    // );

    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: "",
        error: true,
      );
    } else {
      EventDetailResponse mEventDetailResponse = EventDetailResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventDetailResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  //events participantsubmit
  Future<WebResponseSuccess> postParticipantSubmit(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionPartipantSubmit,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      ParticipantSubmitResponse mParticipantSubmitResponse =
          ParticipantSubmitResponse.fromJson(processResponseToJson(cases));

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mParticipantSubmitResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      ParticipantSubmitResponse mParticipantSubmitResponse =
          ParticipantSubmitResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mParticipantSubmitResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  //Qr scan details
  Future<WebResponseSuccess> postQrDetails(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionQrScanDetails,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      QrDetailsResponse mQrDetailsResponse = QrDetailsResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mQrDetailsResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      QrDetailsResponse mQrDetailsResponse = QrDetailsResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mQrDetailsResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  // event attendance
  Future<WebResponseSuccess> postEventAttendance(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionEventAttentace,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      EventAttendanceResponse mEventAttendanceResponse =
          EventAttendanceResponse.fromJson(processResponseToJson(cases));

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventAttendanceResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      EventAttendanceResponse mEventAttendanceResponse =
          EventAttendanceResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventAttendanceResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  //Sponsor Event
  Future<WebResponseSuccess> postSponsorEvent(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionSponsorEvent,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      SponsorEventAttachmentResponse mSponsorEventAttachmentResponse =
          SponsorEventAttachmentResponse.fromJson(processResponseToJson(cases));

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mSponsorEventAttachmentResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      SponsorEventAttachmentResponse mSponsorEventAttachmentResponse =
          SponsorEventAttachmentResponse.fromJson(processResponseToJson(cases));

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mSponsorEventAttachmentResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  //membership type
  Future<WebResponseSuccess> postMembershipType() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    var cases = await mWebProvider.postWithoutRequest(
      WebConstants.actionMembershipType,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      MembershipTypeResponse mMembershipTypeResponse =
          MembershipTypeResponse.fromJson(processResponseToJson(cases));

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mMembershipTypeResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      MembershipTypeResponse mMembershipTypeResponse =
          MembershipTypeResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mMembershipTypeResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///events upload
  Future<WebResponseSuccess> eventsImage(
    String filePart,
    EventPaymentSubmitRequest exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await WebHttpProvider().postWithAuthAndRequestAndAttachment(
      WebConstants.actionUploadPayment,
      exhibitorsListRequest.toJson(),
      filePath: filePart,
    );
    debugPrint("eventsImage statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("eventsImage ==  ${jsonEncode(cases.body)}");
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed = WebResponseFailed.fromJson(
        jsonDecode(cases.body.toString()),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        statusMessage: "",
        error: true,
      );
    } else {
      ProfilePicResponse mProfilePicResponse = ProfilePicResponse.fromJson(
        jsonDecode(cases.body),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mProfilePicResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post Delete account
  @override
  Future<WebResponseSuccess> postDelete(dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionAccountDeletion,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      EventApplyResponse mEventApplyResponse = EventApplyResponse.fromJson(
        processResponseToJson(cases),
      );

      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventApplyResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      ForgotPasswordDeleteResponse mForgotPasswordDeleteResponse =
          ForgotPasswordDeleteResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mForgotPasswordDeleteResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }

  ///post ForgetPassword
  @override
  Future<WebResponseSuccess> postForgetPassword(
    dynamic exhibitorsListRequest,
  ) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    var cases = await mWebProvider.postWithRequest(
      WebConstants.actionForgotPassword,
      exhibitorsListRequest,
    );
    AppAlert.hideLoadingDialog(Get.context!);
    debugPrint(
      "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}",
    );
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    if (cases.statusCode != WebConstants.statusCode200) {
      EventApplyResponse mEventApplyResponse = EventApplyResponse.fromJson(
        processResponseToJson(cases),
      );
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mEventApplyResponse,
        statusMessage: "",
        error: true,
      );
    } else {
      ForgotPasswordDeleteResponse mForgotPasswordDeleteResponse =
          ForgotPasswordDeleteResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mForgotPasswordDeleteResponse,
        statusMessage: "",
        error: false,
      );
    }

    return mWebResponseSuccess;
  }
}
