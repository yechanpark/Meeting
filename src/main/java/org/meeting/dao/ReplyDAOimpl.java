package org.meeting.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.meeting.domain.ReplyRelationVO;
import org.meeting.domain.ReplyVO;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOimpl implements ReplyDAO{
	
	@Inject
	SqlSession session;

	private static final String namespace = "org.meeting.mapper.replyMapper";

	@Override
	public List<ReplyVO> getRepliesByBoardNo(int boardNo) {
		return session.selectList(namespace + ".replyReadByBoardNo", boardNo);
	}

	@Override
	public void addReply(ReplyVO reply) {
		session.insert(namespace+".replyRegister",reply);
	}
	
	@Override
	public void addReplyRelation(ReplyRelationVO replyRelation) {
		session.insert(namespace+".replyRelationRegister", replyRelation);
	}


}

