package mapper;

import java.util.List;

import pojo.Essay;

public interface EssayMapper {
	
	Essay getEssayById(int id);
	
	List<Essay> getEssayList(int num);
	
	List<Essay> getEssayListByCategory(int num,String category);
	
	List<Essay> getEssayByTitle(String title);
	
	List<Essay> getEssayByAuthorId(int authorId);
	
	List<Essay> selectEssay(Essay essay);

	Essay getNext(Essay essay);
	Essay getBefore(Essay essay);
	
	int addEssayViews(int id);
	
	int getNumOfCategory(String category);
	
	int addEssay(Essay essay);
	
	int deleteEssay(int id);
	
	int updateEssay(Essay essay);
	
	int addEssayViews(int id,int num);
}
