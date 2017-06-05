package org.meeting.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.meeting.domain.BoardVO;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOimpl implements BoardDAO {
	
	@Inject
	SqlSession session;
	
	private static final String namespace = "org.meeting.mapper.boardMapper";
	
	@Override
	public List<BoardVO> boardList() {
		return session.selectList(namespace+".boardList");
	}

	@Override
	public void boardRegister(BoardVO vo) {
		
		session.insert(namespace+".boardRegister",vo);
	}

	@Override
	public BoardVO boardRead(int boardno) {
		System.out.println();
		return session.selectOne(namespace+".boardRead",boardno);
		
	}

	@Override
	public void boardDelete(int boardno) {
		session.delete(namespace+".boardDelete", boardno);
	}

	@Override
	public void boardModify(BoardVO vo) {
		 session.update(namespace+".boardModify",vo);
	}

	@Override
	public void heartClick(int boardno, String username) {
		Map<String,Object> map = new HashMap<>();
		map.put("boardno", boardno);
		map.put("username",username);
		session.insert(namespace+".heartClick",map);
	}

	@Override
	public void heartUp(int boardno) {
		session.update(namespace+".heartUp",boardno);
	}

	@Override
	public void heartDown(int boardno) {
		session.update(namespace+".heartDown",boardno);
	}

	@Override
	public void heartCancle(int boardno, String username){
		Map<String,Object> map = new HashMap<>();
		map.put("boardno", boardno);
		map.put("username",username);
		session.delete(namespace+".heartCancle",map);
	}
	
	

}
