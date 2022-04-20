class NftModel{
  final String  userName;
  final String  nftName;
  final String  sellType;
  final String  nftImage;
  final String   buttonType;
  final  double  price;
  final String ? nftVideo;
  bool video;

  NftModel({required this.userName, required this.nftName, required this.sellType, required this.buttonType,
    required this.price,required this.nftImage,required this.video, this.nftVideo});
}
 List<NftModel> nftList=[
   NftModel(
     userName: "The Boss",
     price: 1.10,
     nftImage: "https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
     buttonType: "Buy now",
     sellType: "Fixed price",
     nftName: "The Boss ",
     video: false,
     ),
   NftModel(
     userName: "The Queen of Wideal",
     price: 1.2,
     nftImage: "https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
     buttonType: "Buy now",
     sellType: "Fixed price",
     nftName: "The master of DIY",
     video: false,
   ),
   NftModel(
       userName: "The best dealer",
       price: 1.1,
       nftImage: "https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
       buttonType: "Buy now",
       sellType: "Fixed price",
       nftName: "The best dealer",
       video: false,
   ),
   NftModel(
       userName: "The Tailoring Expert",
       price: 0.800,
       nftImage: "https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
       buttonType: "Buy now",
       sellType: "Fixed price",
       nftName: "The Tailoring Expert",
       video: false,
   ),
   NftModel(
       userName: "The beauty of WiDeal",
       price: 0.840,
       nftImage: "https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
       buttonType: "Buy now",
       sellType: "Fixed price",
       nftName: "The beauty of WiDeal",
       video: false,
   ),
   NftModel(
     userName: "The gardener artist",
     price: 0.800,
     nftImage: "https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
     buttonType: "Buy now",
     sellType: "Fixed price",
     nftName: "The gardner artist ",
     video: false,
   ),
 ];