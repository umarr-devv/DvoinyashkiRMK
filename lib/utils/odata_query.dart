String buildODataQuery(Map<String, dynamic> params) {
  return '?${params.entries.map((e) {
    final key = Uri.encodeComponent(e.key);
    final value = Uri.encodeComponent(e.value).replaceAll('+', '%20'); // на всякий случай
    return '$key=$value';
  }).join('&')}';
}

String to1CODataDateTime(DateTime dt) {
  final iso = dt.toIso8601String();
  final cleaned = iso.split('.').first.replaceAll('Z', '');

  return "datetime'$cleaned'";
}