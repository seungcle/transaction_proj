package subak.example.subak.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import subak.example.subak.domain.AddressDTO;

@Mapper
public interface AddressDAO {
    
	List<AddressDTO> findByUser(AddressDTO dto);
    
    void insert(AddressDTO address);
    
    void update(AddressDTO address);
    
    void delete(Long id);
    
    void resetDefault(@Param("userId") Long userId);
}
