import 'package:flutter/cupertino.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/model/local/widget_size.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/model/network/request/inspection_detail_response_model.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/model/network_model/property_inspection_schedules_history_model.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/model/network_model/schedule_inspection_list_response_model.dart';

class InspectionHistoryLocalModel {
  String id;
  String message;
  String title;
  bool isShowLine;
  String iconPath;
  PropertyInspectionSchedulesHistory? historyResponse;
  bool isShowCancelButton;
  bool isShowRescheduleButton;
  bool isShowGiveFeedBackButton;
  bool isShowViewReportButton;
  WidgetSize? widgetSize;
  GlobalKey? globalKey;

  InspectionHistoryLocalModel({
    required this.id,
    required this.message,
    required this.iconPath,
    required this.isShowLine,
    required this.title,
    this.historyResponse,
    this.globalKey,
    this.isShowCancelButton = false,
    this.isShowRescheduleButton = false,
    this.isShowGiveFeedBackButton = false,
    this.isShowViewReportButton = false,
  });
}
