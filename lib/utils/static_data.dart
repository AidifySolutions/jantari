class StaticData {
  static Map<int, String> dataTypesEnumToString = {
    0: "text",
    1: "number",
    2: "select",
    3: "multiselect",
    4: "checkbox",
    5: "radio",
    6: "switch",
    7: "datePicker",
    8: "timePicker",
    9: "dateTimePicker",
    10: "colorPicker",
    11: "dualListBox",
    12: "conditionBuilder",
    13: "creatableSelect",
    14: "list",
    15: "fileInput",
    16: "richTextBox",
  };

  static Map<String, int> dataTypesStringToEnum = {
    "text": 0,
    "number": 1,
    "select": 2,
    "multiselect": 3,
    "checkbox": 4,
    "radio": 5,
    "switch": 6,
    "datePicker": 7,
    "timePicker": 8,
    "dateTimePicker": 9,
    "colorPicker": 10,
    "dualListBox": 11,
    "conditionBuilder": 12,
    "creatableSelect": 13,
    "list": 14,
    "fileInput": 15,
    "richTextBox": 16
  };

  static Map<int, String> workflowStatusEnumToString = {
    0: "InProgress",
    1: "Completed",
    2: "Unassigned",
    3: "AwaitingAuthentication",
    4: "Cancelled",
    5: "Rejected",
    6: "AwaitingPreChecksVerification",
    7: "Discrepant",
    8: "Withdrawn"
  };

  static Map<String, int> workflowStatusStringToEnum = {
    "InProgress": 0,
    "Completed": 1,
    "Unassigned": 2,
    "AwaitingAuthentication": 3,
    "Cancelled": 4,
    "Rejected": 5,
    "AwaitingPreChecksVerification": 6,
    "Discrepant": 7,
    "Withdrawn": 8
  };

  static Map<int, String> workflowStageStatusEnumToString = {
    0: "InProgress",
    1: "Completed",
    2: "AwaitingAuthentication",
    3: "Archived",
    4: "AwaitingPreChecksVerification",
    5: "Discrepant"
  };

  static Map<String, int> workflowStageStatusStringToEnum = {
    "InProgress": 0,
    "Completed": 1,
    "AwaitingAuthentication": 2,
    "Archived": 3,
    "AwaitingPreChecksVerification": 4,
    "Discrepant": 5
  };

  static Map<String, String> workflowStatusTitles = {
    "InProgress": "In Progress",
    "Completed": "Completed",
    "Unassigned": "Unassigned",
    "AwaitingAuthentication": "Awaiting Authentication",
    "Cancelled": "Cancelled",
    "Rejected": "Rejected",
    "AwaitingPreChecksVerification": "Awaiting Pre Check Verification",
    "Discrepant": "Discrepant",
    "Withdrawn": "Withdrawn",

  };

}
