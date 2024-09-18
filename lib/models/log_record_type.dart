enum LogRecordType {
  $default('default'),
  httpRequest('http-request'),
  httpResponse('http-response'),
  route('route');

  final String key;
  const LogRecordType(this.key);
}
