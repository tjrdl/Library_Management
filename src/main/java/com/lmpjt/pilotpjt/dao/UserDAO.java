package com.lmpjt.pilotpjt.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lmpjt.pilotpjt.dto.UserDTO;

public interface UserDAO {
	public int userJoin(HashMap<String, String> param);

	public ArrayList<UserDTO> userLogin(HashMap<String, String> param);

	public UserDTO checkId(HashMap<String, String> param);

	public UserDTO getUserInfo(HashMap<String, String> param);

	public int updateUserInfo(HashMap<String, String> param);

	public int updateUserPwInfo(HashMap<String, String> param);

	public String getSessionIdByUserId(HashMap<String, String> param);
	public void deleteSessionInfo(HashMap<String, String> param);
	public void saveSessionInfo(HashMap<String, String> param);
	public int isSessionValid(HashMap<String, String> param);
}
