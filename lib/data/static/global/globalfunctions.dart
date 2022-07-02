class GlobalFunctions {
  static int getCurrentIndex(String pageName) {
    int pageIndex = 0;

    switch (pageName) {
      case "PortfoyScreenState":
        pageIndex = 0;
        break;
      case "PiyasalarScreenState":
        pageIndex = 1;
        break;
      case "WalletScreenState":
        pageIndex = 2;
    }
    return pageIndex;
  }
}
