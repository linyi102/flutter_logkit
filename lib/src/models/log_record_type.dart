enum LogRecordType {
  $default('default'),
  httpRequest('http-request'),
  httpResponse('http-response'),
  httpError('http-error'),
  route('route'),
  unhandledError('unhandled-error');

  final String key;
  const LogRecordType(this.key);
}
