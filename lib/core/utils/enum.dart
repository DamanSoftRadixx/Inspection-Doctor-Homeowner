enum BottomNavigationEnum { Home, Inspections, Notification, MyProfile }

enum ShowImagePositionAt { right, left, none }

enum LanguageEnum {
  english("English"),
  spanish("Spanish");

  final String value;

  // can use named parameters if you want
  const LanguageEnum(this.value);
}

enum DeviceTypeEnum {
  iOS("IOS"),
  android("Android");

  final String value;
  const DeviceTypeEnum(this.value);
}

enum RegisterTypeEnum {
  email("Email"),
  google("Google"),
  facebook("Facebook"),
  apple("Apple");

  final String value;
  const RegisterTypeEnum(this.value);
}

enum RoleTypeEnum {
  admin("Admin"),
  homeowner("Homeowner"),
  inspector("Inspector"),
  contractor("Contractor"),
  contractorStaff("Contractor Staff"),
  adminStaff("Admin Staff");

  final String value;
  const RoleTypeEnum(this.value);
}

 enum InspectionHistoryStatusEnum {
  newInspection("64bfb0701323eb714ed0b1f1"),
  inspectionAcccepted("64bfb0701323eb714ed0b1f2"),
  homeownerInspectionRescheduled("64bfb0701323eb714ed0b1f3"),
  homeownerInspectionCanceled("64bfb0701323eb714ed0b1f4"),
  inspectorInspectionCanceled("64bfb0701323eb714ed0b1f5"),
  inspectorInspectionRescheduled("64bfb0701323eb714ed0b1f6"),
  inspectorOnTheWay("64bfb0701323eb714ed0b1f7"),
  inspectionStart("64bfb0701323eb714ed0b1f8"),
  inspectionDone("64bfb0701323eb714ed0b1f9"),
  inspectionReportCompleted("64bfb0701323eb714ed0b1d9"),
  inspectionReportCorrections("64bfb0701323eb714ed0b2d6");

  final String value;
  const InspectionHistoryStatusEnum(this.value);
}


