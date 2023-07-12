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
