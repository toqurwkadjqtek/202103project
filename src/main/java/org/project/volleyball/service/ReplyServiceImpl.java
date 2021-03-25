package org.project.volleyball.service;

import java.util.List;

import org.project.volleyball.dao.ReplyDAO;
import org.project.volleyball.dto.LikeUserDTO;
import org.project.volleyball.dto.ReplyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyDAO rdao;
	
	@Autowired
	private LikeUserService luservice;

	@Override
	public void insert(ReplyDTO rdto) throws Exception {
		//글순서: 부모의 글순서+1
		rdto.setRestep(rdto.getRestep()+1);
		//기존 등록된 글순서+1
		rdao.updateRestep(rdto);
		//글의 레벨: 부모의 레벨+1
		rdto.setRelevel(rdto.getRelevel()+1);
		
		rdao.insert(rdto);
	}

	@Override
	public List<ReplyDTO> selectList(int bnum) throws Exception {
		return rdao.selectList(bnum);
	}

	@Override
	public void update(ReplyDTO rdto) throws Exception {
		rdao.update(rdto);
	}
	
	@Transactional
	@Override
	public String delete(int rnum) throws Exception {
		//댓글의 자식이 존재한다면 삭제 불가
		ReplyDTO rdto=rdao.selectOne(rnum);
		int cnt=rdao.selectReplyCnt(rdto);
		if(cnt>0) {
			return "해당 댓글의 답댓글이 존재하여 삭제가 불가합니다";
		}
		rdao.delete(rnum);
		luservice.deleteBoardReply("2", rnum);
		return "삭제가 완료되었습니다";
	}

	@Override
	public ReplyDTO selectOne(int rnum) throws Exception {
		return rdao.selectOne(rnum);
	}

	@Override
	public int selectReplyCnt(ReplyDTO rdto) throws Exception {
		return rdao.selectReplyCnt(rdto);
	}

	@Override
	public void deleteBoard(int bnum) throws Exception {
		rdao.deleteBoard(bnum);
	}
	
	@Transactional
	@Override
	public int updateLikecnt(int rnum,String userid) throws Exception {
		LikeUserDTO ludto=luservice.selectOne(4,rnum,userid);
		if(ludto!=null) return -1; //유저가 있는 경우
		//만약에 좋아요한 사용자가 없다면
		//1)likeuser에 insert
		//2)좋아요+1
		int cnt=luservice.delete(5,rnum,userid); //싫어요 유저삭제
		if(cnt==1) { //삭제한 데이터가 있다면
			rdao.updateDisLikecntMinus(rnum); //싫어요-1
		}
		luservice.insert(4,rnum,userid);
		return rdao.updateLikecnt(rnum);
	}

	@Transactional
	@Override
	public int updateDisLikecnt(int rnum,String userid) throws Exception {
		LikeUserDTO ludto=luservice.selectOne(5,rnum,userid);
		if(ludto!=null) return -1; //유저가 있는 경우
		//만약에 싫어요한 사용자가 없다면
		//1)likeuser에 insert
		//2)싫어요+1
		int cnt=luservice.delete(4,rnum,userid); //좋아요 유저삭제
		if(cnt==1) { //삭제한 데이터가 있다면
			rdao.updateLikecntMinus(rnum); //좋아요-1
		}
		luservice.insert(5,rnum,userid);
		return rdao.updateDisLikecnt(rnum);
	}

}
