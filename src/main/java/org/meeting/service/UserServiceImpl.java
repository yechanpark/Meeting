package org.meeting.service;

import javax.inject.Inject;

import org.meeting.dao.UserDAO;
import org.meeting.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
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

}
