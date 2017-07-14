package org.meeting.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.meeting.domain.BoardVO;
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

	@Override
	public void myImageDatabaseUpload(String fileName, String username) {
		Map<String, String> map = new HashMap<>();
		map.put("fileName", fileName);
		map.put("username", username);
		sqlSession.update(namespace+".myImageDatabaseUpload",map);
	}

	@Override
	public List<BoardVO> myBoardConfirm(String username) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".myBoardConfirm", username);
	}

	@Override
	public List<BoardVO> myReplyConfirm(String username) {

		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		return sqlSession.selectList(namespace+".myReplyConfirm",username);
	}
	
}
