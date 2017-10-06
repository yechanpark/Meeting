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
	public int addReply(ReplyVO reply) throws Exception {

		// 프로필 사진 추가
		UserVO user = userDAO.read(reply.getUsername());
		reply.setProfileimage(user.getProfileimage());

		// 자신의 부모 댓글을 가지고 옴
		ReplyVO parentReply = replyDao.getReplyByParentno(reply.getParentno());

		// 댓글의 댓글인 경우(부모가 있는 경우)
		if (parentReply != null) {
			// 부모와 같은 그룹으로 설정
			reply.setGroupId(parentReply.getGroupId());
			// 부모보다 Depth가 1높게 설정
			reply.setDepth(parentReply.getDepth() + 1);

			int newReplySeq = replyDao.calcSeq(parentReply);

			// 그룹의 맨 마지막에 오는 경우
			if (newReplySeq == 0) {
				newReplySeq = replyDao.getLastSeqInGroup(parentReply.getGroupId() + 1);
				reply.setSeq(newReplySeq);
			}

			// 중간에 삽입하는 경우
			else {
				replyDao.updateOtherSeqAfterAdded(parentReply, newReplySeq);
				reply.setSeq(newReplySeq);
			}

			// 게시글의 댓글인 경우 (부모가 없는 경우)
		} else {
			reply.setSeq(0);
			reply.setDepth(0);
			reply.setGroupId(replyDao.getGroupId());
		}

		return replyDao.addReply(reply);

	}

	@Override
	public void deleteReply(ReplyVO reply) {
		ReplyVO deletedReply = replyDao.getReplyById(reply.getReplyno());

		// 해당 댓글과 이를 부모로 하는 모든 대댓글 삭제
		int numOfDeletedParentReply = replyDao.deleteReplyByReplyNo(deletedReply.getReplyno());
		int numOfDeletedChildReplies = replyDao.deleteReplyByParentReplyNo(deletedReply.getReplyno());

		// 삭제된 총 댓글 갯수
		int sumOfDeletedReplies = numOfDeletedParentReply + numOfDeletedChildReplies;

		/* group 내 seq 재설정 */
		replyDao.updateOtherSeqAfterDeleted(deletedReply, sumOfDeletedReplies);
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
