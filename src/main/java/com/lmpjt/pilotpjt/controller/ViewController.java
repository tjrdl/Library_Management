package com.lmpjt.pilotpjt.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lmpjt.pilotpjt.Service.BookService;
import com.lmpjt.pilotpjt.Service.UtilService;
import com.lmpjt.pilotpjt.dto.BookDTO;
import com.lmpjt.pilotpjt.dto.UserDTO;

@Controller
public class ViewController {
	@Autowired
	private UtilService utilService;
	@Autowired
	private BookService bookSerivce;
	
	@RequestMapping("/main")
	public String getMainBookInfo(Model model) {
		model.addAttribute("totalBooks", 102422+utilService.getTotalBooks());
		model.addAttribute("totalUsers", 21233+utilService.getTotalUsers());
		model.addAttribute("borrowedBooks", 4422+utilService.getBorrowedBooks());
		model.addAttribute("overdueBooks", 1324+utilService.getOverdueBooks());
		model.addAttribute("bookList", bookSerivce.mainBookInfo());
		
//		ArrayList<BookDTO> bookList = bookSerivce.mainBookInfo();
//	    for (BookDTO book : bookList) {
//	        System.out.println("asdf : " + book.getBookTitle() + " / ����: " + book.getBookCount());
//	    }
		return "main";
	}

	@RequestMapping("/search_book_view")
	public String searchBookView() {
		return "book_search";
	}

	@RequestMapping("/loginView")
	public String loginPage() {
		return "login";
	}
	@RequestMapping("/mypage")
	public String mypage() {
		return "mypage";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
	}

	@RequestMapping("/joinView")
	public String join() {
		return "join";
	}
	
	// board
	@RequestMapping("/board_write")
	public String boardViewWrite() {
		return "board_write";
	}
}
