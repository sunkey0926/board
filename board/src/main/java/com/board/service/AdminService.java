package com.board.service;

import java.util.List;

import com.board.domain.CategoryVO;
import com.board.domain.GoodsVO;
import com.board.domain.GoodsViewVO;
import com.board.domain.OrderListVO;
import com.board.domain.OrderVO;
import com.board.domain.ReplyListVO;

public interface AdminService {

	// 카테고리
	public List<CategoryVO> category() throws Exception;
	
	// 상품등록
	public void register(GoodsVO vo) throws Exception;
	
	// 상품 목록
	public List<GoodsViewVO> goodslist() throws Exception;
	
	// 상품 조회
	//public GoodsVO goodsView(int gdsNum) throws Exception;
	public GoodsViewVO goodsView(int gdsNum) throws Exception;
	
	// 상품 수정
	public void goodsModify(GoodsVO vo) throws Exception;
	
	// 상품 삭제
	public void goodsDelete(int gdsNum) throws Exception;
	
	// 주문 목록
	public List<OrderVO> orderList() throws Exception;
	
	// 특정 주문 목록
	public List<OrderListVO> orderView(OrderVO order) throws Exception;
	
	// 배송 상태
	public void delivery(OrderVO order) throws Exception;
	
	// 상품 수량 조절
	public void changeStock(GoodsVO goods) throws Exception;
	
	// 모든 소감(댓글)
	public List<ReplyListVO> allReply() throws Exception;
	
	// 소감(댓글) 삭제
	public void deleteReply(int repNum) throws Exception;

}
