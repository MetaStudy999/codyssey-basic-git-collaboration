# B2-2 R01 — 5계정 학습 Simulation Hub

> **TRAINING SIMULATION — NOT OFFICIAL B2-2 EVIDENCE**

이 디렉터리는 B2-2의 Git/GitHub 협업 흐름을 동일한 GitHub 학습 계정 5개로 반복 훈련하기 위한 전용 영역입니다.

```text
실제 B2-2 Mission
≠ 5계정 Simulation
```

Simulation에서 만든 Issue/PR/Review/Conflict/Troubleshooting 기록은 학습 증빙이며, 실제 3~5인 팀의 공식 Evidence를 대체하지 않습니다.

## 빠른 시작(Quick Start)

```text
MAC-V Identity Gate 5/5
→ 별도 Simulation Repository 확정
→ 사용자별 독립 clone 5개
→ MAC-V Simulation Runbook
→ Issue/PR/Review/Feedback
→ Conflict 2+
→ Troubleshooting 4종
→ Simulation Verification
→ Evidence index
```

현재 우선 경로:

- [`mac-v/README.md`](mac-v/README.md)
- [`mac-v/TASK-MATRIX.md`](mac-v/TASK-MATRIX.md)
- [`mac-v/CONFLICT-AND-TROUBLESHOOTING-LAB.md`](mac-v/CONFLICT-AND-TROUBLESHOOTING-LAB.md)

환경 구축은 별도 Source of Truth를 사용합니다.

- [`../environment/mac-v/RUN-NOW.md`](../environment/mac-v/RUN-NOW.md)

## Repository 정책

Simulation Repository는 다음과 분리하는 것을 기본으로 합니다.

```text
B2-2 Reference/Training Repository
MetaStudy999/codyssey-basic-git-collaboration

실제 팀 Repository
실제 3~5인 팀이 사용하는 별도 Repository

5계정 Simulation Repository
학습용 별도 Repository
```

Reference Repository 또는 실제 팀 Repository를 편의상 Simulation 저장소로 재사용하지 않습니다. 저장소가 정해지기 전에는 Issue/PR을 자동 생성하지 않습니다.

## 공통 계정 매핑

| Linux User | GitHub Account |
|---|---|
| `codyssey01` | A |
| `codyssey02` | B |
| `codyssey03` | C |
| `codyssey04` | D |
| `codyssey05` | E |

동일한 A~E를 MAC-V와 WIN-V에서 공통 사용합니다.

## Simulation 최소 훈련량

MAC-V 한 환경에서 독립적으로 다음을 수행하는 것을 권장합니다.

```text
GitHub Account        5
Issue                 10+
Merged PR             10+ / 각 계정 2+
Substantive Review    10+ / 각 계정 2+
Feedback application  5+ / 각 계정 1+
Deliverable commit    5/5
Conflict              2+ / non-trivial 1+
Troubleshooting       amend/reset-soft/revert/stash-pop 4종
Participation         5/5
```

WIN-V에서는 같은 계정 A~E로 동일한 핵심 흐름을 재현하고, 이후 Cross-platform Simulation으로 확장합니다.

## Evidence

Simulation Evidence 위치:

```text
training/round-01-clear/evidence/simulation/mac-v/
training/round-01-clear/evidence/simulation/win-v/
```

실제 Mission Evidence 위치:

```text
training/round-01-clear/evidence/actual/
```

두 종류를 혼합하지 않습니다.
