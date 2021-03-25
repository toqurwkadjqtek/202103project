package org.project.volleyball.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.project.volleyball.dao.BoardDAO;
import org.project.volleyball.dao.BoardFileDAO;
import org.project.volleyball.dto.BoardDTO;
import org.project.volleyball.dto.BoardFileDTO;
import org.project.volleyball.dto.LikeUserDTO;
import org.project.volleyball.dto.PageDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BoardServiceImpl implements BoardService{
	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private FileService fservice;
	
	@Autowired
	private BoardFileDAO bfdao;
	
	@Autowired
	private LikeUserService luservice;
	
	@Autowired
	private ReplyService rservice;

	@Override
	public Map<String,Object> selectList(PageDTO pdto) throws Exception {
		//페이징처리
		int curPage=pdto.getCurPage(); //현재 페이지 번호
		int perPage=pdto.getPerPage(); //한 페이지당 게시물수
		int perBlock=pdto.getPerBlock(); //페이지 블럭의 수
		
		int startNo=(curPage-1)*perPage; //시작번호(mysql은 시작번호가 0)
		int endNo=startNo+perPage-1; //끝번호
		int startPage=curPage-((curPage-1)%perBlock); //시작페이지
		int endPage=startPage+perBlock-1; //끝페이지
		
		//전체 게시물 수
		int totCnt=bdao.selectTotCnt(pdto);
		logger.info(totCnt+"");
		
		int totPage=totCnt/perPage; //전체 페이지 수
		if(totCnt%perPage!=0) { totPage++; } //만약 나머지가 있으면 +12
		if(totPage<endPage) { endPage=totPage; } //끝페이지 재수정
		
		pdto.setStartNo(startNo);
		pdto.setEndNo(endNo);
		pdto.setStartPage(startPage);
		pdto.setEndPage(endPage);
		pdto.setTotPage(totPage);
		logger.info(pdto.toString());
		
		Map<String,Object> resultMap=new HashMap<>();
		resultMap.put("blist",bdao.selectList(pdto)); //게시물 리스트
		resultMap.put("pdto",pdto); //페이지dto
		
		return resultMap;
	}
	
	//게시물+파일조회
	@Override
	public Map<String,Object> selectOne(int bnum) throws Exception {
		//게시물 조회
		BoardDTO bdto=bdao.selectOne(bnum);
		//파일 조회
		List<BoardFileDTO> bflist=bfdao.selectList(bnum);
		Map<String,Object> resultMap=new HashMap<>();
		resultMap.put("bdto",bdto);
		resultMap.put("bflist",bflist);
		return resultMap;
	}
	
	//게시물조회
	@Override
	public BoardDTO selectOneBoard(int bnum) throws Exception {
		return bdao.selectOne(bnum);
	}
	
	//작업단위: commit,rollback의 수행단위
	@Transactional
	@Override
	public Map<String, Object> insert(BoardDTO bdto,List<MultipartFile> files) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		//게시물db에 저장
		int cnt=bdao.insert(bdto); //mapper에 의해 bdto에 bnum이 세팅됨
		//파일저장
		fservice.insert(bdto,files);

		resultMap.put("cnt",cnt);
		if(cnt==1) {
			resultMap.put("msg","등록되었습니다");
		}else {
			resultMap.put("msg","등록에 실패했습니다");
		}
		
		return resultMap;
	}

	@Transactional
	@Override
	public Map<String, Object> update(BoardDTO bdto,List<MultipartFile> files,List<Integer> fileDeleteList) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		//게시물수정
		int cnt=bdao.update(bdto);
		//파일삭제
		fservice.delete(fileDeleteList);
		//파일추가
		fservice.insert(bdto,files);
		
		resultMap.put("cnt",cnt);
		if(cnt==1) {
			resultMap.put("msg","수정되었습니다");
		}else {
			resultMap.put("msg","수정에 실패했습니다");
		}
		return resultMap;
	}

	@Transactional
	@Override
	public Map<String, Object> delete(int bnum) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		//댓글삭제
		rservice.deleteBoard(bnum);
		//게시글파일삭제(외래키 걸려있어서 먼저 삭제해야함)
		fservice.deleteBoard(bnum);
		//게시글삭제
		int cnt=bdao.delete(bnum);
		//좋아요삭제
		luservice.deleteBoardReply("1",bnum);
		resultMap.put("cnt",cnt);
		if(cnt==1) {
			resultMap.put("msg","삭제되었습니다");
		}else {
			resultMap.put("msg","삭제에 실패했습니다");
		}
		return resultMap;
	}

	@Override
	public int updateReadcount(int bnum,String userid) throws Exception {
		LikeUserDTO ludto=luservice.selectOne(1,bnum,userid);
		//만약에 조회 사용자가 없다면
		//1)likeuser에 insert
		//2)조회수+1
		if(ludto!=null) return -1; //유저가 있는 경우
		luservice.insert(1,bnum,userid);
		int cnt=bdao.updateReadcount(bnum);
		return cnt;
	}

	@Transactional
	@Override
	public int updateLikecnt(int bnum,String userid) throws Exception {
		LikeUserDTO ludto=luservice.selectOne(2,bnum,userid);
		if(ludto!=null) return -1; //유저가 있는 경우
		//만약에 좋아요한 사용자가 없다면
		//1)likeuser에 insert
		//2)좋아요+1
		int cnt=luservice.delete(3,bnum,userid); //싫어요 유저삭제
		if(cnt==1) { //삭제한 데이터가 있다면
			bdao.updateDisLikecntMinus(bnum); //싫어요-1
		}
		luservice.insert(2,bnum,userid);
		return bdao.updateLikecnt(bnum);
	}

	@Transactional
	@Override
	public int updateDisLikecnt(int bnum,String userid) throws Exception {
		LikeUserDTO ludto=luservice.selectOne(3,bnum,userid);
		if(ludto!=null) return -1; //유저가 있는 경우
		//만약에 싫어요한 사용자가 없다면
		//1)likeuser에 insert
		//2)싫어요+1
		int cnt=luservice.delete(2,bnum,userid); //좋아요 유저삭제
		if(cnt==1) { //삭제한 데이터가 있다면
			bdao.updateLikecntMinus(bnum); //좋아요-1
		}
		luservice.insert(3,bnum,userid);
		return bdao.updateDisLikecnt(bnum);
	}

}
