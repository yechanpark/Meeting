package org.meeting.dao;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyDAO {

	// �Խ��� ��ȣ�� �������� ��� ��� ��ȯ
	List<ReplyVO> getRepliesByBoardNo(int boardNo);

	// �α����� ������ �ش� �Խù��� 1�� ����� �޾Ҵ��� -> �̹� �޾Ҵٸ� �� �̻� �� �� ����.
	boolean isExistMyParentReply(int boardNo, String username);

	// ��� �߰�
	int addReply(ReplyVO reply);

	// �θ� ��ȣ�� �������� Reply�� ��´�.
	ReplyVO getReplyByParentno(int parentNo);

	// groupid�� ���� �� ���´�. -> ������ ���
	int getGroupId();

	// �θ� ����� ������ �ͼ� ���� ����� Seq���� ���
	int calcSeq(ReplyVO parentReply);

	// group������ ������ Seq���� ����
	int getLastSeqInGroup(int groupId);

	// �ٸ� ��� ���� Seq�� ����(���� ��ۺ��� ū Seq�� �����ǰ� +1�� ��� ����)
	void updateOtherRepliesSeq(ReplyVO parentReply, int newReplySeq);

	// ��۹�ȣ�� ��ۻ���
	int deleteReplyByReplyNo(int replyno);

	// �ش� ��� ��ȣ�� �θ�� �ϴ� ��� ��� ����
	int deleteReplyByParentReplyNo(int parentno);
	
	// ���ڷ� �Ѿ�� reply�� replyno�� �ش��ϴ� ����� reply�� �������� ����
	int updateReply(ReplyVO reply);

	// id������ Reply�� ����
	ReplyVO getReplyById(int replyno);



}
