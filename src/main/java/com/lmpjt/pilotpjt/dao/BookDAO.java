package com.lmpjt.pilotpjt.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lmpjt.pilotpjt.dto.BookDTO;
import com.lmpjt.pilotpjt.dto.BookRecordDTO;

public interface BookDAO {
	public void insertBook(HashMap<String, String> param);

	public void updateBook(HashMap<String, String> param);

	public ArrayList<BookDTO> mainBookInfo();

	public ArrayList<BookDTO> searchBookInfo(HashMap<String, String> param);

	public BookDTO bookDetailInfo(HashMap<String, String> param);

	public void bookBorrow(HashMap<String, String> param);

	public void bookReturn(HashMap<String, String> param);

	public int getBorrowedCount(HashMap<String, String> param);

	public int getOverdueCount(HashMap<String, String> param);

	public int getReturnedCount(HashMap<String, String> param);

	public ArrayList<BookDTO> isReturned(HashMap<String, String> param);

	public ArrayList<BookRecordDTO> bookBorrowed(HashMap<String, String> param);

	public ArrayList<BookRecordDTO> bookRecord(HashMap<String, String> param);

	public void deleteBook(HashMap<String, String> param);
}
