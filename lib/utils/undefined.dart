final undefined = Object();

T? undefCompare<T>(Object? value, T? defaultvalue) {
  if (identical(value, undefined)) {
    return null;
  }
  return value as T? ?? defaultvalue;
}