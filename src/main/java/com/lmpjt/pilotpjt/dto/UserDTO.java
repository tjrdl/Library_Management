package com.lmpjt.pilotpjt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
	private int userNumber;
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private String userTel;
	private String userBirth;
	private String userZipCode;
	private String userAddress;
	private String userDetailAddress = "";
	private int userBorrow;
	private int userAdmin;
	private String userRegdate;
	private int userRecord;
	private String sessionId;
}
