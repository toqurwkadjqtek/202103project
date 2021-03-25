package org.project.volleyball.service;

import org.project.volleyball.dao.LikeUserDAO;
import org.project.volleyball.dto.LikeUserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikeUserServiceImpl implements LikeUserService{
	
	@Autowired
	private LikeUserDAO ludao;
	
	@Override
	public int insert(int type,int num,String userid) throws Exception {
		LikeUserDTO ludto=setLikeUserDTO(type,num,userid);
		return ludao.insert(ludto);
	}

	@Override
	public LikeUserDTO selectOne(int type,int num,String userid) throws Exception {
		LikeUserDTO ludto=setLikeUserDTO(type,num,userid);
		return ludao.selectOne(ludto);
	}
	
	@Override
	public int delete(int type,int num,String userid) throws Exception {
		LikeUserDTO ludto=setLikeUserDTO(type,num,userid);
		return ludao.delete(ludto);
	}
	
	@Override
	public int deleteBoardReply(String gubun,int num) throws Exception {
		LikeUserDTO ludto=new LikeUserDTO();
		ludto.setGubun(gubun);
		ludto.setNum(num);
		return ludao.deleteBoardReply(ludto);
	}
	
	//LikeUserDTO 세팅
	public LikeUserDTO setLikeUserDTO(int type,int num,String userid) {
		LikeUserDTO ludto=new LikeUserDTO();
		//type
		//1.게시물조회
		//2.게시물좋아요
		//3.게시물싫어요
		//4.댓글좋아요
		//5.댓글싫어요
		if(type==1) {
			ludto.setGubun("1"); //게시글
			ludto.setNum(num); //게시물번호
			ludto.setUserid(userid); //조회한 userid
			ludto.setLikegubun("0"); //조회
		}else if(type==2) {
			ludto.setGubun("1"); //게시글
			ludto.setNum(num); //게시물번호
			ludto.setUserid(userid); //좋아요한 userid
			ludto.setLikegubun("1"); //좋아요
		}else if(type==3) {
			ludto.setGubun("1"); //게시글
			ludto.setNum(num); //게시물번호
			ludto.setUserid(userid); //싫어요한 userid
			ludto.setLikegubun("2"); //싫어요
		}else if(type==4) {
			ludto.setGubun("2"); //댓글
			ludto.setNum(num); //댓글번호
			ludto.setUserid(userid); //좋아요한 userid
			ludto.setLikegubun("1"); //좋아요
		}else if(type==5) {
			ludto.setGubun("2"); //댓글
			ludto.setNum(num); //댓글번호
			ludto.setUserid(userid); //싫어요한 userid
			ludto.setLikegubun("2"); //싫어요
		}
		return ludto;
	}

}
