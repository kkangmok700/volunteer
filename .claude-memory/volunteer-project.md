# SHU Volunteer 2026 - 프로젝트 기록

## 기본 정보
- **레포**: https://github.com/kkangmok700/volunteer
- **로컬 경로**: `C:\Users\USER\Desktop\`
- **배포 URL**: https://kkangmok700.github.io/volunteer/
- **스택**: 순수 HTML/CSS/JS (프레임워크 없음), Supabase (클라우드 DB), GitHub Pages (호스팅)

## 파일 구조
```
Desktop/
├── index.html                  # 랜딩 페이지 (3개 페이지 링크)
├── 사회봉사단.html              # 대시보드 (localStorage, Supabase 미사용)
├── 사회봉사단_신청서.html        # 참여 신청서 (Supabase 연동)
├── 사회봉사단_관리자.html        # 관리자 페이지 (Supabase 연동, QR코드)
├── supabase_setup.sql           # DB 테이블 생성 SQL
├── .gitignore                   # 바탕화면 잡파일 제외
└── .github/workflows/deploy.yml # GitHub Pages 자동 배포
```

## Supabase 설정
- **Project URL**: `https://qikbmhabsktpoogzxflc.supabase.co`
- **Anon Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFpa2JtaGFic2t0cG9vZ3p4ZmxjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI2MDY0MjIsImV4cCI6MjA4ODE4MjQyMn0.pDgBMhE-9Fo810hrI8bzJPpnstumbLdwIHo_O3IHS5Q`
- **RLS**: 전체 public (모든 테이블 읽기/쓰기 허용)
- **테이블**: participants, volunteer_groups, schedules, budget, announces, applications, logs

## 관리자 로그인
- ID: `admin` / PW: `shu2026` (localStorage 기반, 설정에서 변경 가능)

## 배포 구조
```
git push → GitHub Actions (deploy.yml) → GitHub Pages 자동 배포
```
- Source: GitHub Actions
- 트리거: push to main + workflow_dispatch (수동 실행 가능)
- cancel-in-progress: true (연속 push 시 이전 배포 취소)

## 작업 이력 (2026-03-04)
1. 초기 커밋 - HTML 3개 파일 (dddf482)
2. Supabase DB 연동 (8c535f2)
3. GitHub Pages 배포 설정 - deploy.yml, index.html 추가 (9d22b9a)
4. .gitignore 추가 (6b90774)
5. workflow_dispatch 트리거 추가 (637566a)
6. Supabase anon key 수정 - 잘못된 키를 올바른 JWT로 교체 (5457f7e)
7. QR코드 한글 파일명 인코딩 수정 - encodeURIComponent 적용 (2bca302)

## 해결한 이슈
- **Pages 활성화**: Private 레포에서는 Pages 사용 불가 → Public으로 변경하여 해결
- **Supabase 키 오류**: `sb_publishable_...` 형식이었던 키를 올바른 JWT anon key로 교체
- **QR코드 한글 인코딩**: 한글 파일명이 QR에 그대로 들어가 오류 → encodeURIComponent로 수정

## 주의사항
- `사회봉사단.html` (대시보드)은 아직 Supabase 미연동 (하드코딩 데이터 + localStorage)
- 바탕화면이 Git 레포라서 .gitignore로 .lnk, .bak, .jpg 등 제외 필수
- Supabase anon key가 HTML에 하드코딩 (public repo이므로 공개됨, anon key라 보안상 OK)
