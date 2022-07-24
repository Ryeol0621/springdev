package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.BoardDTO;
import kr.board.mapper.BoardMapper;

@RequestMapping("/board")
@RestController
public class BoardRestController {

	@Autowired
	BoardMapper boardMapper;
	
	@GetMapping("/all")
	public List<BoardDTO> boardList() {
		List<BoardDTO> list =  boardMapper.getList();
		return list;
	}
	
	@PostMapping("/new")
	public void boardInsert(BoardDTO dto) {
		boardMapper.boardInsert(dto);
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) {
		boardMapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody BoardDTO dto) {
		boardMapper.boardUpdate(dto);
	}
	
	@GetMapping("/{idx}")
	public BoardDTO boardContent(@PathVariable("idx") int idx) {
		BoardDTO dto = boardMapper.boardContent(idx);
		return dto;   // dto -> JSON
	}
	
	@PutMapping("/count/{idx}")
	public BoardDTO boardCount(@PathVariable("idx") int idx) {
		boardMapper.boardCount(idx);
		BoardDTO dto = boardMapper.boardContent(idx);
		return dto;   // dto -> JSON
	}
}
