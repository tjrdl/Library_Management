package com.lmpjt.pilotpjt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lmpjt.pilotpjt.Service.BookService;
import com.lmpjt.pilotpjt.dao.BookDAO;
import com.lmpjt.pilotpjt.dto.BookDTO;
import com.lmpjt.pilotpjt.dto.UserDTO;

@Controller
public class BookController {
//	@Autowired
//	private SqlSession sqlSession;

	@Autowired
	private BookService service;
	
	@RequestMapping("/book_insert")
	public String insertBook(HttpServletRequest request,@RequestParam HashMap<String, String> param) {
//		BookDAO dao = sqlSession.getMapper(BookDAO.class);
		service.insertBook(param);

		
//		dao.insertBook(book, loginUser.getUserAdmin());
//		dao.insertBook(param);
		return "admin_view";
	}

	@RequestMapping("/update_book")
	public String updateBookView(BookDTO book) {
		return "book_update";
	}

	@RequestMapping("/search_book")
	public String searchBook(String title) {
		return "book_search";
	}
}
