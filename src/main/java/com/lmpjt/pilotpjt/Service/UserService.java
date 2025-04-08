package com.lmpjt.pilotpjt.Service;

import java.util.ArrayList;
import java.util.HashMap;

import com.lmpjt.pilotpjt.dto.UserDTO;

public interface UserService {
	public int userJoin(HashMap<String, String> param); 
	public ArrayList<UserDTO> userLogin(HashMap<String, String> param); 
	public UserDTO checkId(HashMap<String, String> param); 
	public UserDTO getUserInfo(HashMap<String, String> param); 
	public int updateUserInfo(HashMap<String, String> param);
}
