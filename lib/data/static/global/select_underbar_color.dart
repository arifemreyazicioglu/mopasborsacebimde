selectUnderBarInk(context, route) {
  int pageIndex = 0;
  switch (route) {
    case "/piyasalar":
      pageIndex = 0;
      break;
    case "/alarmlar":
      pageIndex = 1;
      break;
    case "/usdtprofit":
      pageIndex = 2;
      break;
  }

  return pageIndex;
}
