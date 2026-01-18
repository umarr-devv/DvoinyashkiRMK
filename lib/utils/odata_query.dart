String buildODataQuery(Map<String, dynamic> params) {
  return '?${params.entries.map((e) {
    final key = Uri.encodeComponent(e.key);
    final value = Uri.encodeComponent(e.value).replaceAll('+', '%20'); // на всякий случай
    return '$key=$value';
  }).join('&')}';
}
