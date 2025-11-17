ReViewIt: 감상을 나누는 SNS형 영화·책 후기 앱

영화나 책을 보고 느낀 감상을 공유하고,
다른 사람들의 리뷰 피드를 탐색할 수 있는 SNS형 기록 앱입니다.
본 프로젝트는 Clean Architecture, Riverpod, TDD 접근 방식을 기반으로 구축되어
확장성과 테스트 용이성을 확보한 Flutter 실무형 구조를 목표로 합니다.


1. 프로젝트 목표

   1-1. 확장성 중심의 아키텍처 설계
   * Clean Architecture (Domain-First): 프로젝트를 `features/도메인명`으로 구조화하고,
   각 도메인 내부에 `data`, `domain`, `presentation` 계층을 완벽히 분리하여
   모듈화 및 높은 응집도를 확보한다.
   * Riverpod & DI: Riverpod의 Provider와 `AsyncNotifier`를 활용하여
   모든 의존성(Repository, UseCase)을 명확하게 주입(DI)하고,
   복잡한 비동기 상태를 안정적으로 관리한다.
   * Immutability: `freezed`를 활용하여 모든 데이터 모델 및 상태를 
   불변(Immutable) 객체로 관리하여 데이터의 안정성을 높인다.

    1-2. 실 서비스 환경 시뮬레이션

   * REST API 완전 구현: 실제 서버 없이도 MockAPI를 백엔드로 활용하여 
   RESTful API 호출 구조 (GET, POST, PATCH, DELETE를 완전히 시뮬레이션한다.
   * TDD 접근: Repository, UseCase, ViewModel 계층에 대한 단위 테스트를 완비하여
   비즈니스 로직의 안정성을 입증한다.
   * 핵심 SNS 기능: 피드 조회, 좋아요, 댓글, 팔로우, 페이지네이션 등 SNS의
   핵심 상호작용 기능을 구현한다.


2. Features (예정)
   * 피드 - 모든 리뷰를 시간순으로 표시하는 메인 피드 목록
   * 리뷰 - 영화/책 선택, 평점, 코멘트를 포함한 리뷰 작성/수정/삭제
   * 상호작용 - 각 리뷰에 대한 좋아요/댓글 추가 및 관리
   * SNS 기능 - 사용자간 팔로우/언팔로우 관계 설정, 개인 프로필 페이지
   * 검색 - 제목, 작가, 감독 기반 실시간 검색 기능


3. Architecture
   본 프로젝트는 아래 아키텍처를 따릅니다

    3-1. Clean Architecture
    * Domain - `Entity (freezed)`, `Repository Interface`, `UseCases`
    * Data - `Repository Implementation`, `Data Sources (API Service)`
    * Presentation - `Screens (Widgets)`, `ViewModels (AsyncNotifier)`

    3-2. 기술 스택
    * Flutter
    * flutter_riverpod
    * freezed
    * dio
    * go_router
    * mockito, flutter_test
    * MockAPI
