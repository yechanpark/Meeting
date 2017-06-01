package org.meeting.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserVO {
	private String usename;
	private String password;
	private String displayname;
	private Boolean enabled;
	private String kakaoid;

}
