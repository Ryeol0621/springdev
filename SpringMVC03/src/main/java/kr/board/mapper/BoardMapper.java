package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.BoardDTO;

@Mapper
public interface BoardMapper {
	public List<BoardDTO> getList();
	public void boardInsert(BoardDTO dto);
	public BoardDTO boardContent(int idx);
	public void boardDelete(int idx);
	public void boardUpdate(BoardDTO dto);
	
	@Update("update myboard set count=count+1 where idx = #{idx}")
	public void boardCount(int idx);
	
}
