import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class ApiClientAdapter {
  // MARK: - Properties

  static final String _localProxyDirection = 'localhost:9090';
  static final bool _localProxyEnabled = false;

  // MARK: - Public Methods

  /// [https://docs.proxyman.com/debug-devices/flutter#id-1.3-dio]
  static HttpClientAdapter create() {
    // Fallback
    if (!kDebugMode || !_localProxyEnabled) return IOHttpClientAdapter();

    // Option for visualize network traffic using proxies like 'proxyman' or 'charles'
    return IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        client.findProxy = (uri) => 'PROXY $_localProxyDirection';
        client.badCertificateCallback = (_, _, _) => true;

        return client;
      },
      validateCertificate: (_, _, _) => true,
    );
  }
}
