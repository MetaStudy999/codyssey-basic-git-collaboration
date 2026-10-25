> **2026-10-25 신규 미션 작성 경로(B2-2):** [`training/round-04-agent/`](training/round-04-agent/README.md) — 신규 코드는 `training/round-04-agent/04-src/`에만 작성합니다. 기존 Round 01~03 및 루트의 내용은 과거 수행·참고 이력으로 보존합니다. **현재 새 Round는 PLAN_ONLY / NOT_STARTED이며 사용자 개발 승인 전 코드 실행·수정·배포 금지**입니다. 중앙 기준: [15개 미션 신규 실행 허브](https://github.com/MetaStudy999/codyssey-basic/tree/main/training/round-04-agent).

# Codyssey Basic B2-2 — 친구 3~5명과 함께 프로그램 만드는 법 연습하기

## 현재 훈련 상태

- 구분: **필수 미션 (REQUIRED)**
- Round: **R01 — CLEAR**
- 전역 운영 단계: **Phase C — FAST EXECUTE / Runtime**
- B2-2 Workcell 상태: **🟡 ACTIVE**
- Phase A Reference 상태: **CORE READY**
- 실제 팀 GitHub Runtime/Evidence: **🟡 PENDING / 아직 최종 검증 전**
- 5계정 학습 Simulation: **Documentation Ready / Runtime 미실행**
- CLEAR: **아님**

B2-2는 실제 팀 협업 기록이 핵심입니다. Phase A의 Reference Build는 이미 준비되었고, 현재는 Phase C에서 실제 팀 활동과 별도의 5계정 학습 Simulation을 진행할 수 있는 상태입니다. Reference 문서나 Simulation 결과를 실제 팀 PR/Review/Conflict Evidence로 대체하지 않습니다.

## 공식 원본

- `b2-2-mission.pdf`
- `b2-2-mission.md`
- `b2-2-evaluation.md`

공식 원본은 수정하지 않습니다.

## 시작 위치

1. `training/round-01-clear/START-CHECK.md` — 시작 전 Git/GitHub 개념 자가진단
2. `training/round-01-clear/BEGINNER-GUIDE.md` — Quick Start + 전체 학습 지도
3. `training/round-01-clear/environment/README.md` — MAC-V/WIN-V 실행환경 진입
4. `training/round-01-clear/environment/MULTI-ACCOUNT-SIMULATION.md` — 5계정 Simulation 기준
5. `training/round-01-clear/REFERENCE-STATUS.md` — Phase A Reference 상태
6. `training/round-01-clear/reference/team-repo/` — 실제 팀 저장소용 skeleton
7. `training/round-01-clear/docs/github-runtime-audit.md` — 실제 GitHub 서버 기록 검증
8. `training/round-01-clear/CHECKLIST.md` — Mission/Evaluation/CLEAR Gate

## 입문자 문서 구조

B2-2의 입문자 문서는 Control Tower와 B1-1의 3계층 정보 구조를 적용합니다.

```text
LEVEL 1 — BEGINNER-GUIDE.md
Quick Start / 전체 지도 / 상태 / 핵심 링크
        ↓
LEVEL 2 — guide/<module>/README.md
모듈 목적 / Local TOC / 완료 조건 / 이전·다음
        ↓
LEVEL 3 — guide/<module>/<unit>.md
실제 개념 / 명령 / 정상 결과 / 오류 / 완료 확인
```

환경 상세 명령은 `training/round-01-clear/environment/`를 Source of Truth로 유지하고, `guide/01-environment-identity/`에서는 중복 복제하지 않습니다.

## Reference Team Repository

```text
reference/team-repo/
├── README.md
├── SUBMISSION.md
├── .github/
│   ├── pull_request_template.md
│   └── ISSUE_TEMPLATE/task.md
├── docs/
│   ├── CONTRIBUTING.md
│   ├── conflict-resolution.md
│   └── troubleshooting-log.md
└── src/README.md
```

`TODO_RUNTIME`은 실제 팀의 Issue/PR/Review/Conflict/Commit 링크로만 교체합니다.

## Runtime 최소 기준

### 팀/저장소

- 3~5명
- 팀 저장소 1개
- main Branch Protection/Ruleset
- main 직접 push 금지
- PR + 최소 1명 approve

### 팀원별 전원

- merged PR 2+
- 본인 제외 Review 2+
- 본인 PR feedback 반영 1+
- 간단 결과물 contribution commit 1+
- troubleshooting 기록 참여 1+

### 팀 전체

- conflict 2+, non-trivial 1+
- amend / reset --soft / revert / stash-pop 4종
- 협업 문서 3종
- 실제 SUBMISSION index
- 실제 git graph

## 핵심 협업 흐름

```text
Issue
→ feature/*
→ 의미 있는 commit
→ PR (Closes/Fixes #n + What/Why/How)
→ 실질 Review
→ 작성자 feedback 반영
→ approve
→ main merge
→ Evidence
→ Evaluation
```

## 5계정 학습 Simulation

동일한 GitHub 학습 계정 5개를 MAC-V와 WIN-V에서 공통으로 사용합니다.

```text
MAC-V
학교 공용 Mac → OrbStack → Ubuntu 24.04 `codyssey`
→ Linux User codyssey01~05

WIN-V
Windows 11 Pro → WSL2 → Ubuntu 24.04
→ Linux User codyssey01~05
```

GitHub Account A~E를 `codyssey01`~`codyssey05`에 1:1로 고정하고 `gh` + HTTPS를 기본 인증 방식으로 사용합니다.

```text
Simulation PASS ≠ Runtime Mission PASS
Simulation Evidence ≠ 실제 팀 Evidence
Simulation CLEAR ≠ B2-2 Mission CLEAR
```

## Reference 자체감사에서 보강한 점

- 로컬 Git과 GitHub 서버 메타데이터 검증을 분리
- Branch Protection/PR/Review/Issue linkage는 `github-runtime-audit.md`로 실제 확인
- 팀 전체 합계가 아니라 팀원별 최소 수량을 검증
- Review는 개수뿐 아니라 실질 내용과 author interaction을 사람이 확인
- conflict는 문서 주장만이 아니라 실제 PR/commit과 연결
- shared history는 revert 우선, 무합의 force push/rebase 금지
- `environment/verify.sh`가 Reference template/policy/TODO/local Runtime 구조를 점검

## CLEAR 원칙

```text
Phase A Reference Build  = ✅ CORE READY
B2-2 Workcell            = 🟡 ACTIVE
실제 팀 Runtime/Evidence = 🟡 PENDING / 최종 검증 전
Mission CLEAR            = ❌ 아직 아님
```

실제 3~5인 팀 GitHub 활동과 팀원별 최소 수량, conflict/troubleshooting, GitHub 서버 설정, Evidence가 모두 확인된 경우에만 `✅ CLEAR`로 변경합니다.
