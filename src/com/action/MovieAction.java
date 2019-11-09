package com.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.LanguageType;
import com.bean.Movie;
import com.bean.MovieType;
import com.service.LanguageTypeService;
import com.service.MovieService;
import com.service.MovieTypeService;
import com.util.PageAssistant;

@Controller
@RequestMapping("movie")
public class MovieAction {

	@Resource
	private MovieService movieService;

	@Resource
	private LanguageTypeService languageTypeService;

	@Resource
	private MovieTypeService moiveTypeService;

	/**
	 * 查询所有影片
	 * 
	 * @return
	 */
	@RequestMapping("query")
	public String query(Movie m, String name, PageAssistant<Movie> pa, HttpSession session) {

		Map<String, Object> map = new HashMap<>();

		if (name != null && name != "") {
			map.put("keyword", name);
		}

		if (m != null) {
			map.put("id", m.getId());
		}

		// 设置总记录数
		pa.setCount(movieService.count(map));

		map.put("size", pa.getPageSize());
		map.put("start", pa.getStart());

		pa.setItems(movieService.select(map));

		session.setAttribute("pa", pa);
		session.setAttribute("keyword", name);

		return "redirect:/movieList.jsp";
	}

	/**
	 * 查询单个影片信息
	 */
	@RequestMapping("unique")
	public String unique(Movie m,int choose, HttpSession session) {

		// 查询当前单个影片的信息
		Movie movie = movieService.unique(m);

		// 查询当前影片的语言类型
		String language = movie.getlTid();
		String[] ltArr = language.split(",");
		List ltList = new ArrayList();
		LanguageType lt = new LanguageType();
		for (int i = 0; i < ltArr.length; i++) {
			lt.setId(Integer.parseInt(ltArr[i]));
			ltList.add(languageTypeService.unique(lt).getType());
		}

		// 查询当前影片的影片类型
		String movieType = movie.getmTid();
		String[] mtArr = movieType.split(",");
		List mtList = new ArrayList();
		MovieType mt = new MovieType();
		for (int i = 0; i < mtArr.length; i++) {
			mt.setId(Integer.parseInt(mtArr[i]));
			mtList.add(moiveTypeService.unique(mt).getName());
		}

		session.setAttribute("language", ltList.toString());
		session.setAttribute("movieType", mtList.toString());
		session.setAttribute("movie", movie);
		
		if (choose == 0) {
			return "redirect:/movieInfo.jsp";
		}
		return "redirect:/movieUpdate.jsp";
	}

	/**
	 * 新增影片信息
	 * 
	 * @return
	 */
	@RequestMapping("add")
	@ResponseBody
	public String add(Movie m,String timeStr,String expiringDateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		
		Date time;

			try {
				//处理上映时间
				time = sdf.parse(timeStr);
				m.setTime(time);
				
				//处理版权到期时间
				time = sdf.parse(expiringDateStr);
				m.setExpiringDate(time);

				//显示当前m对象值
				System.out.println(m.toString());
				
				//执行添加
				movieService.add(m);
				
				
			} catch (ParseException e) {
				e.printStackTrace();
				return "2";
			}
			
			return "1";
		
	}

	/**
	 * 删除影片信息
	 * 
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Movie m) {
		try {
			m.setCondition(Byte.parseByte("0"));
			movieService.update(m);
			return "1";
		} catch (Exception e) {
			return "2";
		}
		
	}
	
	
	/**
	 * 修改影片信息
	 * 
	 * @return
	 */
	@RequestMapping("update")
	@ResponseBody
	public String update(Movie m) {
			
		movieService.update(m);
		
		return "1";
	}

}
