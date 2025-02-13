import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewLogin extends StatefulWidget {
  const CustomWebViewLogin({
    super.key,
  });

  @override
  State<CustomWebViewLogin> createState() => _CustomWebViewLoginState();
}

class _CustomWebViewLoginState extends State<CustomWebViewLogin>
    with WidgetsBindingObserver {
  late WebViewController _controller;
  bool isLoading = true;
  String? loginUrl;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> loadUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("user_id");

    final String dynamicUrl =
        await ApiPath.getWebViewEndpoint(userId: userId.toString());

    setState(() {
      loginUrl = dynamicUrl;
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(false)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                isLoading = false;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse(loginUrl!));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.h),
        child: const CustomAppBar(
          appBarName: "Web Login",
        ),
      ),
      body: loginUrl == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (isLoading) const CustomLoading(),
              ],
            ),
    );
  }
}
