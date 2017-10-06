package org.meeting.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.meeting.domain.ReplyVO;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOimpl implements ReplyDAO {

	// SqlSession에서 INSERT, UPDATE, DELETE에서 return값은 SQL실행으로 인해 영향을 받은 레코드의 갯수
	@Inject
	SqlSession session;

	private static final String namespace = "org.meeting.mapper.replyMapper";

	@Override
	public List<ReplyVO> getRepliesByBoardNo(int boardNo) {
		return session.selectList(namespace + ".getRepliesByBoardNo", boardNo);
	}

	@Override
	public boolean isExistMyParentReply(int boardNo, String username) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardno", boardNo);
		map.put("username", username);
		map.put("parentno", 0);
		ReplyVO replyVO = session.selectOne(namespace + ".isExistParentReply", map);

		if (replyVO == null)
			return false;
		else
			return true;
	}

	@Override
	public int addReply(ReplyVO reply) {
		session.insert(namespace + ".replyRegister", reply);
		return reply.getReplyno();
	}

	@Override
	public ReplyVO getReplyByParentno(int parentNo) {
		return session.selectOne(namespace + ".getReplyByParentno", parentNo);
	}

	@Override
	public int getGroupId() {
		ReplyVO reply = new ReplyVO();
		session.update(namespace + ".getGroupId", reply);
		return reply.getGroupId();
	}

	@Override
	public int calcSeq(ReplyVO parentReply) {
		return session.selectOne(namespace + ".calcSeq", parentReply);
	}

	@Override
	public int getLastSeqInGroup(int groupId) {
		return session.selectOne(namespace + ".getLastSeqInGroup", groupId);
	}

	@Override
	public void updateOtherRepliesSeq(ReplyVO parentReply, int newReplySeq) {
		Map<String, Object> map = new HashMap<>();
		map.put("groupId", parentReply.getGroupId());
		map.put("seq", newReplySeq);
		session.selectOne(namespace + ".updateOtherRepliesSeq", map);
	}

	@Override
	public int deleteReplyByReplyNo(int replyno) {
		return session.delete(namespace + ".deleteReplyByReplyNo", replyno);
	}

	@Override
	public int deleteReplyByParentReplyNo(int parentno) {
		return session.delete(namespace + ".deleteReplyByParentReplyNo", parentno);
	}

	@Override
	public int updateReply(ReplyVO reply) {
		return session.update(namespace + ".updateReply", reply);
	}

	@Override
	public ReplyVO getReplyById(int replyno) {
		return session.selectOne(namespace + ".getReplyById", replyno);
	}

}
