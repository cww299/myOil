package util;

public class Page {
	
	private int resultNums;
	private int nowPage=1;
	private int start=0;
	private int getSelect=10;
	
	public int getGetSelect() {
		return getSelect;
	}
	public void setGetSelect(int getSelect) {
		this.getSelect = getSelect;
	}
	public int getResultNums() {
		return resultNums;
	}
	public void setResultNums(int resultNums) {
		this.resultNums = resultNums;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public void toSumStart() {
		this.start=(this.nowPage-1)*this.getSelect;
	}
}
