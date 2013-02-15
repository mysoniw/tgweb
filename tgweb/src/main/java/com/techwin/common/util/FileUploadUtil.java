package com.techwin.common.util;

import java.io.File;
import java.io.FileOutputStream;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {
	
//	private final static Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);

	public static String fileUpload(String fileDir, String fileName, MultipartFile file) throws Exception {

		if (fileName == null || "".equals(fileName)) {
			throw new Exception("fileName null");
			//return ""; 
		}

//		File destinationDir = new File((String)prop.getObject().get("support.file.path") + fileDir);
		File destinationDir = new File(fileDir);

		if (!destinationDir.exists()) {
			destinationDir.mkdirs();
		}

		File destination = new File(destinationDir + "/" + fileName);

		// 기존에 존재 파일시
		int dotIdx = fileName.lastIndexOf(".");
		String fileHead = null;
		String extension = null;
		
		if (dotIdx > -1) {
			fileHead = fileName.substring(0, dotIdx);
			extension = fileName.substring(dotIdx, fileName.length());
		} else {
			fileHead = fileName;
		}
		
		int i = 1;
		while (destination.exists()) {
			if (dotIdx > -1) {
				fileName = fileHead + " (" + i++ + ")" + extension;
			} else {
				fileName = fileHead + " (" + i++ + ")";
			}
			destination = new File(destinationDir + "/" + fileName);
		}

		destination.createNewFile();
		FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(destination));

		return fileName;
	}
}
