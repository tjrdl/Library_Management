package com.lmpjt.pilotpjt.dao;


import java.util.ArrayList;
import java.util.HashMap;

import com.lmpjt.pilotpjt.dto.UserDTO;

public interface UserDAO {
//	public int userJoin(UserDTO dto); 
//	public ArrayList<UserDTO> userLogin(String id, String pwd); 
//	public UserDTO checkId(String userId); 
//	public UserDTO getUserInfo(String userId); 
//	public int updateUserInfo(UserDTO dto); 
	public int userJoin(HashMap<String, String> param); 
	public ArrayList<UserDTO> userLogin(HashMap<String, String> param); 
	public UserDTO checkId(HashMap<String, String> param); 
	public UserDTO getUserInfo(HashMap<String, String> param); 
	public int updateUserInfo(HashMap<String, String> param); 
}
