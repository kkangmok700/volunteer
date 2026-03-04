-- ===== 사회봉사단 관리 시스템 테이블 생성 =====

-- 참여자
CREATE TABLE participants (
  id BIGSERIAL PRIMARY KEY,
  no INTEGER NOT NULL,
  dept TEXT NOT NULL,
  name TEXT NOT NULL,
  student_id TEXT NOT NULL
);

-- 단체
CREATE TABLE volunteer_groups (
  id BIGSERIAL PRIMARY KEY,
  no INTEGER NOT NULL,
  dept TEXT NOT NULL,
  name TEXT NOT NULL,
  member_count INTEGER NOT NULL
);

-- 일정
CREATE TABLE schedules (
  id BIGSERIAL PRIMARY KEY,
  week TEXT,
  period TEXT,
  date DATE,
  content TEXT NOT NULL,
  detail TEXT,
  month INTEGER
);

-- 예산
CREATE TABLE budget (
  id BIGSERIAL PRIMARY KEY,
  category TEXT NOT NULL CHECK (category IN ('overseas', 'domestic')),
  name TEXT NOT NULL,
  amount BIGINT NOT NULL
);

-- 공지사항
CREATE TABLE announces (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  pinned BOOLEAN DEFAULT FALSE,
  created_at TEXT NOT NULL
);

-- 참여 신청서
CREATE TABLE applications (
  id BIGSERIAL PRIMARY KEY,
  app_id TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  student_id TEXT NOT NULL,
  dept TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  motivation TEXT,
  overseas_exp TEXT,
  passport TEXT,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  applied_at TEXT NOT NULL,
  reviewed_at TEXT,
  review_note TEXT
);

-- 활동 로그
CREATE TABLE logs (
  id BIGSERIAL PRIMARY KEY,
  time TEXT NOT NULL,
  type TEXT NOT NULL,
  message TEXT NOT NULL
);

-- ===== RLS 비활성화 (공개 접근 허용) =====
ALTER TABLE participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE volunteer_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE budget ENABLE ROW LEVEL SECURITY;
ALTER TABLE announces ENABLE ROW LEVEL SECURITY;
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE logs ENABLE ROW LEVEL SECURITY;

-- 모든 테이블에 공개 접근 정책 추가
CREATE POLICY "Allow all" ON participants FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON volunteer_groups FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON schedules FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON budget FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON announces FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON applications FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON logs FOR ALL USING (true) WITH CHECK (true);

-- ===== 기본 데이터 삽입 =====

-- 참여자 기본 데이터
INSERT INTO participants (no, dept, name, student_id) VALUES
(1,'간호학과','권우석','202210003'),
(2,'간호학과','양예원','202310068'),
(3,'간호학과','이수정','202310084'),
(4,'간호학과','김예진','202310512'),
(5,'간호학과','이서진','202310523'),
(6,'간호학과','권은서','202410005'),
(7,'간호학과','김윤지','202410025'),
(8,'간호학과','박세영','202410046'),
(9,'간호학과','서지윤','202410062'),
(10,'간호학과','이선우','202410097'),
(11,'간호학과','조예지','202410124'),
(12,'간호학과','지수아','202410132'),
(13,'간호학과','박윤아','202410522'),
(14,'간호학과','김도희','202510012'),
(15,'간호학과','김드보라','202510013'),
(16,'간호학과','김시라','202510020'),
(17,'간호학과','문지현','202510041'),
(18,'간호학과','박나은','202510042'),
(19,'간호학과','양아연','202510075'),
(20,'간호학과','정민재','202510122'),
(21,'뷰티융합과','김하은','202510259'),
(22,'사회복지과','전창인','202310383'),
(23,'의료정보과','김나현','202510595'),
(24,'치위생과','최은서','202310238'),
(25,'치위생과','허윤지','202310240'),
(26,'치위생과','김서진','202410165'),
(27,'치위생과','김서현','202410166'),
(28,'치위생과','박한경','202410187'),
(29,'치위생과','윤희진','202410204'),
(30,'치위생과','정민서','202410221');

-- 단체 기본 데이터
INSERT INTO volunteer_groups (no, dept, name, member_count) VALUES
(1,'간호학과','천사랑',47),
(2,'간호학과','사랑나눔',44),
(3,'치위생과','다솜누리',41);

-- 일정 기본 데이터
INSERT INTO schedules (week, period, date, content, detail, month) VALUES
('사전','2월','2026-02-01','국가 선정','사회봉사운영위원회 - 국가, 인솔자수, 학생수, 예산(자부담금) 결정',2),
('1)','2월 23일(월)~27일(목)','2026-02-23','인솔자 선정(학과, 연합)','교수: 학과별 인솔교수 공문발송 및 수신
직원: 지원모집 안내(슈톡)',2),
('2)','3월 3일(수)~15일(일)','2026-03-03','학생 모집','학과별 공문발송, 홈페이지/LMS 팝업 홍보',3),
('3)','3월 10일(화) 5,6교시','2026-03-10','채플 발표','2025 SHU Volunteer 동계 봉사대(오만,대만) 홍보
2026-1학기 학생모집 홍보',3),
('4)','3월 16일(월)~20일(금)','2026-03-16','학생 면접','면접장소 섭외, 면접 지원',3),
('5)','3월 23일(월)~24일(화)','2026-03-23','사회봉사위원회 결의 / 입찰','인솔교수명, 학생명, 발대식 일정 결정
소기 사이즈, 수량 사전 조사',3),
('6)','5월 13일(수)~15일(금)','2026-05-13','발대식, 안전교육','학생물품 사전조사 지원(상의)',5),
('7)','5월 18일(월)~22일(금)','2026-05-18','MISSION WEEK 봉사 활동','해외봉사 현장 활동',5),
('8)','13주 이후','2026-06-15','봉사 활동 만족도 조사','만족도 조사 실시, 안교 및 2학기 채플 발표 준비',6);

-- 예산 기본 데이터
INSERT INTO budget (category, name, amount) VALUES
('overseas','학기 중 봉사대 (6학과 x 20,000,000)',120000000),
('overseas','방학 중 봉사대 (3국가 x 25,000,000)',75000000),
('overseas','발대식 소모품',8000000),
('overseas','운영비',2000000),
('overseas','대사협 연회비',1500000),
('domestic','운영비 (교통비, 식대 등)',6000000),
('domestic','현수막 제작 및 소모품',4000000);
