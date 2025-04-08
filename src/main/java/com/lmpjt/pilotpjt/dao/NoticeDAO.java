package com.lmpjt.pilotpjt.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lmpjt.pilotpjt.dto.NoticeDTO;



public interface NoticeDAO {
	public void NoticeWrite(HashMap<String, String> param);

	public ArrayList<NoticeDTO> NoticeView();

	public NoticeDTO NoticeDetailView(HashMap<String, String> param);

	public void NoticeModify(HashMap<String, String> param);

	public void NoticeDelete(HashMap<String, String> param);

	public void NoticeHit(HashMap<String, String> param);

}
