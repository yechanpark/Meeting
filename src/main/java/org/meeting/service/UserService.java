package org.meeting.service;

import java.util.List;

import org.meeting.domain.BoardVO;
import org.meeting.domain.UserVO;

public interface UserService {
	public void regist(UserVO vo)throws Exception;
	public UserVO read(String id)throws Exception;
	public void modify(UserVO vo)throws Exception;
	public void remove(String id)throws Exception;
	public void myImageDatabaseUpload(String fileName, String username);
	public List<BoardVO> myBoardConfirm(String username);
	public List<BoardVO> myReplyConfirm(String username);
}
