package service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.EssayMapper;
import pojo.Essay;
import service.EssayService;

@Service
public class EssayServiceImpl implements EssayService{
	
	@Autowired
	EssayMapper essayMapper;
	
	@Override
	public Essay getEssayById(int id) {
		return essayMapper.getEssayById(id);
	}

	@Override
	public List<Essay> getEssayList(int num) {
		return essayMapper.getEssayList(num);
	}

	@Override
	public List<Essay> getEssayListByCategory(int num, String category) {
		return essayMapper.getEssayListByCategory(num, category);
	}

	@Override
	public List<Essay> getEssayByTitle(String title) {
		return essayMapper.getEssayByTitle(title);
	}

	@Override
	public List<Essay> getEssayByAuthorId(int authorId) {
		return essayMapper.getEssayByAuthorId(authorId);
	}

	@Override
	public int addEssay(Essay essay) {
		return essayMapper.addEssay(essay);
	}

	@Override
	public int deleteEssay(int id) {
		return essayMapper.deleteEssay(id);
	}

	@Override
	public int updateEssay(Essay essay) {
		return essayMapper.updateEssay(essay);
	}

	@Override
	public int addEssayViews(int id, int num) {
		return essayMapper.addEssayViews(id, num);
	}

	@Override
	public List<Essay> selectEssay(Essay essay) {
		return essayMapper.selectEssay(essay);
	}

	@Override
	public Essay getNext(Essay essay) {
		return essayMapper.getNext(essay);
	}

	@Override
	public Essay getBefore(Essay essay) {
		return essayMapper.getBefore(essay);
	}

	@Override
	public int getNumOfCategory(String category) {
		return essayMapper.getNumOfCategory(category);
	}

	@Override
	public int addEssayViews(int id) {
		return essayMapper.addEssayViews(id);
	}

}
