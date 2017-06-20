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
	private int replyno; // 내  리플 키 -> DB저장 시 자동저장
	private int parentno; // 부모 리플 키 (자식만 가지고 있음)
	private int boardno; // 게시물번호 키 (부모만 가지고 있음)
	private String username; // 작성자
	private String content; // 내용
	private Date replydate; // 저장날짜 -> DB저장 시 자동저장
	
}