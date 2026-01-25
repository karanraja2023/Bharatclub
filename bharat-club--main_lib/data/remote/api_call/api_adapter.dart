import '../../mode/event_model/event_payment_submit_request.dart';
import '../web_response.dart';

abstract class IApiRepository {
  Future<WebResponseSuccess> postRegistration(dynamic exhibitorsListRequest);

  Future<WebResponseSuccess> postProfileUpdate(dynamic exhibitorsListRequest);

  Future<WebResponseSuccess> postCmsPage(dynamic exhibitorsListRequest);

  Future<WebResponseSuccess> postProfile();

  Future<WebResponseSuccess> postDashboard();

  Future<WebResponseSuccess> postMemberList();

  Future<WebResponseSuccess> postBannerList();

  Future<WebResponseSuccess> postEventDetails();
  
  Future<WebResponseSuccess> postEventsSubmit(dynamic exhibitorsListRequest);

  Future<WebResponseSuccess> postForgetPassword(dynamic exhibitorsListRequest);

  Future<WebResponseSuccess> postDelete(dynamic exhibitorsListRequest);

  Future<WebResponseSuccess> eventsImage(
      String filePart, EventPaymentSubmitRequest exhibitorsListRequest);
}
