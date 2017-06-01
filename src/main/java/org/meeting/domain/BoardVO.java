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
	
}
