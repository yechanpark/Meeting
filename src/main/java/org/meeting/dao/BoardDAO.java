package org.meeting.dao;

import java.util.List;

import org.meeting.domain.BoardVO;

public interface BoardDAO {
	
	public List<BoardVO> boardList();
	public void boardRegister(BoardVO vo);
	public BoardVO boardRead(int boardno);
	public void boardDelete(int boardno);
	public void boardModify(BoardVO vo);
}
