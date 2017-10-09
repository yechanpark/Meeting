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

		// ������ ���� �߰�
		UserVO user = userDAO.read(addedReply.getUsername());
		addedReply.setProfileimage(user.getProfileimage());

		// �ڽ��� �θ� ����� ������ ��
		ReplyVO parentReply = replyDao.getReplyByParentno(addedReply.getParentno());

		// ����� ����� ���(�θ� �ִ� ���)
		if (parentReply != null) {
			// �θ�� ���� �׷����� ����
			addedReply.setGroupId(parentReply.getGroupId());
			
			// �θ𺸴� Depth�� 1���� ���� (������ ���, ���� ������Ʈ������ ���ǹ�)
			addedReply.setDepth(parentReply.getDepth() + 1);

			/* ��� �ڽ� ����� �ֻ��� �θ��� replyno�� parentno���� ���� */
			// ù ��° ������ ���
			if(parentReply.getParentno() == 0)
				addedReply.setParentno(parentReply.getReplyno());
			// 2��° �̻� ������ ���
			else addedReply.setParentno(parentReply.getParentno());

			// ���ο� ����� �� seq���� ����
			int newReplySeq = replyDao.calcSeq(parentReply);

			// �׷��� �� �������� ���� ���
			if (newReplySeq == 0) {
				// ���ο� ����� �����ϰ�, �׷� �� ������ ���� seq���� ���� 
				newReplySeq = replyDao.getLastSeqInGroup(parentReply.getGroupId());
				// ���� ������ seq�� �������� +1
				addedReply.setSeq(newReplySeq+1);
			}

			// �߰��� �����ϴ� ���
			else {
				replyDao.updateOtherSeqAfterAdded(parentReply, newReplySeq);
				addedReply.setSeq(newReplySeq);
			}

			// �Խñ��� ����� ��� (�θ� ���� ���)
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

		// ������۰� groupId�� �����鼭 seq���� ���ų� ū ��� ��� ���� 
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
