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

	// boardNo로 부모 댓글 replyNo 얻음
	@Override
	public int getParentNoByBoardNo(int boardno, String username) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardno", boardno);
		map.put("username", username);
		map.put("parentno", 0);
		
		// 1차 댓글이 있는지 검색
		ReplyVO reply = session.selectOne(namespace + ".getParentReplyByBoardnoUsernameParentno", map);

		if (reply == null)
			return 0;
		else
			return reply.getReplyno();
	}

	@Override
	public int addReply(ReplyVO reply) {
		session.insert(namespace + ".replyRegister", reply);

		return reply.getReplyno();

	}

	@Override
	public List<ReplyVO> getAllRepliesByParentNo(int parentno) {
		return session.selectList(namespace + ".getAllRepliesByParentNo", parentno);
	}

	@Override
	public int getRepliesCountByBoardNo(int boardno, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardno", boardno);
		map.put("username", username);
		return session.selectOne(namespace + ".getRepliesCountByBoardNo", map);
	}

	@Override
	public boolean isExistMyParentReply(int boardno, String username) {
		if (getParentNoByBoardNo(boardno, username) == 0)
			return false;
		return true;
	}

}

