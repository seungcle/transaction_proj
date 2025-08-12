# 🛒 Auction Marketplace Project 

이 프로젝트는 **경매 방식의 중고 거래 플랫폼**을 Java 기반으로 구현하기 위한 저장소입니다.  

---

## 📌 프로젝트 개요

- **목표**: 경매 방식의 중고 거래 사이트 구현
- **백엔드 기술 스택**
  - Java 17+
  - Servlet/JSP

- **데이터베이스**
  - Oracle Database 

- **주요 기능**
  - 회원 가입/로그인/프로필
  - 경매 물품 등록 / 이미지 업로드
  - 입찰 / 낙찰 처리
  - 찜 / 문의(Q&A)
  - 경매 공개 채팅 / 1:1 채팅
  - 알림(Notification)
  - 리뷰 / 장점 키워드 기반 평판

---

## 🗄 데이터베이스 설계

### 주요 테이블
| 테이블 | 설명 |
|--------|------|
| `user` | 회원 정보 |
| `category` | 카테고리 마스터 |
| `address` | 회원 주소 |
| `item` | 경매 물품 |
| `item_image` | 물품 이미지 |
| `bid` | 입찰 내역 |
| `transaction` | 거래 정보 |
| `favorite` | 찜 |
| `review` | 리뷰(별점/후기) |
| `review_tag` | 장점 키워드 |
| `tag` | 리뷰-태그 매핑 |
| `dm_chat_room` | 1:1 채팅방 |
| `dm_chat_message` | 1:1 채팅 메시지 |
| `auction_chat_room` | 경매 공개 채팅방 |
| `auction_chat_message` | 경매 채팅 메시지 |
| `notification` | 알림 |

---
