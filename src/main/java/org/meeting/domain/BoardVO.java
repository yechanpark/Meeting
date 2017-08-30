package org.meeting.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {

	private int boardno;
	private String username;
	private String title;
	private String content;
	private String photo;
	private int readcnt;
	private int replycnt;
	private Date regdate;
	private int heartcnt;

	// 게시판 read했을시 닉네임,프로필 이미지 호출
	private String displayname;
	private String profileimage;

}
