package com.ezen.myProject.repogitory;

import java.util.List;

import com.ezen.myProject.domain.fileVO;

public interface FileDAO {

	int insertFile(fileVO fvo);

	List<fileVO> selectFileList(int bno);

	int delete(String uuid);

}
