class ApiPath {
  static String products() => 'products/';
  static String deliveryMethods() => 'deliveryMethods/';

  static String user(String uid) => 'users/$uid/';

  static String addToCart(String uid, String addToCart) =>
      'users/$uid/addToCart/$addToCart';

  static String deletFromCart(String uid, String addedToCartId) =>
      'users/$uid/addToCart/$addedToCartId';

  static String myCartProduct(String uid) => 'users/$uid/addToCart/';

  static String addToFav(String uid, String addToFav) =>
      'users/$uid/addToFav/$addToFav';
  static String myFavProduct(String uid) => 'users/$uid/addToFav/';
}

///users/13b8Bao57DfQrJX1xB7WzLm9bZa2/addToCart/2022-08-16T16:42:17.686427
