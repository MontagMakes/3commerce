// import 'package:dio/dio.dart';
// import 'package:e_commerce/models/model_product.dart';

// class ApiManager {
//   Future<List<ProductModel>> getProducts() async {
//     Dio dio = Dio();
//     List<ProductModel> result = [];

//     try {
//       final response = await dio.get('http://192.168.100.254:5000/api/products', options: Options(
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       ));
//       if (response.statusCode == 200) {
//         for (var product in response.data) {
//           result.add(ProductModel.fromMap(product));
//         }
//         return result;
//         // result = data.map((e) => ProductModel.fromMap(e)).toList();
//       }
//     } catch (error) {
//       print(error);
//     }
//     return result = [
//       ProductModel(
//         id: 1,
//         title: 'Product 1',
//         description: 'Description 1',
//         price: 100,
//         imageUrl: 'https://via.placeholder.com/150',
//         modelUrl: 'https://via.placeholder.com/150',
//         category: 'Category 1',
//         rating: 4.5,
//       )
//     ];
//   }
// }
