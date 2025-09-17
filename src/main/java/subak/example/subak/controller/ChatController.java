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
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	// 그룹채팅 웹소켓 연결
	@MessageMapping("/chat/{roomId}")
    @SendTo("/topic/chat/{roomId}")
	public ChatResponseDTO sendChatMessage(ChatRequestDTO requestDTO, @DestinationVariable Long roomId) {

		if(requestDTO.getNickname() == null)
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
		
        return chatService.processMessage(roomId, requestDTO);
    }
	
	// 그룹채팅 이전 채팅 가져오기
	@GetMapping("/{roomId}/chat")
	@ResponseBody
	public List<ChatResponseDTO> getAllChats(@PathVariable Long roomId){
		
		List<ChatResponseDTO> list = chatService.getAllChats(roomId);
		
		return list;
	}
	
	// 1:1 채팅방 만들기
}
