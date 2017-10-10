package com.pixelware.proyecto;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pixelware.proyecto.model.Temperatura;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/inicio", method = RequestMethod.GET)
	public String inicio(Locale locale, Model model) {

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "inicio";
	}
	
	@RequestMapping(value = "/temperatura", method = RequestMethod.GET)
	public String temperatura(Locale locale, Model model) {


		
		return "temperatura";
		
		

	}
	
	@RequestMapping(value = "/temperatura", method = RequestMethod.POST)
	public String temperaturaPost(@RequestBody String json) throws JsonParseException, JsonMappingException, IOException {


	ObjectMapper mapper = new ObjectMapper();

		//JSON from String to Object
	Temperatura temperatura = mapper.readValue(json, Temperatura.class);
		return "temperatura";
		
		

	}	
	
	
}
