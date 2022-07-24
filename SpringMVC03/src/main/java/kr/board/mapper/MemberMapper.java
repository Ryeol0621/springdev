package kr.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.board.entity.MemberDTO;

@Mapper
public interface MemberMapper {
	public MemberDTO registerCheck(String id);
	public int register(MemberDTO dto);
	public int memberUpdate(MemberDTO dto);
	public MemberDTO memberLoging(MemberDTO dto);
	public MemberDTO getMember(String memID);
	public void memberProfileUpdate(MemberDTO dto);
}
