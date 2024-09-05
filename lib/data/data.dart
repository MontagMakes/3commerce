import 'package:e_commerce/models/model_product.dart';

class ProductData {
  List<ProductModel> products = [
    ProductModel(
      id: 0,
      title: 'sofa',
      description:
          'Experience unparalleled comfort and style with our premium sofa. Crafted with high-quality materials, this sofa offers a perfect blend of durability and elegance. The plush cushions provide exceptional support, making it ideal for lounging and relaxation. Its modern design complements any living space, while the sturdy frame ensures long-lasting use. Perfect for families, entertaining guests, or simply unwinding after a long day.',
      price: 100,
      rating: 5,
      imageUrl: 'assets/images/sofa.jpg',
      modelUrl: 'assets/models/model1/sofa.glb',
      category: 'category 1',
    ),
    ProductModel(
      id: 1,
      title: 'Wedding Ring',
      description:
          'Celebrate your special moments with our exquisite wedding ring. Crafted with precision and care, this ring features a timeless design that symbolizes eternal love and commitment. Made from high-quality materials, it offers a perfect blend of elegance and durability. The ring\'s intricate detailing and sparkling finish make it a standout piece for any occasion. Ideal for engagements, weddings, or anniversaries, this wedding ring is a beautiful testament to your everlasting bond.',
      price: 200,
      rating: 3.5,
      imageUrl: 'assets/images/ring.jpg',
      modelUrl: 'assets/models/model2/wedding_ring.glb',
      category: 'category 2',
    ),
    ProductModel(
      id: 2,
      title: 'IPhone X',
      description:
          'Discover the future of smartphones with the iPhone X. Featuring a stunning all-screen design, this device offers an immersive viewing experience with its Super Retina display. The advanced Face ID technology provides secure authentication, while the powerful A11 Bionic chip ensures smooth performance and efficiency. Capture breathtaking photos with the dual 12MP cameras, and enjoy the convenience of wireless charging. The iPhone X combines cutting-edge technology with sleek design, making it the perfect choice for those who demand the best.',
      price: 300,
      rating: 5,
      imageUrl: 'assets/images/phone.jpg',
      modelUrl: 'assets/models/model3/phone.glb',
      category: 'category 3',
    ),
    ProductModel(
      id: 3,
      title: 'keyboard',
      description:
          'Enhance your typing experience with our premium keyboard. Designed for both comfort and efficiency, this keyboard features responsive keys that provide a satisfying tactile feedback with every press. Its sleek and modern design fits seamlessly into any workspace, while the durable construction ensures long-lasting performance. Whether you\'re working, gaming, or simply browsing, this keyboard offers the perfect blend of functionality and style. Ideal for professionals and enthusiasts alike, it\'s a must-have accessory for your computer setup.',
      price: 400,
      rating: 4,
      imageUrl: 'assets/images/keyboard.jpg',
      modelUrl: 'assets/models/model4/keyboard.glb',
      category: 'category 3',
    ),
    ProductModel(
      id: 4,
      title: 'FootBall',
      description:
          'Get ready for the game with our high-quality football. Designed for both durability and performance, this football is perfect for players of all levels. Its robust construction ensures it can withstand intense play, while the textured surface provides excellent grip and control. Whether you\'re practicing your skills or playing in a competitive match, this football delivers consistent performance and reliability. Ideal for outdoor and indoor play, it\'s a must-have for any football enthusiast.',
      price: 500,
      rating: 2,
      imageUrl: 'assets/images/football.jpg',
      modelUrl: 'assets/models/model5/football.glb',
      category: 'category 5',
    ),
    ProductModel(
      id: 5,
      title: 'Armor and Helmet',
      description: ''' Armor Description:

Our premium armor is designed for maximum durability and protection. Crafted with high-quality materials, it ensures excellent defense against various threats while maintaining comfort and flexibility. The armor features reinforced plating and a sleek design, making it both functional and stylish. Ideal for adventurers and warriors who demand the best in protection.

Helmet Description:

This top-of-the-line helmet offers superior protection and comfort. Made from robust materials, it provides excellent head coverage without compromising on comfort. The helmet is designed with advanced ventilation systems to keep you cool during intense situations. Its adjustable fit ensures it stays securely in place, making it perfect for both combat and everyday use.''',
      price: 500,
      rating: 2,
      imageUrl: 'assets/images/armorAndHelmet.jpg',
      modelUrl: 'assets/models/model6/armorAndHelmet.glb',
      category: 'category 5',
    ),
    ProductModel(
      id: 5,
      title: 'Umbrella',
      description: '''Umbrella Description:

Stay dry and stylish with this high-quality umbrella. Crafted from durable materials, it offers excellent protection against rain and wind. The umbrella features a sturdy frame and a comfortable handle for easy carrying. Its compact design makes it convenient to store and carry, perfect for both everyday use and unexpected downpours. Whether you're heading to work or out for a walk, this umbrella ensures you stay dry and comfortable.''',
      price: 100,
      rating: 3,
      imageUrl: 'assets/images/umbrella.jpg',
      modelUrl: 'assets/models/model7/umbrella.glb',
      category: 'category 5',
    ),
  ];
}
