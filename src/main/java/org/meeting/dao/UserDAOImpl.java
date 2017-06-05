package org.meeting.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.meeting.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
@Repository
public class UserDAOImpl implements UserDAO {
	@Inject
	private SqlSession sqlSession;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private static final String namespace = "org.meeting.mapper.UserMapper";

	@Override
	public void create(UserVO vo) {
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		sqlSession.insert(namespace+".create",vo);
		sqlSession.insert(namespace+".grantcreate", vo);
	}

	@Override
	public UserVO read(String id) throws Exception {
		return sqlSession.selectOne(namespace+".read",id);
	}

	@Override
	public void update(UserVO vo) throws Exception {
		sqlSession.update(namespace+".update",vo);
	}

	@Override
	public void delete(String id) throws Exception {
		sqlSession.delete(namespace+".delete",id);
	}
	
}
