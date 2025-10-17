class WebviewConfig {
  WebviewConfig._();

  static const List<String> allowedDomains = [
    'https://flutter.dev',
    'https://www.google.com',
    'https://www.facebook.com',
  ];

  static bool isAllowedDomain(String url) {
    try {
      final uri = Uri.parse(url);
      final host = uri.host.toLowerCase();
      return allowedDomains.any((domain) => host.contains(domain));
    } catch (e) {
      return false;
    }
  }
}
