package org.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.meeting.dao.BoardDAO;
import org.meeting.domain.BoardVO;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceimpl implements BoardService {

	@Inject
	BoardDAO dao;

	@Override
	public List<BoardVO> boardList() {
		return dao.boardList();
	}

	@Override
	public void boardRegister(BoardVO vo) {
		dao.boardRegister(vo);
	}

	@Override
	public BoardVO boardRead(int boardno) {
		return dao.boardRead(boardno);
	}

	@Override
	public void boardDelete(int boardno) {
		dao.boardDelete(boardno);
		dao.heartDelete(boardno);
	}

	@Override
	public void boardModify(BoardVO vo) {
		dao.boardModify(vo);
	}

	@Override
	public void heartClick(int boardno, String username) {
		dao.heartClick(boardno, username);
		dao.heartUp(boardno);
	}

	@Override
	public void heartCancle(int boardno, String username) {
		dao.heartCancle(boardno, username);
		dao.heartDown(boardno);
	}

	@Override
	public int heartCheck(int boardno, String username) {
		return dao.heartCheck(boardno, username);
	}
}
