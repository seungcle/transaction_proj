package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.FavoriteDTO;

@Mapper
public interface FavoriteDAO {

	int checkFavoriteExists(FavoriteDTO dto);

	void insertFavorite(FavoriteDTO dto);

	void deleteFavorite(FavoriteDTO dto);

}
