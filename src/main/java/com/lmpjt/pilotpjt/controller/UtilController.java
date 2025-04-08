package com.lmpjt.pilotpjt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lmpjt.pilotpjt.Service.UtilService;

@Controller
public class UtilController {
    @Autowired
    private UtilService utilService;

    @RequestMapping("/stats")
    public String getStatistics(Model model) {
        model.addAttribute("totalBooks", utilService.getTotalBooks());
        model.addAttribute("totalUsers", utilService.getTotalUsers());
        model.addAttribute("borrowedBooks", utilService.getBorrowedBooks());
        model.addAttribute("overdueBooks", utilService.getOverdueBooks());

        return "dashboard";  // dashboard.jsp �� �̵�
    }
}
