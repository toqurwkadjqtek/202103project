package org.project.volleyball.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.project.volleyball.dao.BoardFileDAO;
import org.project.volleyball.dto.BoardDTO;
import org.project.volleyball.dto.BoardFileDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileServiceImpl implements FileService{
	private static final Logger logger = LoggerFactory.getLogger(FileServiceImpl.class);
	
	@Autowired
	private String saveDir;
	
	@Autowired
	private BoardFileDAO bfdao;

	@Override
	public String fileUpload(MultipartFile file) {
		if(file.isEmpty()) return "";
		String filename=System.currentTimeMillis()+file.getOriginalFilename();
		File f=new File(saveDir,filename);
		try {
			file.transferTo(f);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return filename;
	}

	//여러개의 파일 처리
	public List<String> fileUploadList(List<MultipartFile> files) {
		List<String> flist=new ArrayList<>();
		for(MultipartFile file:files) {
			String filename=fileUpload(file);
			if(!filename.equals("")) flist.add(filename);
		}
		
		return flist; //파일이름의 리스트
	}

	//파일저장
	@Override
	public void insert(BoardDTO bdto, List<MultipartFile> files) throws Exception {
		//파일디렉토리에 저장
		List<String> fnamelist=fileUploadList(files);
		//파일이름db에 저장
		for(String filename:fnamelist) {
			if(!filename.equals("")) {
				BoardFileDTO bfdto=new BoardFileDTO(bdto.getBnum(),filename);
				bfdao.insert(bfdto);
			}
		}
	}
	
	//선택파일삭제
	@Override
	public void delete(List<Integer> fileDeleteList) throws Exception {
		if (fileDeleteList==null) return ;
		for(int fnum:fileDeleteList) {
			bfdao.delete(fnum);
		}
	}
	
	//게시글파일삭제
	@Override
	public void deleteBoard(int bnum) throws Exception {
		bfdao.deleteBoard(bnum);
	}

}
