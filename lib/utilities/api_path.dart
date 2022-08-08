class ApiPath {
  static String products() => 'products/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String addToCart) =>
      'users/$uid/addToCart/$addToCart';
  static String deletFromCart(String uid, String addToCart) =>
      'users/$uid/addToCart/$addToCart';
  static String myCartProduct(String uid) => 'users/$uid/addToCart/';
}
