# B2-2 SIM-5 — MAC-V Evidence

> **TRAINING SIMULATION — NOT OFFICIAL B2-2 EVIDENCE**

이 디렉터리는 학교 공용 Mac → OrbStack → Ubuntu 24.04 `codyssey` → Linux User 5개 환경에서 수행하는 **5계정 학습 Simulation** 기록용입니다.

공식 B2-2 실제 팀 Evidence와 혼합하지 않습니다.

## Runtime 구조

```text
MAC-V
학교 공용 Mac
→ OrbStack
→ Ubuntu 24.04 `codyssey`
→ codyssey01~05
→ GitHub Account A~E
```

## 기록 가능한 항목

- OrbStack/Ubuntu 24.04 확인 결과
- Control Tower Bootstrap 결과
- `codyssey01`~`codyssey05` 사용자 구조 검증
- Identity Gate 5/5 결과
- Simulation Repository URL
- Simulation Issue / PR / Review / Merge 기록
- Simulation conflict / troubleshooting 기록
- MAC-V Closeout 결과

## 금지

- Token/Password/Private Key 실제 값 저장
- `gh auth token` 출력 저장
- Simulation 기록을 `evidence/actual/`로 복사해 공식 Evidence처럼 사용
- 실행하지 않은 항목을 PASS로 미리 작성

## 상태

2026-09-04 실제 `mac-v-orchestrate.sh --prepare` 실행에서 Host/CORE 준비 묶음이 PASS했습니다. 현재 확인된 범위는 OrbStack, `codyssey` Ubuntu 24.04, Control Tower Bootstrap, B2-2 Repository, `codyssey01`~`codyssey05`, HOME/Workspace 구조입니다.

```text
Documentation Ready = ✅
Host / CORE Prep    = ✅ PASS
Identity Gate       = ⬜ NOT RUN
Simulation Repo     = ⬜ NOT RUN
Simulation          = ⬜ NOT RUN
Mission CLEAR       = ❌ 아님
```

상세 기록:

- [`CORE-PREP-2026-09-04.md`](CORE-PREP-2026-09-04.md)

실제 수행 결과가 생길 때만 다음 상태를 갱신합니다.
