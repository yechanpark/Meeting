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
	private int parentno; // �θ� ��� Ű (�ڽ��� �ֻ��� �θ��� replyno�� ����, �θ� ����� 0�� ������ ����)
	private int boardno; // ����� �Ҽӵ� �Խù� ��ȣ
	private int seq; // �׷� ������ ����� �������� ����, 0���� ����
	private int depth; // ��� ����, 0���� ����
	private int groupId; // ��� �׷�(�ֻ��� �θ� �� �ϳ� �Ҵ�,�ڽ� ����� ��� ���� �׷�)
	private String username; // �ۼ���
	private String content; // ����
	private Date replydate; // ���峯¥ -> DB���� �� �ڵ�����
	private String profileimage; // ������ �̹��� ���ϸ�

}