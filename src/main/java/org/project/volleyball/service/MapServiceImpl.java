package org.project.volleyball.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class MapServiceImpl implements MapService{
	private static final Logger logger = LoggerFactory.getLogger(MapServiceImpl.class);

	@Override
	public Map<String, Double> geocoding(String address) throws Exception{
		String clientID="qza5cn2rsu";
		String clientSecret="KnLaPMOMfs1K2ao48vxBJ31mjJp5b7uVnvmBqMWV";
		String mapurl="https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode";
		
		StringBuilder urlBuilder = new StringBuilder(mapurl); //URL
        urlBuilder.append("?" + URLEncoder.encode("query","UTF-8")+"="+URLEncoder.encode(address,"UTF-8")); //검색주소
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        //request 헤더값 세팅
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type","application/json");
        conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID",clientID);
        conn.setRequestProperty("X-NCP-APIGW-API-KEY",clientSecret);
        logger.info("Response code: " + conn.getResponseCode());
        
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream())); //성공일때
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream())); //에러일때
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        logger.info(sb.toString());
        
		return null;
	}

}
