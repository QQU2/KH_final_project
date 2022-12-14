package com.web.home.course.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.home.account.model.AccountDTO;
import com.web.home.course.model.CourseDTO;
import com.web.home.course.model.Curriculum_bigDTO;
import com.web.home.course.model.Curriculum_smallDTO;
import com.web.home.course.model.FileInfoDTO;
import com.web.home.course.service.CourseRestService;
import com.web.home.course.service.LessonUploadService;

@Controller
@SuppressWarnings("unchecked")
@RequestMapping(value ="/course/upload")
public class LessonUploadController {

	@Autowired
	private LessonUploadService service;
	
	@GetMapping(value = "/lessonInfo")
	public String uploadLessonInfo(Model model, HttpSession session,
							 @RequestParam(defaultValue = "1") int page) {
		if(session.getAttribute("lessonData") != null) {
			CourseDTO lessonData = (CourseDTO)session.getAttribute("lessonData");
			model.addAttribute("lessonData", lessonData);
		}
		
		model.addAttribute("page", page);
		return "course/lessonUpload";
	}
	
	@GetMapping(value = "/curriInfo")
	public String uploadCurriInfo(Model model, HttpSession session,
							 @RequestParam(defaultValue = "2") int page) {
		if(session.getAttribute("curri_big_list") != null && session.getAttribute("curri_small_list") != null) {
			List<Curriculum_bigDTO> curri_big_list = (List<Curriculum_bigDTO>) session.getAttribute("curri_big_list");
			List<Curriculum_smallDTO> curri_small_list = (List<Curriculum_smallDTO>) session.getAttribute("curri_small_list");
			
			model.addAttribute("curri_big_list", curri_big_list);
			model.addAttribute("curri_small_list", curri_small_list);
		}
		
		model.addAttribute("page", page);
		return "course/lessonUpload";
	}
	
	@GetMapping(value = "/fileInfo")
	public String uploadFileInfo(Model model, HttpSession session,
							 @RequestParam(defaultValue = "3") int page) {
		//?????? ????????? ?????? ???
		if(session.getAttribute("ALL_files") != null) {
			List<FileInfoDTO> ALL_files = (List<FileInfoDTO>) session.getAttribute("ALL_files");
			model.addAttribute("ALL_files", ALL_files);
		}
		//???????????? ????????? ?????? ???
		if(session.getAttribute("curri_big_list") != null && session.getAttribute("curri_small_list") != null) {
			List<Curriculum_bigDTO> curri_big_list = (List<Curriculum_bigDTO>) session.getAttribute("curri_big_list");
			List<Curriculum_smallDTO> curri_small_list = (List<Curriculum_smallDTO>) session.getAttribute("curri_small_list");
			
			model.addAttribute("curri_big_list", curri_big_list);
			model.addAttribute("curri_small_list", curri_small_list);
		}
		model.addAttribute("page", page);
		return "course/lessonUpload";
	}
	
	@ResponseBody
	@PostMapping(value = "/uploadLessonInfo", produces = "application/json; charset=utf-8")
	public String uploadLessonInfo(HttpServletRequest request, HttpSession session,
							   @SessionAttribute("loginData") AccountDTO accountDto,
							   @RequestBody CourseDTO courseDto) {
		JSONObject json = new JSONObject();
		if(courseDto != null) {
			courseDto.setL_wid(accountDto.getAC_ID());
			courseDto.setL_catid(6);
			courseDto.setL_content(courseDto.getL_content().replace("\r", "\\r").replace("\n", "\\n"));
			
			session.setAttribute("lessonData", courseDto);
			
			json.put("code", "success");
		}else {
			json.put("code", "noData");
		}
		
		return json.toJSONString();
	}
	@ResponseBody
	@PostMapping(value = "/uploadLessonCurri", produces = "application/json; charset=utf-8")
	public String uploadLessonCurri(HttpServletRequest request, HttpSession session,
									@RequestBody String curri_big,
									@RequestBody String curri_small) {
		//????????????- chapter, ?????? ?????? ??????
		Curriculum_bigDTO[] arrayBig = new Gson().fromJson(String.valueOf(curri_big), Curriculum_bigDTO[].class);
		List<Curriculum_bigDTO> curri_big_list =  Arrays.asList(arrayBig);
		
		Curriculum_smallDTO[] arraySmall = new Gson().fromJson(String.valueOf(curri_small), Curriculum_smallDTO[].class);
		List<Curriculum_smallDTO> curri_small_list = Arrays.asList(arraySmall);
		
//		for(Curriculum_bigDTO Curriculum_bigDto : curri_big) {
//			System.out.println(Curriculum_bigDto);
//		}
//		for(Curriculum_smallDTO Curriculum_smallDto : curri_small) {
//			System.out.println(Curriculum_smallDto);
//		}
		
		JSONObject json = new JSONObject();
		
		session.setAttribute("curri_big_list", curri_big_list);
		session.setAttribute("curri_small_list", curri_small_list);
		return json.toJSONString();
	}
	@ResponseBody 
	@PostMapping(value = "/lessonFiles", produces = "application/json; charset=utf-8")
	public String uploadlessonFiles(HttpServletRequest request, HttpSession session,
								   @SessionAttribute("loginData") AccountDTO accountDto,
								   @RequestParam("lessonFile") List<MultipartFile> files) 
									throws IOException{
		/*
		 * ?????? ?????????(????????????) - ?????????, ?????? uuid, ??????????????????, ??????url, ?????? ?????????, ?????? ??????, 
		 * ?????? ????????????, ?????? ????????????
		 */
		String teacher = accountDto.getAC_ID();
		String realPath = request.getServletContext().getRealPath("/resources/course/") + teacher;
		String url = request.getServletContext() + "/static/img/course/";
		
		//??????
		//session.removeAttribute("ALL_files");
		List<FileInfoDTO> ALL_files = new ArrayList<FileInfoDTO>();
		if(session.getAttribute("ALL_files") != null) {
			ALL_files = (List<FileInfoDTO>) session.getAttribute("ALL_files");
		}
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		if(files.size() > 0 && !files.get(0).getOriginalFilename().isBlank()) {
			for(MultipartFile file: files) {
				FileInfoDTO fileInfo = service.uploadFiles(file, realPath, url);
				
				ALL_files.add(fileInfo);
			}
		}
		session.setAttribute("ALL_files", ALL_files);
		System.out.println(session.getAttribute("ALL_files"));
		
		
		return gson.toJson(ALL_files);
	}
	
	@PostMapping(value = "/uploadLesson_final")
	public String uploadLesson_final(HttpSession session, Model model, 
									HttpServletRequest request,
									@RequestParam("thumbnail") MultipartFile thumbnail) {
		
		//?????? ?????? ???????????? db??? ????????????
		if(session.getAttribute("lessonData") != null) {
			CourseDTO lessonData = (CourseDTO)session.getAttribute("lessonData");
			
			boolean result = service.uploadLessonInfo(lessonData, thumbnail, request);
			if(result) {
				session.removeAttribute("lessonData");
				model.addAttribute("lessonInfoUploadSuccess", "???????????? ???????????? ?????????????????????.");
			}else {
				model.addAttribute("lessonInfoUploadFail", "???????????? ???????????? ?????????????????????.");
			}
			
		}
		
		//???????????? ?????? ???????????? db??? ????????????
		if(session.getAttribute("curri_big_list") != null && session.getAttribute("curri_small_list") != null) {
			List<Curriculum_bigDTO> curri_big_list = (List<Curriculum_bigDTO>) session.getAttribute("curri_big_list");
			List<Curriculum_smallDTO> curri_small_list = (List<Curriculum_smallDTO>) session.getAttribute("curri_small_list");
			
			int result = service.uploadCurriInfo(curri_big_list, curri_small_list);
			if(result == 1) {
				session.removeAttribute("curri_big_list");
				session.removeAttribute("curri_small_list");
				
				model.addAttribute("lessonCurriInfoUploadSuccess", "?????? ???????????? ?????? ???????????? ?????????????????????.");
			}else {
				
				model.addAttribute("lessonCurriInfoUploadFail", "?????? ???????????? ?????? ???????????? ?????????????????????.");
			}
			
		}
		//?????? ?????? ???????????? ????????? ???????????? db??? ????????????
		if(session.getAttribute("ALL_files") != null) {
			CourseDTO lessonData = (CourseDTO)session.getAttribute("lessonData");
			List<FileInfoDTO> ALL_files = (List<FileInfoDTO>) session.getAttribute("ALL_files");
			boolean result = service.uploadFileInfo(ALL_files, lessonData);
		}
				
		return "";
	}
}
