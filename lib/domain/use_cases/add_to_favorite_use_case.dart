import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/product_repo.dart';

class AddToFavoriteUseCase{
final ProductRepo repo;
AddToFavoriteUseCase({required this.repo});

Future<Either<String, String>> call(int id)=> repo.addToFavorite(id);
}