package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ExcelVO;

public interface IExcelMapper {

	public List<ExcelVO> selectExcelList();

	public void excelUpload(Map<String, String> article);

	public void delete();

}
