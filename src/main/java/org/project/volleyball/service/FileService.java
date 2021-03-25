package org.project.volleyball.service;

import java.util.List;

import org.project.volleyball.dto.BoardDTO;
import org.springframework.web.multipart.MultipartFile;

public interface FileService {
	
	public String fileUpload(MultipartFile file) throws Exception; //파일저장(디렉토리+db),파일이름리턴

	public void insert(BoardDTO bdto, List<MultipartFile> files) throws Exception; //수정파일저장(디렉토리+db)
	public void delete(List<Integer> fileDeleteList) throws Exception; //선택파일삭제
	public void deleteBoard(int bnum) throws Exception; //게시글파일삭제

}
