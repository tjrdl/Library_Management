package com.lmpjt.pilotpjt.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lmpjt.pilotpjt.Service.BoardCommentService;
import com.lmpjt.pilotpjt.Service.BoardService;
import com.lmpjt.pilotpjt.dto.BoardCommentDTO;
import com.lmpjt.pilotpjt.dto.BoardDTO;
import com.lmpjt.pilotpjt.dto.UserDTO;

@Controller
public class BoardController {
	@Autowired
	private BoardService service;

	@Autowired
	private BoardCommentService bcService;

	@RequestMapping("/board_view")
	public String boardView(Model model) {
		ArrayList<BoardDTO> list = service.boardView();
		model.addAttribute("boardList", list);

		return "board_view";
	}

	@RequestMapping("/board_write_ok")
	public String boardViewWrite(@RequestParam HashMap<String, String> param) {

		service.boardWrite(param);

		return "board_view";
	}

	@RequestMapping("/delete_post")
	public String boardViewDelete(@RequestParam HashMap<String, String> param) {
		service.boardDelete(param);

		return "board_view";
	}

	@RequestMapping("/board_update_ok")
	public String boardViewUpdate(@RequestParam HashMap<String, String> param) {
		service.boardModify(param);
		return "board_view";
	}

	@RequestMapping("/board_update")
	public String boardViewUpdate(@RequestParam HashMap<String, String> param, Model model) {
		BoardDTO dto = service.boardDetailView(param);
		model.addAttribute("board", dto);
		return "board_update";
	}

	@RequestMapping("/board_detail_view")
	public String boardViewDetail(@RequestParam HashMap<String, String> param, Model model) {
		BoardDTO dto = service.boardDetailView(param);
		ArrayList<BoardCommentDTO> commentList = bcService.bcView(param);

		model.addAttribute("board", dto);
		model.addAttribute("commentList", commentList);
		return "board_detail";
	}

	@RequestMapping("/boardLikes")
	public ResponseEntity<String> boardLikes(@RequestParam HashMap<String, String> param, HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("loginUser");
		if (user == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("�α����ʿ�");
		}
		int boardNumber = Integer.parseInt(param.get("boardNumber"));
		int userNumber = user.getUserNumber();
		param.put("userNumber", String.valueOf(userNumber));

		if (service.boardHasLiked(param)) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("�̹� ��õ ����");
		}
		try {
			service.boardAddLike(param);
			return ResponseEntity.ok("��õ �Ϸ�");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("���� ���� �߻�");
		}
	}

	@RequestMapping("/comment_write_ok")
	public String commentWriteOk(@RequestParam HashMap<String, String> param) {
		String boardNumber = param.get("boardNumber");
		if (param.get("commentContent") == "") {
			return "redirect:/board_detail_view?boardNumber=" + boardNumber;
		}
		bcService.bcWrite(param);

		return "redirect:/board_detail_view?boardNumber=" + boardNumber;
	}
}
