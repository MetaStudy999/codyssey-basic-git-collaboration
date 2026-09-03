# MAC-V Simulation Repository Setup

> **TRAINING SIMULATION — NOT OFFICIAL B2-2 EVIDENCE**

이 문서는 Identity Gate 5/5 이후 사용할 별도 학습 Repository를 준비하는 절차입니다.

## 1. 기본 Repository 이름

권장 기본값:

```text
codyssey-b2-2-sim-mac-v
```

Reference Repository나 실제 3~5인 팀 Repository를 Simulation에 재사용하지 않습니다.

## 2. Account A에서 Repository seed 생성

Linux user `codyssey01` / GitHub Account A에서 B2-2 Reference Repository 최신 상태를 확인한 뒤:

```bash
cd "$HOME/codyssey/codyssey-basic-git-collaboration"

bash training/round-01-clear/environment/mac-v/create-simulation-repo.sh
```

기본값을 쓰지 않을 때:

```bash
bash training/round-01-clear/environment/mac-v/create-simulation-repo.sh \
  <simulation-repo-name>
```

스크립트는 다음을 수행합니다.

- Account A `gh` identity 확인
- Git identity 확인
- 동일 이름의 기존 remote Repository가 있으면 STOP
- 기존 `~/b2-2-team/simulation-admin`이 있으면 STOP
- `repository-template/` 복사
- `main` 초기 commit 1개 생성
- 별도 public GitHub Repository 생성/push

기존 Repository나 기존 로컬 디렉터리를 자동 삭제하지 않습니다.

## 3. Account B~E Collaborator 추가

Repository 소유자 Account A로 GitHub Repository 설정 화면을 엽니다.

```text
Repository
→ Settings
→ Collaborators / Access 관련 메뉴
→ Account B, C, D, E 추가
```

GitHub UI 명칭은 계정/조직/시점에 따라 조금 다를 수 있으므로 실제 화면의 Repository access/collaborator 관리 메뉴를 기준으로 합니다.

Account B~E는 각자 초대를 수락합니다.

초대 수락이 끝나기 전에는 clone 5/5 Gate를 PASS 처리하지 않습니다.

## 4. main 보호 정책

Simulation에서도 다음을 훈련합니다.

```text
main 직접 변경 차단
Pull Request 필요
Approval 1+ 필요
Force push 금지
Branch deletion 보호
```

GitHub의 Rules/Rulesets 또는 Branch Protection 화면에서 `main`에 적용하고 실제 설정 결과를 확인합니다.

설정 화면의 이름보다 실제 동작과 GitHub API/UI 상태를 기준으로 판정합니다.

## 5. Repository Gate 검증

Account A가 읽을 수 있는 관리자 세션에서:

```bash
cd "$HOME/codyssey/codyssey-basic-git-collaboration"

bash training/round-01-clear/environment/mac-v/verify-simulation-repo.sh \
  <OWNER>/<SIMULATION-REPO> \
  <github-A> <github-B> <github-C> <github-D> <github-E>
```

확인 항목:

```text
Repository 접근
Default branch = main
A~E 권한 확인
main 보호 상태 확인
```

0 FAIL 전에는 Issue/PR Cycle을 시작하지 않습니다.

## 6. 5개 독립 clone

Repository Gate가 PASS한 뒤 Ubuntu 관리자 세션에서:

```bash
cd "$HOME/codyssey/codyssey-basic-git-collaboration"

sudo bash training/round-01-clear/environment/mac-v/prepare-simulation-clones.sh \
  <OWNER>/<SIMULATION-REPO>
```

결과:

```text
/home/codyssey01/b2-2-team/simulation
/home/codyssey02/b2-2-team/simulation
/home/codyssey03/b2-2-team/simulation
/home/codyssey04/b2-2-team/simulation
/home/codyssey05/b2-2-team/simulation
```

각 clone은 서로 독립된 working tree입니다.

## 7. 다음 단계

```text
Repository Gate PASS
→ clone 5/5
→ TASK-MATRIX.md Cycle 1
→ Review / Feedback
→ Cycle 2
→ Conflict / Troubleshooting
→ SUBMISSION
→ audit-github-counts.sh
```

이 절차의 완료는 학습 Simulation Repository 준비 완료일 뿐, 실제 B2-2 Mission CLEAR가 아닙니다.
