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
	}

	@Override
	public void boardModify(BoardVO vo) {
		dao.boardModify(vo);
	}
	


}
