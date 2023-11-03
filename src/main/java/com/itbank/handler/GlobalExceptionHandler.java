package com.itbank.handler;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.servlet.ModelAndView;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;


public class GlobalExceptionHandler {
//    @ExceptionHandler(NullPointerException.class) // 객체가 null인 상태에서 메서드나 필드에 접근할 때 발생하는 예외
//    public ModelAndView handleNullPointerException(NullPointerException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR);
//        mav.addObject("message", "NullPointerException이 발생했습니다.");
//
//        return mav;
//    }
//
//    @ExceptionHandler(IllegalArgumentException.class) // 잘못된 인자가 전달되었을 때 발생하는 예외
//    public ModelAndView handleIllegalArgumentException(IllegalArgumentException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.BAD_REQUEST);
//        mav.addObject("message", "잘못된 인자가 전달되었습니다");
//
//        return mav;
//    }
//
//    @ExceptionHandler(FileNotFoundException.class) // 파일을 찾을 수 없을 때 발생하는 예외
//    public ModelAndView handleFileNotFoundException(FileNotFoundException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.NOT_FOUND);
//        mav.addObject("message", "파일을 찾을 수 없습니다");
//
//        return mav;
//    }
//
//    @ExceptionHandler(NumberFormatException.class) // 숫자로 변환할 수 없는 문자열을 숫자로 변환하려고 할 때 발생하는 예외
//    public ModelAndView handleNumberFormatException(NumberFormatException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.BAD_REQUEST);
//        mav.addObject("message", "숫자 형식이 올바르지 않습니다");
//
//        return mav;
//    }
//
//    @ExceptionHandler(IllegalStateException.class) // 객체의 상태가 메서드 호출에 부적합한 경우 발생하는 예외
//    public ModelAndView handleIllegalStateException(IllegalStateException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR);
//        mav.addObject("message", "잘못된 상태로 인해 예외가 발생했습니다.");
//
//        return mav;
//    }
//
//    @ExceptionHandler(IOException.class) // 입출력 작업 중 문제가 발생했을 때 발생하는 예외
//    public ModelAndView handleIOException(IOException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR);
//        mav.addObject("message", "IOException이 발생했습니다");
//
//        return mav;
//    }
//
//    @ExceptionHandler(SQLException.class) // 데이터베이스 관련 작업 중 문제가 발생했을 때 발생하는 예외
//    public ModelAndView handleSQLException(SQLException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR);
//        mav.addObject("message", "SQLException이 발생했습니다");
//
//        return mav;
//    }
//
//    @ExceptionHandler(HttpServerErrorException.class) // HTTP 서버 오류가 발생했을 때 발생하는 예외
//    public ModelAndView handleHttpServerErrorException(HttpServerErrorException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR);
//        mav.addObject("message", "서버 내부 오류가 발생했습니다");
//
//        return mav;
//    }
//
//    @ExceptionHandler(RuntimeException.class)
//    public ModelAndView handleRuntimeException(RuntimeException e) {
//        ModelAndView mav = new ModelAndView();
//        mav.setViewName("/auth/error");
//        mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR);
//        mav.addObject("message", "내부 서버 오류가 발생했습니다");
//
//        return mav;
//    }


}
