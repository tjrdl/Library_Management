package com.lmpjt.pilotpjt.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lmpjt.pilotpjt.dto.BookDTO;

public interface BookDAO {
//	public int insertBook(@Param("book")BookDTO book, int admin); 
//	public int updateBook(BookDTO book, int admin);
//	public List<BookDTO> mainBookInfo();
//	public List<BookDTO> searchBookInfo();
	public void insertBook(HashMap<String, String> param); 
	public void updateBook(HashMap<String, String> param);
	public ArrayList<BookDTO> mainBookInfo();
	public ArrayList<BookDTO> searchBookInfo();

	// 대출은 book_borrow 테이블에 삽입됨과 동시에 borrow_record 테이블에 삽입됩니다.
	public void bookBorrow(HashMap<String, String> param); // 대출 필요 시 반환 값 변경
	// 반납은 book_borrow 테이블에서 해당 값을 삭제 하고 return_record 테이블로 삽입 됩니다.
	public void bookReturn(HashMap<String, String> param); // 반납 필요 시 반환 값 변경
	
	
}
