package org.meeting.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO implements Serializable {

	private static final long serialVersionUID = 8145216904213739681L;

	private int replyno; // 내 리플 키 -> DB저장 시 자동저장
	private int parentno; // 부모 댓글 키 (자식은 최상위 부모의 replyno를 가짐, 부모 댓글은 0을 가지고 있음)
	private int boardno; // 댓글이 소속된 게시물 번호
	private int seq; // 그룹 내에서 댓글이 보여지는 순서, 0부터 시작
	private int depth; // 댓글 깊이, 0부터 시작
	private int groupId; // 댓글 그룹(최상위 부모 당 하나 할당,자식 댓글은 모두 같은 그룹)
	private String username; // 작성자
	private String content; // 내용
	private Date replydate; // 저장날짜 -> DB저장 시 자동저장
	private String profileimage; // 프로필 이미지 파일명

}