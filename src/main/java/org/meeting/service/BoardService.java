package org.meeting.service;

import java.util.List;

import org.meeting.domain.BoardVO;

public interface BoardService {

	public List<BoardVO> boardList();
	public void boardRegister(BoardVO vo);
	public BoardVO boardRead(int boardno);
	
	
}
