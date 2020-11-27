Uri formatUri(String path, Map<String, String> query) {
  return Uri.https('yts.mx', 'api/v2/' + path, query);
}
