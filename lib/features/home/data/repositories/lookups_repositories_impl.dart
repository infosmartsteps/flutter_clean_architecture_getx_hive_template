import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ksa_real_estates/features/home/data/models/lookups_model.dart';
import 'package:ksa_real_estates/features/home/domain/entities/lookups_entity.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/cities_parameters.dart';
import 'package:ksa_real_estates/features/home/domain/repositories/i_lookups_repositories.dart';
import '../../../../core/network/handle_dio_error.dart';
import '../../../../core/network/models/response_model.dart';
import '../datasources/i_lookups_remote_data_source.dart';

class LookupsRepositoriesImpl extends ILookupsRepositories {
  final ILookupsRemoteDataSource lookupsRemoteDataSource;

  LookupsRepositoriesImpl({required this.lookupsRemoteDataSource});

  @override
  Future<Either<String, List<LookupsEntity>>> getCities(
      CitiesParameters params)
  async {
    try {
      final response = await lookupsRemoteDataSource.getCities(params);
      if (!response.success) {
        return Left(response.message ?? "getCities failed");
      }
      final List<Map<String, String>> cities = [
        {"id": "1", "value": "الرياض"},
        {"id": "2", "value": "جدة"},
        {"id": "3", "value": "مكة"},
        {"id": "4", "value": "المدينة المنورة"},
        {"id": "5", "value": "الدمام"},
        {"id": "6", "value": "الخبر"},
        {"id": "7", "value": "الطائف"},
        {"id": "8", "value": "بريدة"},
        {"id": "9", "value": "تبوك"},
        {"id": "10", "value": "أبها"},
      ];
      final List<LookupsModel> models = LookupsModel.fromJsonList(cities);
      final List<LookupsEntity> entities = LookupsEntity.fromModelList(models);
      return Right(entities);
    } on DioException catch (e) {
      final apiResponse = handleDioError(e);
      return Left(apiResponse.message ?? "Network error");
    } on ApiResponse catch (e) {
      return Left(e.message ?? "API error");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<LookupsEntity>>> getBusinessSectors() async {
    try {
      final response = await lookupsRemoteDataSource.getBusinessSectors();
      if (!response.success) {
        return Left(response.message ?? "getBusinessSectors failed");
      }
      final List<Map<String, String>> sectors = [
        {"id": "1", "value": "تجزئة"},
        {"id": "2", "value": "تصنيع"},
        {"id": "3", "value": "رعاية صحية"},
        {"id": "4", "value": "تعليم"},
        {"id": "5", "value": "تكنولوجيا"},
        {"id": "6", "value": "تمويل"},
        {"id": "7", "value": "ضيافة"},
        {"id": "8", "value": "بناء"},
        {"id": "9", "value": "نقل"},
        {"id": "10", "value": "أخرى"},
      ];
      final List<LookupsModel> models = LookupsModel.fromJsonList(sectors);
      final List<LookupsEntity> entities = LookupsEntity.fromModelList(models);
      return Right(entities);
    } on DioException catch (e) {
      final apiResponse = handleDioError(e);
      return Left(apiResponse.message ?? "Network error");
    } on ApiResponse catch (e) {
      return Left(e.message ?? "API error");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<LookupsEntity>>> getInformationSources() async {
    try {
      final response = await lookupsRemoteDataSource.getBusinessSectors();
      if (!response.success) {
        return Left(response.message ?? "getInformationSources failed");
      }
      final List<Map<String, String>> sources = [
        {"id": "1", "value": "الإنترنت"},
        {"id": "2", "value": "إعلان"},
        {"id": "3", "value": "معرض"},
        {"id": "4", "value": "توصية"},
        {"id": "5", "value": "وسائل التواصل الاجتماعي"},
        {"id": "6", "value": "أخرى"},
      ];
      final List<LookupsModel> models = LookupsModel.fromJsonList(sources);
      final List<LookupsEntity> entities = LookupsEntity.fromModelList(models);
      return Right(entities);
    } on DioException catch (e) {
      final apiResponse = handleDioError(e);
      return Left(apiResponse.message ?? "Network error");
    } on ApiResponse catch (e) {
      return Left(e.message ?? "API error");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}
