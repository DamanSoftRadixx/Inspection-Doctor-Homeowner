import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/model/local/widget_size.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/model/network/inspection_detail_response_model.dart';

class InspectionHistoryLocalModel{
  String id;
  String message;
  String title;
  bool isShowLine;
  String iconPath;
  InspectionSchedulesHistoryModel? historyResponse;
  bool isShowCancelButton;
  bool isShowRescheduleButton;
  bool isShowGiveFeedBackButton;
  bool isShowViewReportButton;
  WidgetSize? widgetSize;


  InspectionHistoryLocalModel({required this.id, required this.message,
    required this.iconPath,required this.isShowLine,
    required this.title,this.historyResponse,this.isShowCancelButton = false,
    this.isShowRescheduleButton = false,
    this.isShowGiveFeedBackButton = false,
    this.isShowViewReportButton = false,});
}