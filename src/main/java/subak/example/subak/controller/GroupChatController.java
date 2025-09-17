package subak.example.subak.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatResponseDTO;
import subak.example.subak.service.ChatService;

@Controller
public class GroupChatController {

	@Autowired
	private ChatService chatService;
	
	@MessageMapping("/chat/{roomId}")
    @SendTo("/topic/chat/{roomId}")
	public ChatResponseDTO sendChatMessage(ChatRequestDTO requestDTO, @DestinationVariable Long roomId) {

		if(requestDTO.getNickname() == null)
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
		
        return chatService.processMessage(roomId, requestDTO);
    }
	
	@GetMapping("/{roomId}/chat")
	@ResponseBody
	public List<ChatResponseDTO> getAllChats(@PathVariable Long roomId){
		
		List<ChatResponseDTO> list = chatService.getAllChats(roomId);
		
		return list;
	}
}
