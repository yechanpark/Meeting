package org.meeting.dao;

import java.util.List;

import org.meeting.domain.BoardVO;

public interface BoardDAO {

	public List<BoardVO> boardList();

	public void boardRegister(BoardVO vo);

	public BoardVO boardRead(int boardno);

	public void boardDelete(int boardno);

	public void boardModify(BoardVO vo);

	public void heartClick(int boardno, String username);

	public void heartUp(int boardno);

	public void heartDown(int boardno);

	public void heartCancle(int boardno, String username);

	public void heartDelete(int boardno);

	public int heartCheck(int boardno, String username);
}
