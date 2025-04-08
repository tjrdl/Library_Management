package com.lmpjt.pilotpjt.Service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lmpjt.pilotpjt.dao.NoticeDAO;
import com.lmpjt.pilotpjt.dto.NoticeDTO;
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void NoticeWrite(HashMap<String, String> param) {
		NoticeDAO dao = sqlSession.getMapper(NoticeDAO.class);
		dao.NoticeWrite(param);
	}

	@Override
	public ArrayList<NoticeDTO> NoticeView() {
		NoticeDAO dao = sqlSession.getMapper(NoticeDAO.class);
		ArrayList<NoticeDTO> list = dao.NoticeView();
		return list;
	}

	@Override
	public NoticeDTO NoticeDetailView(HashMap<String, String> param) {
		NoticeDAO dao = sqlSession.getMapper(NoticeDAO.class);
		dao.NoticeHit(param);
		NoticeDTO dto = dao.NoticeDetailView(param);
		return dto;
	}

	@Override
	public void NoticeModify(HashMap<String, String> param) {
		NoticeDAO dao = sqlSession.getMapper(NoticeDAO.class);
		dao.NoticeModify(param);
	}

	@Override
	public void NoticeDelete(HashMap<String, String> param) {
		NoticeDAO dao = sqlSession.getMapper(NoticeDAO.class);
		dao.NoticeDelete(param);
	}




	
	

}
