package org.project.volleyball.dto;
//페이징처리에 필요한 dto
public class PageDTO {
	private int curPage; //현재페이지
	
	private int totPage; //전체페이지수
	
	private int perPage=20; //한페이지 당 게시물수
	private int startNo; //시작번호
	private int endNo; //끝번호
	
	private int perBlock=10; //페이지 블럭의 수
	private int startPage; //블럭의 시작페이지
	private int endPage; //블럭의 끝페이지
	
	private String findKey; //검색키
	private String findValue; //검색값
	
	public PageDTO() {}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getTotPage() {
		return totPage;
	}

	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getPerBlock() {
		return perBlock;
	}

	public void setPerBlock(int perBlock) {
		this.perBlock = perBlock;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getFindKey() {
		return findKey;
	}

	public void setFindKey(String findKey) {
		this.findKey = findKey;
	}

	public String getFindValue() {
		return findValue;
	}

	public void setFindValue(String findValue) {
		this.findValue = findValue;
	}

	@Override
	public String toString() {
		return "PageDTO [curPage=" + curPage + ", totPage=" + totPage + ", perPage=" + perPage + ", startNo=" + startNo
				+ ", endNo=" + endNo + ", perBlock=" + perBlock + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", findKey=" + findKey + ", findValue=" + findValue + "]";
	}

	
	
	
}
