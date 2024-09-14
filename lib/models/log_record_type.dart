enum LogRecordType {
  $default('default'),
  httpRequest('httpRequest'),
  httpResponse('httpResponse'),
  route('route');

  final String key;
  const LogRecordType(this.key);
}
