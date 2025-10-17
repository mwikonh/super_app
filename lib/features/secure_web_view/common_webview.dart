import 'package:flutter/material.dart';
import 'package:web_app/features/home/models/webview_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewScreen extends StatefulWidget {
  const CommonWebviewScreen({super.key, required this.url});
  final String url;

  @override
  State<CommonWebviewScreen> createState() => _CommonWebviewScreenState();
}

class _CommonWebviewScreenState extends State<CommonWebviewScreen> {
  WebViewController? webViewController;
  bool isLoading = true;
  double loadingProgress = 0.0;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(true)
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loadingProgress = progress.toDouble();
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              errorMessage = null;
            });
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
              errorMessage =
                  'Connection Error\n${error.description}\n\nError Code: ${error.errorCode}\nError Type: ${error.errorType}';
            });
          },
          onNavigationRequest: (NavigationRequest request) {

            print('Navigating to: ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      );

    if (WebviewConfig.isAllowedDomain(widget.url)) {
      
      webViewController?.loadRequest(Uri.parse(widget.url));
    } else {
      setState(() {
        errorMessage = 'Unauthorized domain';
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          isLoading ? 'Loading... ${loadingProgress.toInt()}%' : 'Web View',
        ),
      ),
      body: errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          errorMessage = null;
                          isLoading = true;
                        });
                        webViewController?.loadRequest(Uri.parse(widget.url));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                WebViewWidget(controller: webViewController!),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress / 100,
                    ),
                  ),
              ],
            ),
    );
  }
}
