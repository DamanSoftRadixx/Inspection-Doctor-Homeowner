import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FlutterFlowPdfViewer extends StatefulWidget {
  const FlutterFlowPdfViewer({
    Key? key,
    this.networkPath,
    this.assetPath,
    this.width,
    this.height,
    this.horizontalScroll = false,
    this.title
  })  : assert((networkPath != null) ^ (assetPath != null)),
        super(key: key);

  final String? networkPath;
  final String? assetPath;
  final String? title;
  final double? width;
  final double? height;
  final bool horizontalScroll;

  @override
  _FlutterFlowPdfViewerState createState() => _FlutterFlowPdfViewerState();
}

class _FlutterFlowPdfViewerState extends State<FlutterFlowPdfViewer> {
  PdfController? controller;
  String get networkPath => widget.networkPath ?? '';
  String get assetPath => widget.assetPath ?? '';

  void initializeController() =>
      controller = networkPath.isNotEmpty || assetPath.isNotEmpty
          ? PdfController(
              document: assetPath.isNotEmpty
                  ? PdfDocument.openAsset(assetPath)
                  : PdfDocument.openData(InternetFile.get(networkPath)),
            )
          : null;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  @override
  void didUpdateWidget(FlutterFlowPdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.networkPath != widget.networkPath) {
      initializeController();
    }
  }

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
        appBar: commonAppBarWithElevation(
            title: widget.title ?? AppStrings.document.tr,
            onPressBackButton: () {
              Get.back();
            }),
        body: controller != null
            ? PdfView(
                controller: controller!,
                scrollDirection:
                    widget.horizontalScroll ? Axis.horizontal : Axis.vertical,
                builders: PdfViewBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  documentLoaderBuilder: (_) =>
                      const Center(child: CommonLoader(isLoading: true)),
                  pageLoaderBuilder: (_) =>
                      const Center(child: CommonLoader(isLoading: true)),
                  errorBuilder: (_, __) => Container(),
                ),
              )
            : Container(),
      );
}
