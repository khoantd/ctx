#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TAURI_DIR="${ROOT}/src-tauri"
WEB_DIST="${ROOT}/../web/dist"
TAURI_WEB_DIST="${TAURI_DIR}/web/dist"
BUNDLES_DIR="${TAURI_DIR}/bundles"
PROVIDER_MATRIX_SRC="${ROOT}/../../crates/ctx-provider-accounts/src/provider_matrix.json"
ARTIFACT_IDENTITY="${BUNDLES_DIR}/artifact_identity.json"
PROVIDER_MATRIX_DST="${BUNDLES_DIR}/provider_matrix.json"

ensure_web_dist() {
  if [[ ! -d "${WEB_DIST}" ]]; then
    echo "Building web frontend..."
    pnpm -C "${ROOT}/../web" build
  fi

  mkdir -p "$(dirname "${TAURI_WEB_DIST}")"
  rm -rf "${TAURI_WEB_DIST}"
  cp -R "${WEB_DIST}" "${TAURI_WEB_DIST}"
}

ensure_provider_matrix() {
  if [[ ! -f "${PROVIDER_MATRIX_SRC}" ]]; then
    echo "error: missing provider matrix source at ${PROVIDER_MATRIX_SRC}" >&2
    exit 1
  fi
  cp "${PROVIDER_MATRIX_SRC}" "${PROVIDER_MATRIX_DST}"
}

ensure_artifact_identity() {
  local repo_root version build_id compatibility_token canonical_root

  repo_root="$(git -C "${TAURI_DIR}" rev-parse --show-toplevel)"
  version="$(grep '^version = ' "${TAURI_DIR}/Cargo.toml" | head -1 | sed 's/.*"\(.*\)".*/\1/')"
  build_id="$(git -C "${repo_root}" rev-parse --short=12 HEAD)"
  if [[ -n "$(git -C "${repo_root}" status --porcelain --untracked-files=no)" ]]; then
    build_id="${build_id}-dirty"
  fi
  canonical_root="$(cd "${repo_root}" && pwd -P)"
  compatibility_token="$(
    CANONICAL_ROOT="${canonical_root}" node --input-type=module <<'EOF'
const root = process.env.CANONICAL_ROOT ?? "";
function fnv1a64(bytes) {
  let hash = 0xcbf29ce484222325n;
  for (const byte of bytes) {
    hash ^= BigInt(byte);
    hash = (hash * 0x100000001b3n) & 0xffffffffffffffffn;
  }
  return hash.toString(16).padStart(16, "0");
}
process.stdout.write(`dev-${fnv1a64(Buffer.from(root, "utf8"))}`);
EOF
  )"

  cat >"${ARTIFACT_IDENTITY}" <<EOF
{
  "schemaVersion": 1,
  "exactVersion": "${version}",
  "buildId": "${build_id}",
  "compatibilityToken": "${compatibility_token}"
}
EOF
}

ensure_web_dist
ensure_provider_matrix
ensure_artifact_identity
