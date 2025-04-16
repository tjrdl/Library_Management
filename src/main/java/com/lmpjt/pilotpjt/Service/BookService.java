package com.lmpjt.pilotpjt.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.lmpjt.pilotpjt.dto.BookDTO;
import com.lmpjt.pilotpjt.dto.BookRecordDTO;

public interface BookService {
	public void insertBook(HashMap<String, String> param);

	public void updateBook(HashMap<String, String> param);

	public ArrayList<BookDTO> mainBookInfo();

	public ArrayList<BookDTO> searchBookInfo(HashMap<String, String> param);

	public BookDTO bookDetailInfo(HashMap<String, String> param);

	public void bookBorrow(HashMap<String, String> param);

	public void bookReturn(HashMap<String, String> param);

	public ArrayList<BookRecordDTO> bookBorrowed(HashMap<String, String> param);

	public ArrayList<BookRecordDTO> bookRecord(HashMap<String, String> param);

	public void deleteBook(HashMap<String, String> param);

}
