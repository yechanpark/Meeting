package org.meeting.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.meeting.domain.ReplyVO;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOimpl implements ReplyDAO{
	
	@Inject
	SqlSession session;

	private static final String namespace = "org.meeting.mapper.replyMapper";

	@Override
	public List<ReplyVO> getParentRelpies(int boardNo) {
		return session.selectList(namespace+".getParentReplies", boardNo);
	}

	@Override
	public List<ReplyVO> getChildRepliesByParentNo(int replyno) {
		return session.selectList(namespace+".getChildRepliesByParentNo", replyno);
	}

	@Override
	public boolean isExistMyParentReply(int boardNo, String username) {
		Map<String,Object> map = new HashMap<>();
		map.put("boardno", boardNo);
		map.put("username",username);
		map.put("parentno",0);
		ReplyVO replyVO = session.selectOne(namespace+".isExistParentReply",map);
		if(replyVO == null) return false;
		else return true;
	}

	@Override
	public int addReply(ReplyVO reply) {
		return session.insert(namespace+".replyRegister", reply);
	}

}

