class Product {
  final int id; // 번호
  final String imageFilename; // 이미지 파일명
  final String name; // 상품명
  final String description; // 상품 소개
  final String seller; // 판매자
  final int priceKrw; // 가격
  final String address; // 주소
  final int likes; // 좋아요
  final int chats; // 채팅

  const Product({
    required this.id,
    required this.imageFilename,
    required this.name,
    required this.description,
    required this.seller,
    required this.priceKrw,
    required this.address,
    required this.likes,
    required this.chats,
  });
}
