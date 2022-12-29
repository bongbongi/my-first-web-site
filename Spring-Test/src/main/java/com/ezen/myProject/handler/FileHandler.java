package com.ezen.myProject.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.poi.ss.formula.functions.Replace;
import org.apache.tika.Tika;
import org.joda.time.LocalDate;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.myProject.domain.fileVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@AllArgsConstructor
@Component
public class FileHandler {
	private final String Up_DIR = "D:\\_javaweb\\_java\\fileUpload";

	public List<fileVO> uploadFiles(MultipartFile[] files) {
		LocalDate date = LocalDate.now(); // 현재 날짜 생성
		log.info(">>> date : " + date);
		String today = date.toString(); // 오늘 날짜 기준 2022-12-27 이렇게 보임
		// 파일 구분자로 변경하고 싶다면 -> 2022-01-01 -> 2022\01\01
		today = today.replace("-", File.separator);

		File folders = new File(Up_DIR, today); // up폴더 밑에 today 폴더를 생성하겠다
		// 폴더가 있으면 생성X, 없으면 생성
		if (!folders.exists()) {
			folders.mkdirs(); // mkdirs: 폴더 생성해라
		}
		// 파일 경로설정 완료
		List<fileVO> fList = new ArrayList<fileVO>();
		for (MultipartFile file : files) {
			fileVO fvo = new fileVO();
			fvo.setSave_dir(today); // 전체 경로를 담고싶다면 today 대신에 folders를 담으면 됨
			fvo.setFile_size(file.getSize()); //사이즈 설정

			String originalFileName = file.getOriginalFilename();
			log.info(">>> fileName" + originalFileName);

			String onlyFileName = originalFileName.substring(originalFileName.lastIndexOf("\\")+1);
			log.info(">>> only fileName : "+onlyFileName);
			fvo.setFile_name(onlyFileName); //파일 이름 설정 
			//uuid
			UUID uuid = UUID.randomUUID(); // String타입이 아니라 UUID 형식임
			fvo.setUuid(uuid.toString()); //그래서 toString 해줘야함
			//▲ 여기까지는 fvo에 저장할 파일을 정보 생성 - > set ▲
			
			//▼ 디스크에 저장할 파일 객체 생성 ▼
			String fullFileName = uuid.toString()+"_"+onlyFileName;
			File storeFile = new File(folders,fullFileName);
			try {
				file.transferTo(storeFile); //원본객체를 저장을 위한 형태의 객체로 복사
				if(isImageFile(storeFile)) {
					fvo.setFile_type(1);
					File thumbNail = new File(folders, uuid.toString()+"_th_"+onlyFileName);
					Thumbnails.of(storeFile).size(75, 75).toFile(thumbNail);
				}
			} catch (Exception e) {
				log.info(">>> File 생성 오류");
				e.printStackTrace();
			}
			fList.add(fvo);
		}
		return fList;
	}
	
	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile); //어떤 형식의 파일인지 Tika가 체크
		return mimeType.startsWith("image")? true : false;
	}
}
