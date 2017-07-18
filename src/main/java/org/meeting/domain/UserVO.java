package org.meeting.domain;


import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserVO {

	@NotNull
	@Size(min=4,max=20)
	@Pattern(regexp="^[a-zA-Z0-9]*$", message="아이디는 4~20자,영소문자,대문자,숫자를 입력하세요")
	private String username;
	@NotNull
	@Size(min=6,max=20)
	@Pattern(regexp="^[a-zA-Z0-9]*$", message="password똑바로해라")
	private String password;
	@NotNull
	private String displayname;
	@NotNull
	@Pattern(regexp="^[a-zA-Z0-9]*$", message="kakaoid똑바로해라")
	private String kakaoid;
	private String profileimage;
	
	
}
