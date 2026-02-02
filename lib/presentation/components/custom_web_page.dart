import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/blur_back_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomWebPage extends StatefulWidget {
  final String url;
  final void Function(BuildContext context, JavaScriptMessage)?
  onMessageReceived;

  const CustomWebPage({super.key, required this.url, this.onMessageReceived});

  @override
  State<CustomWebPage> createState() => _CustomWebPageState();
}

class _CustomWebPageState extends State<CustomWebPage> {
  late WebViewController _controller;
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "TokenHandler",
        onMessageReceived: (m) {
          if (widget.onMessageReceived != null) {
            widget.onMessageReceived!(context, m);
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            Uri uri = Uri.parse(request.url);
            if (uri.pathSegments.contains("result")) {
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (url) {
            isLoading = false;
            setState(() {});
          },
          onPageStarted: (url) {
            LogService.i(url);
          },
        ),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, _) {
        _controller.setBackgroundColor(colors.shade0);
        return Scaffold(
          // appBar: AppBar(
          //   surfaceTintColor: colors.shade0,
          //   backgroundColor: colors.shade0,
          //   leading: AnimationButtonEffect(
          //     onTap: () => Navigator.pop(context),
          //     child: Center(child: icons.backS.svg(height: 28.r, width: 28.r, color: colors.neutral800)),
          //   ),
          //   centerTitle: false,
          //   title: AnimationButtonEffect(
          //     onTap: () => Navigator.pop(context),
          //     child: Text("to_back".tr(), style: fonts.paragraphP2SemiBold),
          //   ),
          // ),
          backgroundColor: colors.primary500,
          body: Stack(
            children: [
              Container(
                color: colors.shade100,
                child: WebViewWidget(controller: _controller),
              ),
              // if (isLoading)
              //   SpinKitThreeBounce(
              //     size: 44.r,
              //     itemBuilder: (BuildContext context, int index) {
              //       return DecoratedBox(
              //         decoration: BoxDecoration(
              //           color: colors.primary500,
              //           shape: BoxShape.circle,
              //         ),
              //       );
              //     },
              //   ),
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 4.h,
                left: 16.w,
                child: BlurBackButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
