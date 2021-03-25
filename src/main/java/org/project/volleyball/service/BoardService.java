package org.project.volleyball.service;

import java.util.List;
import java.util.Map;

import org.project.volleyball.dto.BoardDTO;
import org.project.volleyball.dto.PageDTO;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	public Map<String, Object> selectList(PageDTO pdto) throws Exception;
	public Map<String, Object> selectOne(int bnum) throws Exception; //게시물+파일
	public BoardDTO selectOneBoard(int bnum) throws Exception; //게시물
	public Map<String, Object> insert(BoardDTO bdto,List<MultipartFile> files) throws Exception;
	public Map<String,Object> update(BoardDTO bdto,List<MultipartFile> files,List<Integer> fileDeleteList) throws Exception;
	public Map<String,Object> delete(int bnum) throws Exception;
	public int updateReadcount(int bnum,String userid) throws Exception; //조회수+1
	public int updateLikecnt(int bnum,String userid) throws Exception; //좋아요+1
	public int updateDisLikecnt(int bnum,String userid) throws Exception; //싫어요+1
}
