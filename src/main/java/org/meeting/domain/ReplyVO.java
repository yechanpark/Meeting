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

	private int replyno; // �� ���� Ű -> DB���� �� �ڵ�����
	private int parentno; // �θ� ��� Ű (�ڽĸ� ������ ����)
	private int boardno; // ����� �Ҽӵ� �Խù� ��ȣ
	private int seq; // ��� ����
	private int depth; // ��� ����
	private int groupId; // ��� �׷�(�ֻ��� �θ� ����)
	private String username; // �ۼ���
	private String content; // ����
	private Date replydate; // ���峯¥ -> DB���� �� �ڵ�����
	private String profileimage; // ������ �̹��� ���ϸ�

}