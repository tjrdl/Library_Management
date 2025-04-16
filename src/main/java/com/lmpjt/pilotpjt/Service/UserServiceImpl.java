package com.lmpjt.pilotpjt.Service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lmpjt.pilotpjt.dao.UserDAO;
import com.lmpjt.pilotpjt.dto.UserDTO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int userJoin(HashMap<String, String> param) {
		int re = -1;
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		re = dao.userJoin(param);
		return re;
	}

	@Override
	public ArrayList<UserDTO> userLogin(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		ArrayList<UserDTO> list = dao.userLogin(param);
		return list;
	}

	@Override
	public UserDTO checkId(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		UserDTO dto = dao.checkId(param);
		return dto;
	}

	@Override
	public UserDTO getUserInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		UserDTO dto = dao.getUserInfo(param);
		return dto;
	}

	@Override
	public int updateUserInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		int re = dao.updateUserInfo(param);
		return re;
	}

	@Override
	public int updateUserPwInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		int re = dao.updateUserPwInfo(param);
		return re;
	}

	// UserServiceImpl 클래스에서
	public String getSessionIdByUserId(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
//		System.out.println("getSessionIdByUserId 호출: " + param);
		String result = dao.getSessionIdByUserId(param);
//		System.out.println("조회된 세션 ID: " + result);
		return result;
	}

	@Override
	public void deleteSessionInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		dao.deleteSessionInfo(param);
	}

	public void saveSessionInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
	    System.out.println("saveSessionInfo 호출: " + param);
	    dao.saveSessionInfo(param);
//	    System.out.println("세션 저장 완료");
	}

	public int isSessionValid(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
//		System.out.println("isSessionValid 호출: " + param);
		int result = dao.isSessionValid(param);
//		System.out.println("세션 유효성 결과: " + result);
		return result;
	}

}
