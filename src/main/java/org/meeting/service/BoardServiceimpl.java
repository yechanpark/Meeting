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
		// TODO Auto-generated method stub
		return dao.boardList();
	}

	@Override
	public void boardRegister(BoardVO vo) {
		// TODO Auto-generated method stub
		dao.boardRegister(vo);
	}

	@Override
	public BoardVO boardRead(int boardno) {
		System.out.println("1"+dao.boardRead(boardno));
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
		dao.heartClick(boardno,username);
		dao.heartUp(boardno);
	}

	@Override
	public void heartCancle(int boardno, String username) {
		dao.heartCancle(boardno,username);
		dao.heartDown(boardno);
	}
	


}
