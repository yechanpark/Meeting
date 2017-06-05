package org.meeting.domain;

public class UserVO {
	private String username;
	private String password;
	private String displayname;
	private String kakaoid;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getDisplayname() {
		return displayname;
	}
	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}
	public String getKakaoid() {
		return kakaoid;
	}
	public void setKakaoid(String kakaoid) {
		this.kakaoid = kakaoid;
	}
	@Override
	public String toString() {
		return "UserVO [username=" + username + ", password=" + password + ", displayname=" + displayname + ", kakaoid="
				+ kakaoid + "]";
	}
}
