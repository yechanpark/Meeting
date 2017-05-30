package org.meeting.domain;

import java.util.Date;


public class BoardVO {
	
	private int boardno;
	private String username;
	private String title;
	private String content;
	private String photo;
	private int readcnt;
	private int replycnt;
	private Date regdate;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
	@Override
	public String toString() {
		return "BoardVO [boardno=" + boardno + ", username=" + username + ", title=" + title + ", content=" + content
				+ ", photo=" + photo + ", readcnt=" + readcnt + ", replycnt=" + replycnt + ", regdate=" + regdate + "]";
	}
}
