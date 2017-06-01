package org.meeting.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO implements Serializable {

	private static final long serialVersionUID = 8145216904213739681L;
	private int replyno; // 리플번호 기본키
	private int boardno; // 게시물번호 외래키
	private int userno; // 유저번호 외래키
	private String content; // 댓글 내용
	
}