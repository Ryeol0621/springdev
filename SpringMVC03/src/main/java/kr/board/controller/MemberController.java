package kr.board.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.MemberDTO;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired
	MemberMapper memberMapper;
	
	@RequestMapping("/memberJoin.do")
	public String memberJoin() {
		return "/member/join";
	}
	
	@RequestMapping("/registerCheck.do")
	@ResponseBody
	public int registerCheck(@RequestParam("id") String id) {
		System.err.println("id: "+id);
		MemberDTO dto = memberMapper.registerCheck(id);
		if(dto != null || id.equals("") ) {
			return 0;
		}else {
			return 1;
		}
	}
	
	@RequestMapping("/memberReg.do")
	public String memberReg(MemberDTO dto, RedirectAttributes rttr, HttpSession session
			,String memPassword1, String memPassword2) {
		
		if(dto.getMemID()==null || dto.getMemID().equals("")
		   ||dto.getMemName()==null || dto.getMemName().equals("")
		   ||dto.getMemAge()==0 
		   ||dto.getMemEmail()==null || dto.getMemEmail().equals("")
		   ||memPassword1==null || memPassword1.equals("")
		   ||memPassword2==null || memPassword2.equals("")) {
			
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memberJoin.do";	
		}
		
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memberJoin.do";
		}
		dto.setMemProfile("");
		
		int result = memberMapper.register(dto);
		
		if(result==1) {
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", "회원가입 성공.");
			session.setAttribute("dto", dto);
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "회원가입 실패.");
			return "redirect:/memberJoin.do";
		}
	}
	
	@RequestMapping("memberLogout.do")
	public String memberLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("memberLoginForm.do")
	public String memberLoginForm() {
		return "member/memberLoginForm";
	}
	
	@RequestMapping("memberLoging.do")
	public String memberLoging(MemberDTO dto, RedirectAttributes rttr, HttpSession session) {
		if(dto.getMemID() == null || dto.getMemID().equals("")
		  ||dto.getMemPassword() == null || dto.getMemPassword().equals("")	) {
			rttr.addFlashAttribute("msgType","실패 메시지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memberLoginForm.do";
		}
		MemberDTO m = memberMapper.memberLoging(dto);
		if(m != null) {
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", "로그인 성공.");
			session.setAttribute("dto", m);
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "로그인 실패.");
			return "redirect:/memberLoginForm.do";
		}
	}
	
	@RequestMapping("memberUpdateForm.do")
	public String memberUpdateForm() {
		return "member/memberUpdateForm";
	}
	
	@RequestMapping("memberUpdate.do")
	public String memberUpdate(MemberDTO m, RedirectAttributes rttr, HttpSession session,
			String memPassword1, String memPassword2, HttpServletRequest req) {
		
		String memID = req.getParameter("memID");
		String memName = req.getParameter("memName");
		
		System.err.println("memID: "+memID);
		System.err.println("memName: "+memName);
		
		if(m.getMemID()==null || m.getMemID().equals("")
		   ||m.getMemName()==null || m.getMemName().equals("")
		   ||m.getMemAge()==0 
		   ||m.getMemEmail()==null || m.getMemEmail().equals("")
		   ||memPassword1==null || memPassword1.equals("")
		   ||memPassword2==null || memPassword2.equals("")) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memberUpdateForm.do";	
		}
		
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memberUpdateForm.do";
		}
		m.setMemProfile("");
		
		int result = memberMapper.memberUpdate(m);
		
		if(result==1) {
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", "수정 성공.");
			session.setAttribute("dto", m);
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "수정 실패.");
			return "redirect:/memberUpdateForm.do";
		}
	}
	
	@RequestMapping("memberImgForm.do")
	public String memberImgForm() {
		return "member/memberImgForm";
	}
	
	@RequestMapping("memberImgUpload.do")
	public String memberImgUpload(HttpServletRequest req, RedirectAttributes rttr, HttpSession session) {
		MultipartRequest mr = null;
		int fileMaxSize = 10*1024*1024;
		String savePath = req.getRealPath("resources/upload");
		
		try {
			mr = new MultipartRequest(req, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "파일크기는 10M를 넘을 수 없습니다.");
			return "redirect:/memberImgForm.do";
		}
		
		String memID = mr.getParameter("memID");
		String newProfile = "";
		File file = mr.getFile("memProfile");
		
		if(file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
			ext = ext.toUpperCase();
			
			if(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
				String oldProfile = memberMapper.getMember(memID).getMemProfile();
				File oldFile = new File(savePath+"/"+oldProfile);
				if(oldFile.exists()) {
					oldFile.delete();
				}
				newProfile = file.getName();
			}else {
				if(file.exists()) {
					file.delete();
				}
				rttr.addFlashAttribute("msgType", "실패 메시지");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 가능합니다.");
				return "redirect:/memberImgForm.do";
			}
		}
		
		MemberDTO member = new MemberDTO();
		member.setMemProfile(newProfile);
		member.setMemID(memID);
		
		memberMapper.memberProfileUpdate(member);
		
		MemberDTO m = memberMapper.getMember(memID);
		session.setAttribute("dto", m);
		
		rttr.addFlashAttribute("msgType", "성공 메시지");
		rttr.addFlashAttribute("msg", "이미지 파일만 업로드 성공.");
		
		return "redirect:/";
	}
}
