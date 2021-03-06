package org.meeting.dao;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyDAO {

	// 게시판 번호를 기준으로 모든 댓글 소환
	List<ReplyVO> getRepliesByBoardNo(int boardNo);

	// 로그인한 유저가 해당 게시물에 1차 댓글을 달았는지 -> 이미 달았다면 더 이상 달 수 없다.
	boolean isExistMyParentReply(int boardNo, String username);

	// 댓글 추가
	int addReply(ReplyVO reply);

	// 부모 번호를 기준으로 Reply를 얻는다.
	ReplyVO getReplyByParentno(int parentNo);

	// groupid를 증가 후 얻어온다. -> 시퀀스 대용
	int getGroupId();

	// 부모 댓글을 가지고 와서 현재 댓글의 Seq값을 계산
	int calcSeq(ReplyVO parentReply);

	// group에서의 마지막 Seq값을 구함
	int getLastSeqInGroup(int groupId);
	
	// 댓글 추가 후 다른 댓글들의 Seq값 수정(현재 댓글보다 큰 Seq로 설정되게 +1씩 모두 증가)
	void updateOtherSeqAfterAdded(ReplyVO parentReply, int newReplySeq);

	// 댓글번호로 댓글삭제
	int deleteRepliesByReply(ReplyVO deletedReply);
	
	// 삭제된 댓글(deletedReply)의 group과 같은 댓글 중 seq값이 높은 댓글들을, 지워진 총 댓글의 갯수만큼 뺀다.
	void updateOtherSeqAfterDeleted(ReplyVO deletedReply, int sumOfDeletedReplies);
	
	// 인자로 넘어온 reply의 replyno에 해당하는 댓글을 reply의 내용으로 수정
	int updateReply(ReplyVO reply);

	// id값으로 Reply를 얻어옴
	ReplyVO getReplyById(int replyno);

	




}
