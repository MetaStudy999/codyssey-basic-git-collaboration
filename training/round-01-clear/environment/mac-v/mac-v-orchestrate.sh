#!/usr/bin/env bash
set -euo pipefail

MODE="${1:---check}"
MACHINE="${B2_2_MAC_V_MACHINE:-codyssey}"
IMAGE="${B2_2_MAC_V_IMAGE:-ubuntu:noble}"
CONTROL_REPO="https://github.com/MetaStudy999/codyssey-basic.git"
B22_REPO="https://github.com/MetaStudy999/codyssey-basic-git-collaboration.git"

log() { printf '[MAC-V orchestrate] %s\n' "$*"; }
fail() { printf '[MAC-V orchestrate][FAIL] %s\n' "$*" >&2; exit 1; }

usage() {
  cat <<'EOF'
Usage:
  bash mac-v-orchestrate.sh --check
  bash mac-v-orchestrate.sh --prepare

--check
  macOS/OrbStack/codyssey/Ubuntu 24.04 상태를 조회합니다.
  machine 생성, package 설치, Linux user 생성을 하지 않습니다.

--prepare
  다음을 안전하게 묶어서 수행합니다.
  1) OrbStack 상태 확인
  2) codyssey가 없을 때만 Ubuntu 24.04 machine 생성
  3) Ubuntu 내부 Git bootstrap seed 확인
  4) Control Tower clone/update
  5) B2-2 repo clone/update
  6) Control Tower Ubuntu bootstrap --check, 필요 시 --install
  7) codyssey01~05 생성/검증

자동화하지 않는 것:
- gh auth login
- GitHub password / 2FA / token 입력
- git user.name / user.email 결정
- Simulation Repository 생성
- Issue / PR / Review / Merge 생성
- OrbStack machine 삭제

환경변수:
  B2_2_MAC_V_MACHINE  기본값 codyssey
  B2_2_MAC_V_IMAGE    기본값 ubuntu:noble
EOF
}

[[ "$MODE" == "--check" || "$MODE" == "--prepare" ]] || { usage; exit 2; }
[[ "$(uname -s)" == "Darwin" ]] || fail "macOS Host에서 실행해야 합니다. 현재: $(uname -s)"
command -v orb >/dev/null 2>&1 || fail "OrbStack CLI 'orb'를 찾을 수 없습니다."

log "1/7 OrbStack 상태 확인"
orb status
orb list || true

machine_exists=0
if orb -m "$MACHINE" sh -lc 'true' >/dev/null 2>&1; then
  machine_exists=1
fi

if ((machine_exists == 0)); then
  if [[ "$MODE" == "--check" ]]; then
    fail "$MACHINE machine이 없습니다. --prepare에서만 생성을 허용합니다."
  fi
  log "2/7 $MACHINE 없음 — $IMAGE 로 신규 생성"
  orb create "$IMAGE" "$MACHINE"
else
  log "2/7 $MACHINE 존재 — 재사용"
fi

log "3/7 Ubuntu 24.04 확인"
os_release="$(orb -m "$MACHINE" sh -lc 'cat /etc/os-release')"
printf '%s\n' "$os_release"
id_value="$(printf '%s\n' "$os_release" | awk -F= '$1=="ID" {gsub(/"/,"",$2); print $2}')"
version_value="$(printf '%s\n' "$os_release" | awk -F= '$1=="VERSION_ID" {gsub(/"/,"",$2); print $2}')"
[[ "$id_value" == "ubuntu" ]] || fail "$MACHINE 이 Ubuntu가 아닙니다: ID=${id_value:-unknown}"
[[ "$version_value" == "24.04" ]] || fail "$MACHINE 이 Ubuntu 24.04가 아닙니다: VERSION_ID=${version_value:-unknown}. 자동 삭제/덮어쓰기를 하지 않습니다."
log "Guest architecture: $(orb -m "$MACHINE" uname -m)"

if [[ "$MODE" == "--check" ]]; then
  log "CHECK PASS — Host/OrbStack/Ubuntu 24.04 확인 완료"
  printf '\n다음 준비 실행:\n  bash %s --prepare\n' "$0"
  exit 0
fi

log "4/7 Ubuntu 내부 Git bootstrap seed 확인"
orb -m "$MACHINE" sh -lc '
set -eu
if command -v git >/dev/null 2>&1; then
  git --version
else
  sudo apt-get update
  sudo apt-get install -y git ca-certificates
  git --version
fi
'

log "5/7 Control Tower / B2-2 Repository 준비"
orb -m "$MACHINE" sh -lc "
set -eu
mkdir -p \"\$HOME/codyssey\"
cd \"\$HOME/codyssey\"

prepare_repo() {
  dir=\"\$1\"
  url=\"\$2\"
  if [ -d \"\$dir/.git\" ]; then
    cd \"\$dir\"
    if [ -n \"\$(git status --porcelain)\" ]; then
      echo \"[FAIL] local changes exist in \$PWD; refusing automatic pull\" >&2
      exit 1
    fi
    git remote set-url origin \"\$url\"
    git pull --ff-only
    cd ..
  elif [ -e \"\$dir\" ]; then
    echo \"[FAIL] path exists but is not a Git repository: \$dir\" >&2
    exit 1
  else
    git clone \"\$url\" \"\$dir\"
  fi
}

prepare_repo codyssey-basic '$CONTROL_REPO'
prepare_repo codyssey-basic-git-collaboration '$B22_REPO'
"

log "6/7 Control Tower Ubuntu Bootstrap"
orb -m "$MACHINE" sh -lc '
set -eu
cd "$HOME/codyssey/codyssey-basic"
if bash environments/ubuntu/bootstrap.sh --check; then
  echo "[PASS] Control Tower Ubuntu Bootstrap already ready"
else
  bash environments/ubuntu/bootstrap.sh --install
  bash environments/ubuntu/bootstrap.sh --check
fi
'

log "7/7 B2-2 MAC-V CORE 사용자 구조 준비/검증"
orb -m "$MACHINE" sh -lc '
set -eu
cd "$HOME/codyssey/codyssey-basic-git-collaboration"
bash training/round-01-clear/environment/mac-v/prepare-core.sh
'

cat <<EOF

[MAC-V orchestrate][PASS] MAC-V CORE 준비 묶음 완료

확인된 범위:
- OrbStack
- $MACHINE = Ubuntu 24.04
- Control Tower Ubuntu Bootstrap
- B2-2 Repository
- codyssey01~05
- HOME / Workspace 구조

아직 수동으로 필요한 범위:
- GitHub A~E gh auth login
- Git identity 5/5
- Identity Gate 5/5
- Simulation Repository clone 5/5
- Issue / PR / Review / Conflict / Troubleshooting

다음 문서:
  training/round-01-clear/environment/mac-v/RUN-NOW.md
EOF
