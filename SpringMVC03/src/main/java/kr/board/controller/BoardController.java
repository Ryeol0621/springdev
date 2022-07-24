package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.BoardDTO;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
//	@Autowired
//	BoardMapper boardMapper;
	
	@RequestMapping("/boardMain.do")
	public String main() {
		return "/board/main";
	}
	
//	@RequestMapping("/boardList.do")
//	@ResponseBody
//	public List<BoardDTO> boardList() {
//		List<BoardDTO> list =  boardMapper.getList();
//		return list;
//	}
//	
//	@PostMapping("/boardInsert.do")
//	@ResponseBody
//	public void boardInsert(BoardDTO dto) {
//		boardMapper.boardInsert(dto);
//	}
//	
//	@GetMapping("/boardDelete.do")
//	@ResponseBody
//	public void boardDelete(@RequestParam("idx") int idx) {
//		boardMapper.boardDelete(idx);
//	}
//	
//	@PostMapping("/boardUpdate.do")
//	@ResponseBody
//	public void boardUpdate(BoardDTO dto) {
//		boardMapper.boardUpdate(dto);
//	}
//	
//	@RequestMapping("/boardContent.do")
//	@ResponseBody
//	public BoardDTO boardContent(int idx) {
//		BoardDTO dto = boardMapper.boardContent(idx);
//		return dto;   // dto -> JSON
//	}
//	
//	@RequestMapping("/boardCount.do")
//	@ResponseBody
//	public BoardDTO boardCount(int idx) {
//		boardMapper.boardCount(idx);
//		BoardDTO dto = boardMapper.boardContent(idx);
//		return dto;   // dto -> JSON
//	}
}
