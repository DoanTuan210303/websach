package com.poly.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ImageService {
	public void saveImage(MultipartFile file, String destinationPath) {
        try {
            // Lấy tên file gốc
            String filename = file.getOriginalFilename();
            
            // Tạo đường dẫn đích
            Path destination = Path.of(destinationPath, filename);
            
            // Sao chép file từ InputStream của file nguồn vào đường dẫn đích
            Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) {
            // Xử lý exception nếu có
        }
    }
}
