package org.meeting.domain;

public class UserVO {


	private String usename;
	private String password;
	private String displayname;
	private Boolean enabled;
	private String kakaoid;
	
	public String getUsename() {
		return usename;
	}
	public void setUsename(String usename) {
		this.usename = usename;
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
	public Boolean getEnabled() {
		return enabled;
	}
	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	public String getKakaoid() {
		return kakaoid;
	}
	public void setKakaoid(String kakaoid) {
		this.kakaoid = kakaoid;
	}

	@Override
	public String toString() {
		return "UserVO [usename=" + usename + ", password=" + password + ", displayname=" + displayname + ", enabled="
				+ enabled + ", kakaoid=" + kakaoid + "]";
	}

}
