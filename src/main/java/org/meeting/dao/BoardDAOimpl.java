package org.meeting.dao;

import java.util.List;

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
		
		return session.selectOne(namespace+".boardRead",boardno);
		
	}
	
	

}
