package org.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.meeting.dao.ReplyDAO;
import org.meeting.dao.UserDAO;
import org.meeting.domain.ReplyVO;
import org.meeting.domain.UserVO;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceimpl implements ReplyService {

	@Inject
	ReplyDAO replyDao;

	@Inject
	UserDAO userDAO;

	@Override
	public List<ReplyVO> getRepliesByBoardNo(int boardNo) {
		return replyDao.getRepliesByBoardNo(boardNo);
	}

	@Override
	public boolean isExistMyParentReply(int boardNo, String username) {
		return replyDao.isExistMyParentReply(boardNo, username);
	}

	@Override
	public int addReply(ReplyVO addedReply) throws Exception {

		// 프로필 사진 추가
		UserVO user = userDAO.read(addedReply.getUsername());
		addedReply.setProfileimage(user.getProfileimage());

		// 자신의 부모 댓글을 가지고 옴
		ReplyVO parentReply = replyDao.getReplyByParentno(addedReply.getParentno());

		// 댓글의 댓글인 경우(부모가 있는 경우)
		if (parentReply != null) {
			// 부모와 같은 그룹으로 설정
			addedReply.setGroupId(parentReply.getGroupId());
			
			// 부모보다 Depth가 1높게 설정 (계층형 댓글, 현재 프로젝트에서는 무의미)
			addedReply.setDepth(parentReply.getDepth() + 1);

			/* 모든 자식 댓글은 최상위 부모의 replyno를 parentno으로 가짐 */
			// 첫 번째 대댓글의 경우
			if(parentReply.getParentno() == 0)
				addedReply.setParentno(parentReply.getReplyno());
			// 2번째 이상 대댓글의 경우
			else addedReply.setParentno(parentReply.getParentno());

			// 새로운 댓글이 들어갈 seq값을 구함
			int newReplySeq = replyDao.calcSeq(parentReply);

			// 그룹의 맨 마지막에 오는 경우
			if (newReplySeq == 0) {
				// 새로운 댓글을 제외하고, 그룹 내 기존의 가장 seq값을 구함 
				newReplySeq = replyDao.getLastSeqInGroup(parentReply.getGroupId());
				// 가장 마지막 seq을 가지도록 +1
				addedReply.setSeq(newReplySeq+1);
			}

			// 중간에 삽입하는 경우
			else {
				replyDao.updateOtherSeqAfterAdded(parentReply, newReplySeq);
				addedReply.setSeq(newReplySeq);
			}

			// 게시글의 댓글인 경우 (부모가 없는 경우)
		} else {
			addedReply.setSeq(0);
			addedReply.setDepth(0);
			addedReply.setGroupId(replyDao.getGroupId());
		}

		return replyDao.addReply(addedReply);

	}

	@Override
	public int deleteReply(ReplyVO reply) {
		ReplyVO deletedReply = replyDao.getReplyById(reply.getReplyno());

		// 삭제댓글과 groupId가 같으면서 seq값이 같거나 큰 댓글 모두 삭제 
		return replyDao.deleteRepliesByReply(deletedReply);
	}

	@Override
	public int updateReply(ReplyVO reply) {
		return replyDao.updateReply(reply);
	}

	@Override
	public ReplyVO getReplyById(int replyno) {
		return replyDao.getReplyById(replyno);
	}
}
