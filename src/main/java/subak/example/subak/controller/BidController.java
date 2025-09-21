package subak.example.subak.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.domain.BidResponseVO;
import subak.example.subak.service.BidService;

@Controller
public class BidController {

	@Autowired
	private BidService bidService;
	
	@GetMapping("/bid/{itemId}")
	@ResponseBody
	public List<BidResponseVO> getBid(@PathVariable Long itemId){
		
		return bidService.getBidList(itemId);
	}
	
	@GetMapping("/bid/count/{itemId}")
	@ResponseBody
	public int getBidCount(@PathVariable Long itemId) {
		
		return bidService.getBidCount(itemId) - 1;
	}
}
