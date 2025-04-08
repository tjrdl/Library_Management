package com.lmpjt.pilotpjt.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.lmpjt.pilotpjt.dto.BookDTO;

public interface BookService {
	public void insertBook(HashMap<String, String> param); 
	public void updateBook(HashMap<String, String> param);
	public ArrayList<BookDTO> mainBookInfo();
	public ArrayList<BookDTO> searchBookInfo();
}
