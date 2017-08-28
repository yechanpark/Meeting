package org.meeting.dao;
import java.util.List;
import java.util.Map;

import org.meeting.domain.BoardVO;
import org.meeting.domain.UserVO;
public interface UserDAO {
	public void create(UserVO vo)throws Exception;
	public UserVO read(String id)throws Exception;
	public void update(UserVO vo)throws Exception;
	public void delete(String id)throws Exception;
	public void myImageDatabaseUpload(String fileName, String username);
	public List<BoardVO> myBoardConfirm(String username);
	public List<BoardVO> myReplyConfirm(String username);
	public Map<String, String> readCount(String onUser);
}
