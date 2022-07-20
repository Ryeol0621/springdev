package kr.board.entity;

import lombok.Data;

@Data
public class BoardDTO {

	private int idx;
	private int count;
	private String title;
	private String content;
	private String writer;
	private String indate;
	
}
