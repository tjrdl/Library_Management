package com.lmpjt.pilotpjt.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lmpjt.pilotpjt.Service.AdminService;
import com.lmpjt.pilotpjt.Service.UtilService;
import com.lmpjt.pilotpjt.dto.NoticeDTO;

@Controller
public class AdminController {
	@Autowired
	private UtilService service;
	@Autowired
	private AdminService admin_service;

	@RequestMapping("/admin_view")
	public String adminView(Model model) {
		model.addAttribute("totalBooks", service.getTotalBooks());
		model.addAttribute("totalUsers", service.getTotalUsers());
		model.addAttribute("borrowedBooks", service.getBorrowedBooks());
		model.addAttribute("overdueBooks", service.getOverdueBooks());
		return "admin_view";
	}

	@RequestMapping("/admin_notice")
	public String adminNoti(Model model) {
		ArrayList<NoticeDTO> list = admin_service.NoticeView();
		for (NoticeDTO dto : list) {
			String content = dto.getNoticeContent();
			if (content != null && content.length() > 30) {
				dto.setNoticeContent(content.substring(0, 30) + "...");
			}
		}
		model.addAttribute("noticeList", list);

		int countImportant = 0;
		int countEvent = 0;
		int countInfo = 0;
		int countUpdate = 0;
		for (NoticeDTO dto : list) {
			switch (dto.getNoticeCategory()) {
			case "important":
				countImportant++;
				break;
			case "event":
				countEvent++;
				break;
			case "info":
				countInfo++;
				break;
			case "update":
				countUpdate++;
				break;
			}
		}
		int countAll = countImportant + countEvent + countUpdate;
		model.addAttribute("countAll", countAll);
		model.addAttribute("countImportant", countImportant);
		model.addAttribute("countEvent", countEvent);
		model.addAttribute("countInfo", countInfo);
		model.addAttribute("countUpdate", countUpdate);
		return "admin_notice";
	}

	@RequestMapping("/admin_notice_write")
	public String adminNoticeWrite() {
		return "admin_notice_write";
	}

	@RequestMapping("/admin_write_ok")
	public String adminNotiWrite(@RequestParam HashMap<String, String> param) {
		admin_service.NoticeWrite(param);
		return "admin_notice";

	}

	@RequestMapping("/admin_delete")
	public String adminNotiDelete(@RequestParam HashMap<String, String> param) {
		admin_service.NoticeDelete(param);
		return "redirect:admin_notice";

	}

	@RequestMapping("/admin_update")
	public String adminNotiUpdate(@RequestParam HashMap<String, String> param, Model model) {
		NoticeDTO dto = admin_service.NoticeDetailView(param);
		model.addAttribute("notice", dto);
		return "admin_notice_update";
	}

	@RequestMapping("/admin_update_ok")
	public String adminNotiUpdateOk(@RequestParam HashMap<String, String> param) {
		admin_service.NoticeModify(param);

		return "redirect:admin_notice";
	}

	@RequestMapping("/admin_notice_detail")
	public String adminNotiDetail(@RequestParam HashMap<String, String> param, Model model) {
		NoticeDTO dto = admin_service.NoticeDetailView(param);
		model.addAttribute("notice", dto);
		return "admin_notice_detail";
	}

	@RequestMapping("/book_insert_view")
	public String insertBookView() {
		return "book_insert";
	}

	@RequestMapping("/update_book_view")
	public String updateBook() {
		return "book_update";
	}
}
