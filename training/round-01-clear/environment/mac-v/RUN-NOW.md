# B2-2 MAC-V — 지금 실행하기(Run Now)

> **TRAINING SIMULATION — NOT OFFICIAL B2-2 EVIDENCE**

이 문서는 여러 번 멈추지 않고 MAC-V CORE 환경을 **단계 묶음**으로 준비하고, Identity Gate 이후 협업 Simulation까지 연결하기 위한 실행 진입점입니다.

```text
학교 공용 Mac
→ OrbStack
→ Ubuntu 24.04 `codyssey`
→ Control Tower Bootstrap
→ codyssey01~05
→ GitHub A~E
→ Identity Gate 5/5
→ Simulation Repository seed
→ Repository Gate
→ clone 5/5
→ Issue/PR/Review Simulation
→ Sanitized Runtime Report
```

실제 명령 출력과 GitHub 기록이 없으면 PASS로 기록하지 않습니다.

## 0. 권장 빠른 경로(Fast Path)

B2-2 Repository가 **macOS Host에도 clone되어 있다면**, Host/Guest CORE 준비는 다음 한 명령으로 묶어서 수행할 수 있습니다.

```bash
bash training/round-01-clear/environment/mac-v/mac-v-orchestrate.sh --prepare
```

이 스크립트가 실제로 묶어서 수행하는 범위:

```text
OrbStack 확인
→ codyssey 재사용 또는 없을 때만 Ubuntu 24.04 생성
→ Ubuntu 24.04 검증
→ Git bootstrap seed
→ Control Tower clone/update
→ B2-2 Repository clone/update
→ Control Tower Ubuntu Bootstrap
→ codyssey01~05 생성
→ HOME / Workspace 검증
```

안전 제한:

```text
기존 codyssey 자동 삭제 안 함
Ubuntu 24.04 불일치 시 STOP
기존 Repository local change 발견 시 STOP
pull은 --ff-only
Token/Password/2FA 자동화 안 함
gh auth login 자동화 안 함
Git identity 자동 결정 안 함
Issue/PR/Review 자동 생성 안 함
```

조회만 먼저 하고 싶다면:

```bash
bash training/round-01-clear/environment/mac-v/mac-v-orchestrate.sh --check
```

Fast Path가 PASS하면 아래 **1~2절의 Host/CORE 수동 절차는 완료된 것으로 보고 3절 GitHub 인증으로 이동**합니다. 실제 출력이 없으면 PASS로 기록하지 않습니다.

---

## 1. macOS Host — OrbStack / codyssey 준비

Fast Path를 사용하지 않을 경우 아래 수동 절차를 사용합니다.

`host-preflight.sh`를 macOS에서 실행할 수 있는 위치에 B2-2 Repository가 있다면:

```bash
bash training/round-01-clear/environment/mac-v/host-preflight.sh --prepare
```

이 스크립트는:

- OrbStack 상태 확인
- 기존 `codyssey` 재사용
- 없을 때만 `ubuntu:noble`로 생성
- 기존 `codyssey`가 Ubuntu 24.04가 아니면 STOP
- machine 삭제/덮어쓰기 금지

을 수행합니다.

Repository가 macOS Host에 없다면 다음 Host 명령으로 같은 사전 점검을 수행합니다.

```bash
orb status
orb list
orb -m codyssey cat /etc/os-release 2>/dev/null || true
```

`codyssey`가 **없다는 것을 확인한 경우에만**:

```bash
orb create ubuntu:noble codyssey
```

그 다음:

```bash
orb -m codyssey cat /etc/os-release
orb -m codyssey uname -m
orb -m codyssey
```

Ubuntu 24.04가 아니면 자동 삭제/재생성하지 않습니다.

## 2. Ubuntu Guest — Repository / CORE 준비

Fast Path를 사용하지 않을 경우 Ubuntu `codyssey` 안에서 수행합니다.

### 2-1. Git bootstrap seed

Control Tower를 clone하려면 Git이 먼저 필요합니다. Git이 이미 있으면 아무 것도 설치하지 않습니다.

```bash
command -v git >/dev/null 2>&1 || {
  sudo apt-get update &&
  sudo apt-get install -y git ca-certificates
}
```

### 2-2. Control Tower 준비

```bash
mkdir -p "$HOME/codyssey"
cd "$HOME/codyssey"

if [ -d codyssey-basic/.git ]; then
  cd codyssey-basic
  git status --short --branch
  git remote set-url origin https://github.com/MetaStudy999/codyssey-basic.git
  git pull --ff-only
else
  git clone https://github.com/MetaStudy999/codyssey-basic.git
  cd codyssey-basic
fi

bash environments/ubuntu/bootstrap.sh --check || {
  bash environments/ubuntu/bootstrap.sh --install &&
  bash environments/ubuntu/bootstrap.sh --check
}
```

### 2-3. B2-2 Repository 준비

현재 Canonical Repository(기준 저장소)는 `MetaStudy999/codyssey-basic-git-collaboration`입니다.

```bash
cd "$HOME/codyssey"

if [ -d codyssey-basic-git-collaboration/.git ]; then
  cd codyssey-basic-git-collaboration
  git status --short --branch
  git remote set-url origin https://github.com/MetaStudy999/codyssey-basic-git-collaboration.git
  git pull --ff-only
else
  git clone https://github.com/MetaStudy999/codyssey-basic-git-collaboration.git
  cd codyssey-basic-git-collaboration
fi
```

Repository Rename 이전의 로컬 디렉터리가 남아 있어도 자동 삭제하지 않습니다. 새 Canonical Directory를 별도로 clone해서 사용합니다. 로컬 변경이 존재해 `git pull --ff-only`이 막히면 변경을 덮어쓰지 말고 STOP합니다.

### 2-4. CORE 시스템 준비

```bash
bash training/round-01-clear/environment/mac-v/prepare-core.sh
```

정상 완료 시 다음까지만 증명합니다.

```text
Ubuntu 24.04                         PASS
Control Tower Bootstrap             PASS
codyssey01~05                       PASS
HOME / Workspace                    PASS
```

아직 GitHub 인증은 증명하지 않습니다.

## 3. GitHub Account A~E 인증

Linux User와 GitHub Account를 고정합니다.

| Linux User | GitHub Account |
|---|---|
| `codyssey01` | A |
| `codyssey02` | B |
| `codyssey03` | C |
| `codyssey04` | D |
| `codyssey05` | E |

각 사용자에 들어가 **본인에게 배정된 계정 하나만** 인증합니다.

예: Account A

```bash
orb -m codyssey -u codyssey01

gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git --hostname github.com

git config --global user.name "<Account A Git name>"
git config --global user.email "<Account A GitHub email 또는 noreply email>"
```

같은 방식으로 `codyssey02`~`codyssey05`까지 수행합니다.

Token, Password, 2FA code, recovery code, private key는 문서/채팅/Evidence에 기록하지 않습니다.

## 4. Identity Gate 5/5

5개 인증이 끝나면 Ubuntu 관리자 세션에서:

```bash
cd "$HOME/codyssey/codyssey-basic-git-collaboration"

sudo bash training/round-01-clear/environment/mac-v/verify-all-identities.sh \
  <github-A> <github-B> <github-C> <github-D> <github-E>
```

PASS 기준:

```text
codyssey01 ↔ GitHub A ↔ Git Identity A
codyssey02 ↔ GitHub B ↔ Git Identity B
codyssey03 ↔ GitHub C ↔ Git Identity C
codyssey04 ↔ GitHub D ↔ Git Identity D
codyssey05 ↔ GitHub E ↔ Git Identity E
```

하나라도 불일치하면 Issue/Commit/PR/Review Simulation을 시작하지 않습니다.

## 5. Simulation Repository seed / Repository Gate / clone 5개

Simulation은 **별도 학습용 Repository**를 사용합니다.

```text
Reference Repository 재사용 금지
실제 팀 Repository 재사용 금지
Simulation 전용 Repository 사용
```

상세 절차:

- [`../../simulation/mac-v/SIMULATION-REPOSITORY-SETUP.md`](../../simulation/mac-v/SIMULATION-REPOSITORY-SETUP.md)

### 5-1. Account A에서 seed Repository 생성

`codyssey01` / Account A에서:

```bash
cd "$HOME/codyssey/codyssey-basic-git-collaboration"

bash training/round-01-clear/environment/mac-v/create-simulation-repo.sh
```

기본 이름:

```text
codyssey-b2-2-sim-mac-v
```

이 helper는 기존 remote Repository나 `~/b2-2-team/simulation-admin`을 자동 삭제/덮어쓰지 않습니다.

### 5-2. Account B~E access와 main 보호

Account A의 Repository 설정에서 B~E를 collaborator로 추가하고, 각 계정에서 초대를 수락합니다.

그 다음 `main`에 다음 학습 정책을 적용합니다.

```text
Pull Request required
Approval 1+
Force push 금지
Branch deletion 보호
```

### 5-3. Repository Gate

Account A가 읽을 수 있는 세션에서:

```bash
bash training/round-01-clear/environment/mac-v/verify-simulation-repo.sh \
  <OWNER>/<SIMULATION-REPO> \
  <github-A> <github-B> <github-C> <github-D> <github-E>
```

0 FAIL 전에는 clone/Issue Cycle을 시작하지 않습니다.

### 5-4. 5개 독립 clone

Repository Gate PASS 후 Ubuntu 관리자 세션에서:

```bash
cd "$HOME/codyssey/codyssey-basic-git-collaboration"

sudo bash training/round-01-clear/environment/mac-v/prepare-simulation-clones.sh \
  <OWNER>/<SIMULATION-REPO>
```

각 사용자에 다음 clone이 만들어집니다.

```text
/home/codyssey01/b2-2-team/simulation
/home/codyssey02/b2-2-team/simulation
/home/codyssey03/b2-2-team/simulation
/home/codyssey04/b2-2-team/simulation
/home/codyssey05/b2-2-team/simulation
```

스크립트는 기존 clone을 자동 삭제하지 않고, local changes가 있으면 STOP하며 `git pull --ff-only`만 허용합니다.

## 6. Issue / PR / Review Simulation

clone 5/5 이후 다음 Runbook으로 이동합니다.

- [`../../simulation/mac-v/README.md`](../../simulation/mac-v/README.md)
- [`../../simulation/mac-v/TASK-MATRIX.md`](../../simulation/mac-v/TASK-MATRIX.md)
- [`../../simulation/mac-v/CONFLICT-AND-TROUBLESHOOTING-LAB.md`](../../simulation/mac-v/CONFLICT-AND-TROUBLESHOOTING-LAB.md)

훈련 목표:

```text
Issue                 10+
Merged PR             10+ / 계정별 2+
Substantive Review    10+ / 계정별 2+
Feedback application  5+ / 계정별 1+
Conflict              2+ / non-trivial 1+
Troubleshooting       4종
Participation         5/5
```

## 7. Evidence / 실행 보고

Simulation Evidence 위치:

- `training/round-01-clear/evidence/simulation/mac-v/`

실제 팀 Evidence 위치:

- `training/round-01-clear/evidence/actual/`

두 Evidence를 혼합하지 않습니다.

Simulation Repository의 `SUBMISSION.md` 상단에도 다음을 표시합니다.

```text
TRAINING SIMULATION — NOT OFFICIAL B2-2 EVIDENCE
```

실제 수행 기록 정리 양식:

- [`MAC-V-EXECUTION-RECORD-TEMPLATE.md`](MAC-V-EXECUTION-RECORD-TEMPLATE.md)

macOS Host에서 Secret 값을 노출하지 않는 상태 보고를 한 번에 만들려면:

```bash
bash training/round-01-clear/environment/mac-v/collect-runtime-report.sh
```

이 보고서는 Host/OrbStack/Ubuntu, `git`/`gh`, Linux User 5개, 각 계정의 GitHub 로그인 가능 여부와 Git identity 설정 여부, Simulation clone 존재 여부를 확인합니다. Token/Password/Private Key 값을 출력하도록 설계하지 않았습니다.

## 8. 공용 PC Closeout

학습 종료 시:

- [`CLOSEOUT.md`](CLOSEOUT.md)

를 사용합니다.

특히 5개 Linux User의 `gh` 인증과 브라우저 GitHub 세션을 정리합니다.

## 상태 판정

현재 Repository 반영 상태:

```text
One-command Host/CORE runner   ✅ READY
Host/CORE Runbook              ✅ READY
Identity 5/5 verifier          ✅ READY
Simulation repository template ✅ READY
Simulation repository creator  ✅ READY
Simulation repository verifier ✅ READY
Simulation clone helper        ✅ READY
Task / Review Matrix           ✅ READY
Conflict/Troubleshooting Lab   ✅ READY
Sanitized Runtime Report       ✅ READY
Execution Record Template      ✅ READY
MAC-V 실제 Runtime             ⬜ NOT RUN
Identity Gate 실제 PASS        ⬜ NOT RUN
Simulation 실제 수행           ⬜ NOT RUN
Actual Mission CLEAR           ❌ 아님
```
