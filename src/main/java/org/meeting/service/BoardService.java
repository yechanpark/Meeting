package org.meeting.service;

import java.util.List;

import org.meeting.domain.BoardVO;

public interface BoardService {

	public List<BoardVO> boardList();

	public void boardRegister(BoardVO vo);

	public BoardVO boardRead(int boardno);

	public void boardDelete(int boardno);

	public void boardModify(BoardVO vo);

	public void heartClick(int boardno, String username);

	public void heartCancle(int boardno, String username);

	public int heartCheck(int boardno, String username);
}
