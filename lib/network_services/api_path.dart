import 'package:jantari/utils/static_data.dart';

enum APIPath {
  clientCredentials,
  authenticate,
  userDetail,
  groupDetail,
  verifyUser,
  verifyOtp,
  fields,
  records,
  products,
  edithWorkflows,
  edithWorkflowWithDocument,
  lumosWorkflows,
  updateWorkflow,
  documents,
  workflowAction,
  validateNic,
  imageProcessing,
}

class ApiPathHelper {
  static String getValue(APIPath path) {
    switch (path) {
      case APIPath.clientCredentials:
        return "https://login.microsoftonline.com/${StaticData.tenantID}/oauth2/v2.0/token";
      case APIPath.authenticate:
        return "/identity/api/v1.0/oauth/token";
      case APIPath.userDetail:
        return "/identity/api/v1.0/users";
      case APIPath.groupDetail:
        return "/identity/api/v1.0/groups";
      case APIPath.verifyOtp:
        return "/lumos/api/v1/otp/verify";
      // case APIPath.fields:
      //   return "/friday/api/v1.0/Fields";
      case APIPath.fields:
        return "/friday/api/v1.0/Fields/Records";
      case APIPath.records:
        return "/quantum/api/v1.0/Records";
      case APIPath.products:
        return "/friday/api/v1.0/Products";
      case APIPath.edithWorkflows:
        return "/edith/api/v1.0/workflows";
      case APIPath.edithWorkflowWithDocument:
        return "/edith/api/v1.0/workflows/InitiateAndProceedWithDocuments";
      case APIPath.lumosWorkflows:
        return "/lumos/api/v1/workflows";
      case APIPath.updateWorkflow:
        return "/edith/api/v1.0/workflows";
      case APIPath.workflowAction:
        return "/sofi/api/v1.0/ExternalApis/CustomerFeedback";
      case APIPath.documents:
        return "/multiverse/api/v1.0/documents";
      case APIPath.validateNic:
        return "https://unikrewdocumentvalidation.azurewebsites.net/api/v1.0/Documents/Validate";
      case APIPath.imageProcessing:
        return "https://unikrewutilsbackend.azurewebsites.net/api/v1/Utils/ProcessImage";
      default:
        return "";
    }
  }
}
