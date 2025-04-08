package com.lmpjt.pilotpjt.Service;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lmpjt.pilotpjt.dao.UserDAO;
import com.lmpjt.pilotpjt.dao.UtilDAO;

@Service
public class UtilServiceImpl implements UtilService {
	@Autowired
	private SqlSession sqlSession;

    @Override
    public int getTotalBooks() {
    	UtilDAO dao = sqlSession.getMapper(UtilDAO.class);
        return dao.getTotalBooks();
    }

    @Override
    public int getTotalUsers() {
    	UtilDAO dao = sqlSession.getMapper(UtilDAO.class);
        return dao.getTotalUsers();
    }

    @Override
    public int getBorrowedBooks() {
    	UtilDAO dao = sqlSession.getMapper(UtilDAO.class);
        return dao.getBorrowedBooks();
    }

    @Override
    public int getOverdueBooks() {
    	UtilDAO dao = sqlSession.getMapper(UtilDAO.class);
        return dao.getOverdueBooks();
    }
}
