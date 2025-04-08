package com.lmpjt.pilotpjt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.ModelAndView;

import com.lmpjt.pilotpjt.Service.UserService;
import com.lmpjt.pilotpjt.dao.UserDAO;
import com.lmpjt.pilotpjt.dto.UserDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
//	@Autowired
//	private SqlSession sqlSession;

	@Autowired
	private UserService service;

	@RequestMapping("/login")
	public String login(HttpServletRequest request, @RequestParam HashMap<String, String> param) {
//		UserDAO dao = sqlSession.getMapper(UserDAO.class);

		ArrayList<UserDTO> dtos = service.userLogin(param);

		UserDTO dto = service.getUserInfo(param);

		if (dtos.isEmpty()) {
			return "redirect:loginView";
		} else {
			if (param.get("userPw").equals(dtos.get(0).getUserPw())) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", dto);
				return "redirect:main";
			}
			return "redirect:loginView";
		}
	}

	@RequestMapping("/join")
	public ResponseEntity<String> join(HttpServletRequest request, @RequestParam HashMap<String, String> param) {

		if (service.checkId(param) != null) {
			
		} else {
			int re = service.userJoin(param);
			if (re == 1) {
//				return "redirect:loginView";
				return ResponseEntity.ok("available");
			}
		}
		return ResponseEntity.status(HttpStatus.CONFLICT).body("duplicate");
	}

	@RequestMapping("/user_info")
	public String getUserInfo(int u_number) {
		return "user_info";
	}

	@RequestMapping("/user_update_view")
	public String updateUserInfo(UserDTO user) {
		return "user_update";
	}
}
