package com.board.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.CategoryVO;
import com.board.domain.GoodsVO;
import com.board.domain.GoodsViewVO;
import com.board.domain.MemberVO;
import com.board.domain.OrderListVO;
import com.board.domain.OrderVO;
import com.board.domain.ReplyListVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession sql;
	
	private static String namespace = "adminMapper";

	// 카테고리
	@Override
	public List<CategoryVO> category() throws Exception {
		return sql.selectList(namespace + ".category");
	}

	// 상품등록
	@Override
	public void register(GoodsVO vo) throws Exception {
		sql.insert(namespace + ".register", vo);
	}

	// 상품 목록
	@Override
	public List<GoodsViewVO> goodslist() throws Exception {
		return sql.selectList(namespace + ".goodslist");
	}

	// 상품 조회
	@Override
	public GoodsViewVO goodsView(int gdsNum) throws Exception {
		return sql.selectOne(namespace + ".goodsView", gdsNum);
	}

	// 상품 수정
	@Override
	public void goodsModify(GoodsVO vo) throws Exception {
		sql.update(namespace + ".goodsModify", vo);
	}

	// 상품삭제
	@Override
	public void goodsDelete(int gdsNum) throws Exception {
		sql.delete(namespace + ".goodsDelete", gdsNum);
	}
	
	// 주문 목록
	@Override
	public List<OrderVO> orderList() throws Exception {
		return sql.selectList(namespace + ".orderList");
	}

	// 특정 주문 목록
	@Override
	public List<OrderListVO> orderView(OrderVO order) throws Exception {
		return sql.selectList(namespace + ".orderView", order);
	}

	// 배송 상태
	@Override
	public void delivery(OrderVO order) throws Exception {
		sql.update(namespace + ".delivery", order);
		
	}

	// 상품 수량 조절
	@Override
	public void changeStock(GoodsVO goods) throws Exception {
		sql.update(namespace + ".changeStock", goods);
	}

	// 모든 소감(댓글)
	@Override
	public List<ReplyListVO> allReply() throws Exception {
		return sql.selectList(namespace + ".allReply");
	}

	// 댓글 삭제
	@Override
	public void deleteReply(int repNum) throws Exception {
		sql.delete(namespace + ".deleteReply", repNum);
	}
	


}
