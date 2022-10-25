class NetworkLink {
  late String link;

  NetworkLink({required String link}) {
    if (link != '') {
      this.link = 'https://www.subrate.app/$link';
    } else {
      this.link = '';
    }
  }
}
