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
	private int parentno; // 부모 댓글 키 (자식만 가지고 있음)
	private int boardno; // 댓글이 소속된 게시물 번호
	private int seq; // 댓글 순서
	private int depth; // 댓글 깊이
	private int groupId; // 댓글 그룹(최상위 부모 기준)
	private String username; // 작성자
	private String content; // 내용
	private Date replydate; // 저장날짜 -> DB저장 시 자동저장
	private String profileimage; // 프로필 이미지 파일명

}