class DiscountHelper {
  double getDiscountedPrice({
    required double itemPrice,
    required double discountInPercent,
    required int quantity,
  }) {
    var total =
        ((itemPrice) - ((discountInPercent / 100) * itemPrice)) * quantity;
    return total;
  }
}
