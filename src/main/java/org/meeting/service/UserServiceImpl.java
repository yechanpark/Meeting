package org.meeting.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.meeting.dao.UserDAO;
import org.meeting.domain.BoardVO;
import org.meeting.domain.UserVO;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;

	@Override
	public void regist(UserVO vo) throws Exception {
		dao.create(vo);
	}

	@Override
	public UserVO read(String id) throws Exception {
		return dao.read(id);
	}

	@Override
	public void modify(UserVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void remove(String id) throws Exception {
		dao.delete(id);
	}

	@Override
	public void myImageDatabaseUpload(String fileName, String username) {
		dao.myImageDatabaseUpload(fileName, username);
	}

	@Override
	public List<BoardVO> myBoardConfirm(String username) {
		return dao.myBoardConfirm(username);
	}

	@Override
	public List<BoardVO> myReplyConfirm(String username) {
		return dao.myReplyConfirm(username);
	}

	@Override
	public Map<String, String> readCount(String onUser) {
		return dao.readCount(onUser);
	}
}
