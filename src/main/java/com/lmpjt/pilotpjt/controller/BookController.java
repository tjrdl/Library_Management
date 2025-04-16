package com.lmpjt.pilotpjt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.lmpjt.pilotpjt.Service.BookService;
import com.lmpjt.pilotpjt.Service.UtilService;
import com.lmpjt.pilotpjt.dao.BookDAO;
import com.lmpjt.pilotpjt.dto.BookDTO;
import com.lmpjt.pilotpjt.dto.BookRecordDTO;
import com.lmpjt.pilotpjt.dto.UserDTO;

@Controller
public class BookController {

	@Autowired
	private BookService service;
	@Autowired
	private UtilService utilService;

	@RequestMapping("/book_insert")
	public String insertBook(HttpServletRequest request, @RequestParam HashMap<String, String> param) {
		service.insertBook(param);

		return "admin_view";
	}

	@RequestMapping("/update_book")
	   public String updateBookView(@RequestParam HashMap<String, String> param, BookDTO book, Model model, HttpServletRequest request) {
	      UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");

	      if (user == null || user.getUserAdmin() != 1) {
	         return "main";
	      }
	      book = service.bookDetailInfo(param);
	      model.addAttribute("book", book);
	      return "book_update";
	   }

	@RequestMapping("/update_book_ok")
	public String updateBook(@RequestParam HashMap<String, String> param) {
		service.updateBook(param);
		return "main";
	}

	@RequestMapping("/book_search_view")
	public String searchBookView(@RequestParam HashMap<String, String> param, Model model) {
		List<BookDTO> list = service.searchBookInfo(param);
		model.addAttribute("bookList", list);
		return "book_search";
	}

	@RequestMapping("/book_detail")
	public String bookDetail(@RequestParam HashMap<String, String> param, Model model) {
		BookDTO dto = service.bookDetailInfo(param);
		model.addAttribute("book", dto);
		return "book_detail";
	}

	@RequestMapping("/book_delete")
	   public ResponseEntity<String> bookDelete(@RequestParam HashMap<String, String> param, HttpServletRequest request) {
	      UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");

	      if (user == null || user.getUserAdmin() != 1) {
	         return ResponseEntity.status(HttpStatus.CONFLICT).body("noUser");
	      }

	      param.put("userNumber", String.valueOf(user.getUserNumber()));

	      try {
	         service.deleteBook(param);
	         return ResponseEntity.ok("successDelete");
	      } catch (Exception e) {
	         e.printStackTrace();
	         
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("unexpectedServerError");
	      }
	   }
	
	@RequestMapping("/book_borrow")
	public ResponseEntity<String> bookBorrow(@RequestParam HashMap<String, String> param, HttpServletRequest request) {
		UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");

		if (user == null) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("noUser");
		}

		param.put("userNumber", String.valueOf(user.getUserNumber()));

		try {
			service.bookBorrow(param);
			return ResponseEntity.ok("successBorrow");
		} catch (Exception e) {
			e.printStackTrace();
			String msg = (e.getMessage() != null) ? e.getMessage() : "";

			if (msg.contains("ORA-20001")) {
				return ResponseEntity.status(HttpStatus.CONFLICT).body("userInfoError");
			} else if (msg.contains("ORA-20002")) {
				return ResponseEntity.status(HttpStatus.CONFLICT).body("userCanBorrowOver");
			} else if (msg.contains("ORA-20004")) {
				return ResponseEntity.status(HttpStatus.CONFLICT).body("alreadyBorrow");
			}

			// ❗ 조건 다 안 맞을 때를 위한 기본 응답
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("unexpectedServerError");
		}
	}

	@RequestMapping("/book_return")
	public String bookReturn(@RequestParam HashMap<String, String> param, HttpServletRequest request, Model model) {
		UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");
		if (user == null) {
			return "redirect:main"; // 로그인 안 되어 있으면 메인으로 이동
		}
		int userNumber = user.getUserNumber();

		param.put("userNumber", String.valueOf(userNumber)); // 사용자 번호를 param에 추가
		try {
			service.bookReturn(param);
		} catch (Exception e) {
			e.printStackTrace(); // 개발 시 에러 확인용
			// db에서 발생한 사용자 정의 예외 처리

			String message = e.getMessage();
			if (message != null && message.contains("ORA-20004")) {
				model.addAttribute("return_errorMsg", "대출 정보가 존재하지 않아 반납할 수 없습니다.");
			} else {
				model.addAttribute("return_errorMsg", "알 수 없는 오류: " + message);
			}
			return "mypage";
		}
		model.addAttribute("return_successMSG", "도서 반납이 성공적으로 완료되었습니다!");
		return "mypage";
	}
	
	@RequestMapping("/user_book_recommend")
	public String bookRecomm() {
		return "user_book_recommend";
	}
	@RequestMapping("/user_book_borrowing")
	public String bookBorrow(HttpServletRequest request, @RequestParam HashMap<String, String> param, Model model) {
		UserDTO dto = (UserDTO) request.getSession().getAttribute("loginUser");

		param.put("userNumber", String.valueOf(dto.getUserNumber()));
		ArrayList<BookRecordDTO> bookBorrowedList = service.bookBorrowed(param);
		ArrayList<BookRecordDTO> bookBorrowList = service.bookRecord(param);
		int userBorrowedBooks = utilService.getUserBorrowed(param);
		int userRecord = utilService.getUserRecord(param);
		int userOver = utilService.getUserOver(param);
		int userRecordCount = utilService.getBookRecordCount(param);
		model.addAttribute("bookBorrowedList", bookBorrowedList);
		model.addAttribute("bookBorrowList", bookBorrowList);
		model.addAttribute("userBorrowedBooks", userBorrowedBooks);
		model.addAttribute("userRecord", userRecord);
		model.addAttribute("userOver", userOver);
		model.addAttribute("userRecordCount", userRecordCount);
		return "user_book_borrowing";
	}
}
