package com.best.kgw.service.impl;

import com.best.kgw.dao.CalendarDao;
import com.best.kgw.service.CalendarService;
import com.vo.CalendarVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CalendarServiceImpl implements CalendarService {
    Logger logger = LoggerFactory.getLogger(CalendarServiceImpl.class);
    @Autowired
    private CalendarDao calendarDao;

    @Override
    public List<Map<String, Object>> calendarList(Map<String, Object> cMap) {
        List<Map<String, Object>> calendarList = null;
        logger.info("Service : calendarList 호출");
        try {
            calendarList = calendarDao.calendarList(cMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return calendarList;
    }

    @Override
    public void insertCalendar(CalendarVO calendarVO) {
        logger.info("Service : insertCalendar 호출");
        try {
            calendarDao.insertCalendar(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteCalList(int calendarNo) {
        logger.info("Service : delCalList 호출");
        try {
            calendarDao.deleteCalendar(calendarNo);
        } catch (Exception e) {
            throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
        }
    }


    @Override
    public void updateCalendar(CalendarVO calendarVO) {
        logger.info("Service : updateCalendar 호출");
        try {
            calendarDao.updateCalendar(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 업데이트 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public List<Map<String, Object>> calList(Map<String, Object> calMap) {
        List<Map<String, Object>> calList = null;
        logger.info("Service : calList 호출");
        try {
            calList = calendarDao.calList(calMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return calList;
    }

    @Override
    public List<Map<String, Object>> myCalList(Map<String, Object> myCalMap) {
        List<Map<String, Object>> myCalList = null;
        logger.info("Service : myCalList 호출");
        try {
            myCalList = calendarDao.myCalList(myCalMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return myCalList;
    }

}
