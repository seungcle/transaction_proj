package subak.example.subak.dao;



import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.TransactionDTO;

@Mapper
public interface TransactionDAO {
	void createTransaction(TransactionDTO dto);
}
