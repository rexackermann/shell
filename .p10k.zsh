#!/usr/bin/env zsh
#!/usr/bin/env zsh

# Rex Shell 2026 v28 — Powerlevel10k
#
# Three-line layout, intentionally information-dense but not noisy:
#   1. identity + non-project session state / network identity
#   2. path + Git + project/runtime context / battery + clock
#   3. command input / NVIDIA + previous-command status + duration

# -----------------------------------------------------------------------------
# GLOBAL
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_MODE=nerdfont-v3
typeset -g POWERLEVEL9K_ICON_PADDING=none
typeset -g POWERLEVEL9K_BACKGROUND=
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
typeset -g POWERLEVEL9K_SHOW_RULER=false

typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
typeset -g POWERLEVEL9K_LEFT_{LEFT,RIGHT}_WHITESPACE=
typeset -g POWERLEVEL9K_RIGHT_{LEFT,RIGHT}_WHITESPACE=
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=
typeset -g ZLE_RPROMPT_INDENT=0

# -----------------------------------------------------------------------------
# THREE-LINE FRAME
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%245F╭─%f'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%245F├─%f'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%245F╰─%f'
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX='%245F─╮%f'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%245F─┤%f'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX='%245F─╯%f'
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='─'
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=245
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'

# -----------------------------------------------------------------------------
# LAYOUT
# -----------------------------------------------------------------------------
#
# Row 1: identity/session state | network identity
# Row 2: workspace/project      | user@host + time + battery
# Row 3: input                  | NVIDIA + exit status + duration
#
# Optional integrations are appended only when their executable/runtime exists.
# This prevents P10k from probing unavailable tools such as kubectl at startup.

# Identity row: intentionally compact and human-readable.
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  static_username
  rex_on
  rex_distro
  rex_architecture
  incognito_flag
  sudocheck
  ssh
)

# Workspace row.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(newline dir vcs)
[[ -n ${commands[mise]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(rex_mise_context)
[[ -n ${commands[direnv]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(direnv)
[[ -n ${commands[kubectl]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(kubecontext)
[[ -n ${commands[terraform]:-} || -n ${commands[tofu]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(terraform)
[[ -n ${commands[aws]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(aws)
[[ -n ${commands[az]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(azure)
[[ -n ${commands[gcloud]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(gcloud)
[[ -n ${commands[nix-shell]:-} || -n ${commands[nix]:-} ]] && POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(nix_shell)

# Finish with command input.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(newline prompt_char)

# Right side deliberately mirrors those three rows. The host/time/battery
# segment keeps row 2 balanced even when there is no project context.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  rex_network
  newline
  rex_host_status
  newline
  nvidia_flag
  status
  command_execution_time
)

# -----------------------------------------------------------------------------
# IDENTITY / SESSION STATE
# -----------------------------------------------------------------------------
# Adaptive color roles:
#   distro/provider/runtime/state colors are contextual; neutral identity/network/frame
#   colors stay fixed for legibility and visual continuity. No decorative color is
#   inferred from terminal theme, because terminals can change their palette at runtime.
# High-contrast neon palette. Nerd Font icons are intentionally rendered in
# bold with explicit foreground colors rather than inheriting surrounding text;
# this prevents glyphs from appearing to vanish until they are selected.


# Dynamic platform / distro identity.
#
# Important distinction on Android:
#   Android = operating system
#   Termux  = shell/runtime environment
#   Chroot/proot/container = userspace root identity wins over the host.
#
# Therefore a Termux shell on Android shows the Android logo, but a Fedora/Arch/
# Debian rootfs launched from Termux shows its own distro logo. REX_TERMUX is
# kept separately for Android/Termux-specific logic elsewhere in the config.
typeset -g REX_PLATFORM_ID=unknown
typeset -g REX_TERMUX=0
typeset -g REX_ROOT_ISOLATED=0
typeset -g REX_DISTRO_SOURCE=unknown
typeset -g REX_DISTRO_ID=unknown
typeset -g REX_DISTRO_NAME=Linux
typeset -g REX_DISTRO_ICON=''
typeset -g REX_DISTRO_COLOR=183

function _rex_getprop() {
  (( $+commands[getprop] )) || return 0
  command getprop "$1" 2>/dev/null
}

function _rex_read_os_release() {
  emulate -L zsh
  local file=$1
  local ID= ID_LIKE= PRETTY_NAME= NAME=
  [[ -r $file ]] || return 1
  source "$file" 2>/dev/null || return 1
  typeset -g REX_OS_ID=${ID:-}
  typeset -g REX_OS_ID_LIKE=${ID_LIKE:-}
  typeset -g REX_OS_PRETTY_NAME=${PRETTY_NAME:-}
  typeset -g REX_OS_NAME=${NAME:-}
  return 0
}

function _rex_detect_root_isolation() {
  emulate -L zsh
  REX_ROOT_ISOLATED=0

  # A traditional chroot has a different root filesystem from PID 1. This is
  # only a supporting signal: do not use it by itself to identify an OS.
  if (( $+commands[stat] )) && [[ -e /proc/1/root ]]; then
    local self_root pid1_root
    self_root=$(command stat -c '%d:%i' / 2>/dev/null) || self_root=
    pid1_root=$(command stat -c '%d:%i' /proc/1/root 2>/dev/null) || pid1_root=
    if [[ -n $self_root && -n $pid1_root && $self_root != $pid1_root ]]; then
      REX_ROOT_ISOLATED=1
    fi
  fi
}

function _rex_detect_distro() {
  emulate -L zsh
  local android_version= android_sdk= android_codename=
  local local_os_id= local_os_like= local_os_pretty= local_os_name=

  REX_TERMUX=0
  REX_ROOT_ISOLATED=0
  REX_PLATFORM_ID=unknown
  REX_DISTRO_SOURCE=unknown

  # Termux is an environment flag only. It must NEVER, by itself, mean
  # "Android", because Termux can launch proot/chroot/containerized Linux
  # distributions whose own OS identity should win.
  if [[ -n ${TERMUX_VERSION:-} || ${PREFIX:-} == /data/data/com.termux/files/usr ]]; then
    REX_TERMUX=1
  fi

  _rex_detect_root_isolation

  # ---------------------------------------------------------------------------
  # 1) Identify the userspace root we are actually running inside.
  #
  # This MUST happen before Android host detection. A Fedora/Arch/Debian rootfs
  # launched from Termux should display Fedora/Arch/Debian, not Android, even
  # though `getprop` and /system may still expose the Android host.
  # ---------------------------------------------------------------------------
  if _rex_read_os_release /etc/os-release || _rex_read_os_release /usr/lib/os-release; then
    local_os_id=${REX_OS_ID:-}
    local_os_like=${REX_OS_ID_LIKE:-}
    local_os_pretty=${REX_OS_PRETTY_NAME:-}
    local_os_name=${REX_OS_NAME:-}

    if [[ ${local_os_id:l} == android ]]; then
      REX_PLATFORM_ID=android
      REX_DISTRO_ID=android
      REX_DISTRO_NAME='Android'
      REX_DISTRO_ICON=''
      REX_DISTRO_COLOR=78
      REX_DISTRO_SOURCE='os-release'
      return 0
    fi

    if [[ -n $local_os_id ]]; then
      REX_PLATFORM_ID=linux
      REX_DISTRO_ID=${local_os_id:l}
      REX_DISTRO_NAME=${local_os_pretty:-${local_os_name:-Linux}}
      REX_DISTRO_SOURCE='os-release'

      case $REX_DISTRO_ID in
        arch|endeavouros|garuda)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=75 ;;
        fedora)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=39 ;;
        ubuntu|pop|elementary)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=208 ;;
        debian)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=161 ;;
        linuxmint)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=82 ;;
        opensuse*|sles)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=76 ;;
        nixos)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=117 ;;
        kali)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=51 ;;
        manjaro)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=118 ;;
        gentoo)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=135 ;;
        alpine)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=31 ;;
        void)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=72 ;;
        rhel|redhat)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=196 ;;
        rocky)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=36 ;;
        centos)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=99 ;;
        oracle)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=166 ;;
        freebsd)
          REX_DISTRO_ICON=''; REX_DISTRO_COLOR=167 ;;
        *)
          if [[ $local_os_like == *arch* ]]; then
            REX_DISTRO_ICON=''; REX_DISTRO_COLOR=75
          elif [[ $local_os_like == *ubuntu* ]]; then
            REX_DISTRO_ICON=''; REX_DISTRO_COLOR=208
          elif [[ $local_os_like == *debian* ]]; then
            REX_DISTRO_ICON=''; REX_DISTRO_COLOR=161
          elif [[ $local_os_like == *rhel* || $local_os_like == *fedora* ]]; then
            REX_DISTRO_ICON=''; REX_DISTRO_COLOR=39
          else
            REX_DISTRO_ICON=''; REX_DISTRO_COLOR=183
          fi
          ;;
      esac
      return 0
    fi
  fi

  # ---------------------------------------------------------------------------
  # 2) Android host detection.
  #
  # Do NOT use /system or the Termux flag as sufficient evidence. Both can be
  # visible from a Linux rootfs running under Termux. Android is declared only
  # when Android's own property service gives us multiple coherent build facts.
  # ---------------------------------------------------------------------------
  if (( $+commands[getprop] )); then
    android_version=$(_rex_getprop ro.build.version.release)
    android_sdk=$(_rex_getprop ro.build.version.sdk)
    android_codename=$(_rex_getprop ro.build.version.codename)
  fi

  # If we are in an isolated root and Termux is merely the host environment,
  # do not let the host's `getprop` leak back into the guest OS identity.
  if [[ $REX_ROOT_ISOLATED -ne 1 && -n $android_version && -n $android_sdk ]]; then
    REX_PLATFORM_ID=android
    REX_DISTRO_ID=android
    REX_DISTRO_NAME='Android'
    REX_DISTRO_ICON=''
    REX_DISTRO_COLOR=78
    REX_DISTRO_SOURCE='getprop'
    return 0
  fi

  # ---------------------------------------------------------------------------
  # 3) macOS.
  # ---------------------------------------------------------------------------
  if [[ $OSTYPE == darwin* ]]; then
    REX_PLATFORM_ID=macos
    REX_DISTRO_ID=macos
    REX_DISTRO_NAME='macOS'
    REX_DISTRO_ICON=''
    REX_DISTRO_COLOR=45
    REX_DISTRO_SOURCE='OSTYPE'
    return 0
  fi

  # ---------------------------------------------------------------------------
  # 4) Conservative generic Linux fallback.
  # ---------------------------------------------------------------------------
  REX_PLATFORM_ID=linux
  REX_DISTRO_SOURCE='fallback'
  REX_DISTRO_ID=linux
  REX_DISTRO_NAME='Linux'
  REX_DISTRO_ICON=''
  REX_DISTRO_COLOR=183
}
_rex_detect_distro

# Never use the Termux terminal glyph as an OS/distro identity. Termux is an
# environment flag only; Android and the actual guest distro have their own icons.
if [[ ${REX_DISTRO_ICON:-} == $'\uE795' ]]; then
  if [[ ${REX_DISTRO_ID:-} == android ]]; then
    REX_DISTRO_ICON=''
  else
    REX_DISTRO_ICON=''
  fi
fi

# Prompt identity overrides.
#
# REX_PROMPT_NAME: optional exact display name. If unset, the account full name
# is resolved from the passwd/GECOS record and the login name is used as fallback.
#
# REX_PROMPT_USER_ICON: OPTIONAL and intentionally has no default.
# Set it explicitly to opt into a custom identity glyph, for example:
#   REX_PROMPT_USER_ICON=''
# If it is not explicitly populated, the chess/user glyph is shown ONLY when the
# actual login username contains "rex". This is deliberately based on $USER, not
# the resolved full display name, so it cannot appear merely because the GECOS
# name happens to contain "Rex".
typeset -g REX_PROMPT_NAME="${REX_PROMPT_NAME:-}"
typeset -g REX_PROMPT_USER_ICON="${REX_PROMPT_USER_ICON-}"

autoload -Uz add-zsh-hook 2>/dev/null || true

function _rex_resolve_prompt_name() {
  [[ -n ${REX_PROMPT_NAME:-} ]] && return 0
  local full= line=

  if (( $+commands[getent] )) && [[ -n ${USER:-} ]]; then
    line=$(command getent passwd -- "$USER" 2>/dev/null) || line=
    if [[ -n $line ]]; then
      local -a passwd_fields
      passwd_fields=("${(@s/:/)line}")
      full=${passwd_fields[5]-}
      full=${full%%,*}
    fi
  fi

  if [[ -z $full && $OSTYPE == darwin* ]] && (( $+commands[id] )); then
    full=$(command id -F "$USER" 2>/dev/null) || full=
  fi

  typeset -g REX_PROMPT_NAME="${full:-${USER:-%n}}"
}
_rex_resolve_prompt_name

function prompt_rex_distro() {
  # Accent-colored bold glyph on a dark chip, no padding.
  local c=${REX_DISTRO_COLOR:-117}
  local icon=${REX_DISTRO_ICON:-$'\uF17C'}
  p10k segment -b 234 -f $c -t "%F{$c}%B${icon}%b%f"
}

# -----------------------------------------------------------------------------
# CPU / SoC identity
#
# Detection is deliberately multi-source so it works across desktop Linux,
# Android/Termux, macOS/BSD and other ARM/RISC systems:
#   1. Android system properties (`getprop`) — best source for phone/tablet SoCs
#   2. Linux SoC sysfs (`/sys/devices/soc0/*`)
#   3. lscpu, when available
#   4. /proc/cpuinfo
#   5. uname/sysctl architecture fallbacks
#
# The displayed value remains the architecture (x86_64/arm64/riscv64/etc.); its
# foreground color reflects the detected CPU/SoC brand.
# -----------------------------------------------------------------------------

typeset -g REX_CPU_ARCH=unknown
typeset -g REX_CPU_VENDOR=unknown
typeset -g REX_CPU_BRAND=unknown
typeset -g REX_CPU_MODEL=unknown
typeset -g REX_CPU_ARCH_COLOR=159

typeset -g REX_CPU_COLOR_INTEL=39
# AMD green.
typeset -g REX_CPU_COLOR_AMD=46
# ARM white.
typeset -g REX_CPU_COLOR_ARM=255
# Snapdragon / Qualcomm crimson-magenta.
typeset -g REX_CPU_COLOR_SNAPDRAGON=205
# MediaTek orange.
typeset -g REX_CPU_COLOR_MEDIATEK=208
# Intel Tiger Lake amber.
typeset -g REX_CPU_COLOR_TIGER=214
# RISC-V violet.
typeset -g REX_CPU_COLOR_RISCV=135
# Additional common mobile/embedded families.
typeset -g REX_CPU_COLOR_EXYNOS=51
typeset -g REX_CPU_COLOR_TENSOR=141
typeset -g REX_CPU_COLOR_KIRIN=203
typeset -g REX_CPU_COLOR_UNISOC=220
typeset -g REX_CPU_COLOR_APPLE=252
typeset -g REX_CPU_COLOR_NVIDIA=112
typeset -g REX_CPU_COLOR_ROCKCHIP=118
typeset -g REX_CPU_COLOR_AMLOGIC=38

typeset -g REX_CPU_SOC_MANUFACTURER=
typeset -g REX_CPU_SOC_MODEL=
typeset -g REX_CPU_SOC_PLATFORM=
typeset -g REX_CPU_IMPLEMENTER=

function _rex_read_first_line() {
  local file=$1
  [[ -r $file ]] || return 0
  IFS= read -r REPLY < "$file"
  print -r -- "$REPLY"
}

function _rex_detect_cpu_identity() {
  emulate -L zsh

  local arch=${REX_ARCH:-$(command uname -m 2>/dev/null)}
  local vendor= model= implementer= line key value
  local soc_manufacturer= soc_model= soc_platform= soc_hardware=
  local sys_machine= sys_family= sys_soc_id=
  local lscpu_vendor= lscpu_model=
  local haystack
  local -a cpuinfo_values

  case $arch in
    x86_64|amd64)   REX_CPU_ARCH='x86_64' ;;
    i?86)           REX_CPU_ARCH='x86' ;;
    aarch64|arm64)       REX_CPU_ARCH='arm64' ;;
    armv8*|armv8l)        REX_CPU_ARCH='armv8' ;;
    armv7l|armv7*)        REX_CPU_ARCH='armv7' ;;
    riscv64|riscv*) REX_CPU_ARCH='riscv64' ;;
    ppc64le|ppc64) REX_CPU_ARCH='ppc64' ;;
    s390x)          REX_CPU_ARCH='s390x' ;;
    *)              REX_CPU_ARCH=${arch:-unknown} ;;
  esac

  # ---------------------------------------------------------------------------
  # Android / Termux: getprop is the highest-confidence source for SoC brand.
  # ---------------------------------------------------------------------------
  if (( $+commands[getprop] )); then
    soc_manufacturer=$(_rex_getprop ro.soc.manufacturer)
    soc_model=$(_rex_getprop ro.soc.model)
    soc_platform=$(_rex_getprop ro.board.platform)
    soc_hardware=$(_rex_getprop ro.hardware)

    # Older/vendor Android releases may not have ro.soc.* populated.
    [[ -n $soc_platform ]] || soc_platform=$(_rex_getprop ro.boot.hardware)
    [[ -n $soc_model ]] || soc_model=$(_rex_getprop ro.chipname)
  fi

  # ---------------------------------------------------------------------------
  # Linux SoC sysfs: useful on ARM boards where getprop does not exist.
  # ---------------------------------------------------------------------------
  sys_machine=$(_rex_read_first_line /sys/devices/soc0/machine)
  sys_family=$(_rex_read_first_line /sys/devices/soc0/family)
  sys_soc_id=$(_rex_read_first_line /sys/devices/soc0/soc_id)

  # ---------------------------------------------------------------------------
  # lscpu: generic desktop/server source.
  # ---------------------------------------------------------------------------
  if (( $+commands[lscpu] )); then
    lscpu_vendor=$(command lscpu 2>/dev/null | awk -F: '$1 ~ /^[[:space:]]*Vendor ID[[:space:]]*$/ || $1 ~ /^[[:space:]]*Vendor[[:space:]]*$/ {sub(/^[[:space:]]+/, "", $2); print $2; exit}')
    lscpu_model=$(command lscpu 2>/dev/null | awk -F: '$1 ~ /^[[:space:]]*Model name[[:space:]]*$/ || $1 ~ /^[[:space:]]*Model[[:space:]]*$/ {sub(/^[[:space:]]+/, "", $2); print $2; exit}')
  fi

  # ---------------------------------------------------------------------------
  # /proc/cpuinfo: generic Linux/Android fallback and implementer detection.
  # ---------------------------------------------------------------------------
  if [[ -r /proc/cpuinfo ]]; then
    while IFS=: read -r key value; do
      [[ -n $key ]] || continue
      key=${key##[[:space:]]#}
      key=${key%%[[:space:]]#}
      value=${value##[[:space:]]#}
      value=${value%%[[:space:]]#}

      case $key in
        vendor_id|Vendor|vendor)
          [[ -n $vendor ]] || vendor=$value
          ;;
        model\ name|Model\ name|Hardware|Processor|Model)
          [[ -n $model ]] || model=$value
          ;;
        CPU\ implementer)
          [[ -n $implementer ]] || implementer=$value
          ;;
      esac

      [[ -n $vendor && -n $model && -n $implementer ]] && break
    done < /proc/cpuinfo
  fi

  # macOS/BSD fallback.
  if (( $+commands[sysctl] )); then
    if [[ -z $model ]]; then
      model=$(command sysctl -n machdep.cpu.brand_string 2>/dev/null) || model=
      [[ -n $model ]] || model=$(command sysctl -n hw.model 2>/dev/null) || model=
    fi
    [[ -n $vendor ]] || vendor=$(command sysctl -n machdep.cpu.vendor 2>/dev/null) || vendor=
  fi

  # Prefer the most specific source for the exported diagnostic fields.
  REX_CPU_SOC_MANUFACTURER=${soc_manufacturer:-}
  REX_CPU_SOC_MODEL=${soc_model:-}
  REX_CPU_SOC_PLATFORM=${soc_platform:-}
  REX_CPU_IMPLEMENTER=${implementer:-}
  REX_CPU_MODEL=${soc_model:-${sys_machine:-${lscpu_model:-${model:-unknown}}}}

  haystack="${soc_manufacturer} ${soc_model} ${soc_platform} ${soc_hardware} ${sys_machine} ${sys_family} ${sys_soc_id} ${lscpu_vendor} ${lscpu_model} ${vendor} ${model}"
  haystack=${haystack:l}

  REX_CPU_VENDOR=unknown
  REX_CPU_BRAND=unknown
  REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_ARM

  # ---------------------------------------------------------------------------
  # Specific SoC families first. This is essential on Android because most ARM
  # cores report CPU implementer 0x41 (ARM Ltd), which is NOT the SoC vendor.
  # ---------------------------------------------------------------------------
  if [[ $haystack == *mediatek* || $haystack == *mtk* || $soc_platform == mt[0-9]* || $soc_platform == mtx* ]]; then
    REX_CPU_VENDOR=mediatek
    REX_CPU_BRAND=mediatek
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_MEDIATEK
  elif [[ $haystack == *snapdragon* || $haystack == *qualcomm* || $haystack == *kryo* || $soc_model == sm[0-9]* || $soc_model == sdm[0-9]* || $soc_model == msm[0-9]* ]]; then
    REX_CPU_VENDOR=qualcomm
    REX_CPU_BRAND=snapdragon
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_SNAPDRAGON
  elif [[ $haystack == *exynos* || $haystack == *samsung* || $soc_platform == exynos* ]]; then
    REX_CPU_VENDOR=samsung
    REX_CPU_BRAND=exynos
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_EXYNOS
  elif [[ $haystack == *tensor* || $soc_platform == gs[0-9]* || $soc_model == gs[0-9]* ]]; then
    REX_CPU_VENDOR=google
    REX_CPU_BRAND=tensor
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_TENSOR
  elif [[ $haystack == *hisilicon* || $haystack == *kirin* || $soc_platform == kirin* ]]; then
    REX_CPU_VENDOR=hisilicon
    REX_CPU_BRAND=kirin
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_KIRIN
  elif [[ $haystack == *unisoc* || $haystack == *spreadtrum* ]]; then
    REX_CPU_VENDOR=unisoc
    REX_CPU_BRAND=unisoc
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_UNISOC
  elif [[ $haystack == *nvidia* || $haystack == *tegra* ]]; then
    REX_CPU_VENDOR=nvidia
    REX_CPU_BRAND=tegra
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_NVIDIA
  elif [[ $haystack == *rockchip* || $soc_platform == rk[0-9]* ]]; then
    REX_CPU_VENDOR=rockchip
    REX_CPU_BRAND=rockchip
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_ROCKCHIP
  elif [[ $haystack == *amlogic* || $soc_platform == meson* ]]; then
    REX_CPU_VENDOR=amlogic
    REX_CPU_BRAND=amlogic
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_AMLOGIC
  elif [[ $haystack == *apple* && ( $REX_CPU_ARCH == arm64 || $OSTYPE == darwin* ) ]]; then
    REX_CPU_VENDOR=apple
    REX_CPU_BRAND=apple
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_APPLE
  elif [[ $haystack == *tiger[[:space:]]lake* || $haystack == *tigerlake* ]]; then
    REX_CPU_VENDOR=intel
    REX_CPU_BRAND=tiger
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_TIGER
  elif [[ $haystack == *authenticamd* || $haystack == *advanced*micro*devices* || $haystack == *amd* ]]; then
    REX_CPU_VENDOR=amd
    REX_CPU_BRAND=amd
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_AMD
  elif [[ $haystack == *genuineintel* || $haystack == *intel* ]]; then
    REX_CPU_VENDOR=intel
    REX_CPU_BRAND=intel
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_INTEL
  elif [[ $REX_CPU_ARCH == riscv64 || $REX_CPU_ARCH == riscv* || $haystack == *risc-v* || $haystack == *riscv* ]]; then
    REX_CPU_VENDOR=riscv
    REX_CPU_BRAND=riscv
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_RISCV
  elif [[ $REX_CPU_ARCH == arm64 || $REX_CPU_ARCH == armv8 || $REX_CPU_ARCH == armv7 ]]; then
    # 0x41 is ARM Ltd as the core implementer; without a more specific SoC
    # identity we deliberately classify it as generic ARM rather than guessing.
    REX_CPU_VENDOR=arm
    REX_CPU_BRAND=arm
    REX_CPU_ARCH_COLOR=$REX_CPU_COLOR_ARM
  elif [[ $REX_CPU_ARCH == ppc* || $REX_CPU_ARCH == s390x ]]; then
    REX_CPU_VENDOR=other
    REX_CPU_BRAND=other
    REX_CPU_ARCH_COLOR=183
  fi

  export REX_CPU_ARCH REX_CPU_VENDOR REX_CPU_BRAND REX_CPU_MODEL REX_CPU_ARCH_COLOR
  export REX_CPU_SOC_MANUFACTURER REX_CPU_SOC_MODEL REX_CPU_SOC_PLATFORM REX_CPU_IMPLEMENTER
}
_rex_detect_cpu_identity

function prompt_rex_architecture() {
  [[ -n ${REX_CPU_ARCH:-} && $REX_CPU_ARCH != unknown ]] || return 0
  p10k segment -f ${REX_CPU_ARCH_COLOR:-159} -t "${REX_CPU_ARCH}"
}

function prompt_static_username() {
  local icon=${REX_PROMPT_USER_ICON-}
  local name=${REX_PROMPT_NAME:-${USER:-%n}}
  local login=${USER:-%n}
  name=${name//\%/%%}

  # Identity glyph policy is deterministic:
  #   1. An explicit non-empty REX_PROMPT_USER_ICON always wins.
  #   2. Otherwise show the chess/user glyph only when the actual login username
  #      contains "rex" (case-insensitive).
  #   3. Otherwise show NO identity glyph.
  if [[ -z $icon && ${login:l} == *rex* ]]; then
    icon=''
  fi

  if [[ -n $icon ]]; then
    p10k segment -f 255 -t "%K{234}%F{83}%B${icon}%b%k%f %F{83}${name}%f"
  else
    p10k segment -f 255 -t "%F{83}${name}%f"
  fi
}

# -----------------------------------------------------------------------------
# CPU/SoC diagnostic
# -----------------------------------------------------------------------------
# Run `rex-cpu-debug` on any machine to see exactly which sources are available
# and which identity/color the prompt selected. This is particularly useful on
# Android devices where /proc/cpuinfo often contains only ARM implementer IDs.
function rex-cpu-debug() {
  emulate -L zsh
  _rex_detect_cpu_identity
  print -r -- '=== REX CPU / SoC DETECTION ==='
  print -r -- "OS/platform      : ${REX_PLATFORM_ID:-unknown}"
  print -r -- "Distro           : ${REX_DISTRO_ID:-unknown}"
  print -r -- "Distro source    : ${REX_DISTRO_SOURCE:-unknown}"
  print -r -- "Termux           : ${REX_TERMUX:-0}"
  print -r -- "Root isolated    : ${REX_ROOT_ISOLATED:-0}"
  print -r -- "arch             : ${REX_CPU_ARCH:-unknown}"
  print -r -- "vendor           : ${REX_CPU_VENDOR:-unknown}"
  print -r -- "brand            : ${REX_CPU_BRAND:-unknown}"
  print -r -- "model            : ${REX_CPU_MODEL:-unknown}"
  print -r -- "arch color       : ${REX_CPU_ARCH_COLOR:-unknown}"
  print -r -- "SoC manufacturer : ${REX_CPU_SOC_MANUFACTURER:-}"
  print -r -- "SoC model        : ${REX_CPU_SOC_MODEL:-}"
  print -r -- "SoC platform     : ${REX_CPU_SOC_PLATFORM:-}"
  print -r -- "CPU implementer  : ${REX_CPU_IMPLEMENTER:-}"
  if (( $+commands[getprop] )); then
    print -r -- '--- Android properties ---'
    print -r -- "ro.soc.manufacturer = $(_rex_getprop ro.soc.manufacturer)"
    print -r -- "ro.soc.model        = $(_rex_getprop ro.soc.model)"
    print -r -- "ro.board.platform   = $(_rex_getprop ro.board.platform)"
    print -r -- "ro.hardware         = $(_rex_getprop ro.hardware)"
  fi
}

# -----------------------------------------------------------------------------
# BATTERY — reader + renderer used by the row-2 right segment.
#
# Taste knobs (set in ~/.config/zsh/.zshrc_private or anywhere before the prompt):
#   REX_BATTERY_STYLE      icon (default) | bar | plain
#   REX_BATTERY_HIDE_FULL  1 = hide the battery when it is full/plugged in
#   REX_BATTERY_LOW        red at or below this percent   (default 20)
#   REX_BATTERY_WARN       amber at or below this percent (default 40)
#
# Debugging: run `rex-battery-debug` to see every power_supply entry the reader
# looks at and which one it picked.
# -----------------------------------------------------------------------------

# Reads the *system* battery into REX_BATT_PCT / REX_BATT_STATE.
#  - uses the `read` builtin, never `$(<file 2>...)`, so NULLCMD/READNULLCMD
#    (which some setups point at a pager) cannot interfere;
#  - skips peripherals (mouse, controller, headset: scope=Device);
#  - an unreadable/odd entry is skipped instead of hiding a good battery;
#  - falls back to energy_now/energy_full or charge_now/charge_full.
function _rex_battery() {
  emulate -L zsh
  typeset -g REX_BATT_PCT= REX_BATT_STATE=
  local d type scope cap state now full
  local -a cands
  cands=( /sys/class/power_supply/(BAT|CMB)*(N) /sys/class/power_supply/*(N) )

  for d in $cands; do
    type= scope= cap= state= now= full=
    { read -r type < $d/type } 2>/dev/null
    [[ $type == Battery ]] || continue
    { read -r scope < $d/scope } 2>/dev/null
    [[ $scope == Device ]] && continue

    { read -r cap < $d/capacity } 2>/dev/null
    if [[ $cap != <-> ]]; then
      cap= now= full=
      { read -r now < $d/energy_now; read -r full < $d/energy_full } 2>/dev/null
      if [[ $now != <-> || $full != <-> ]]; then
        now= full=
        { read -r now < $d/charge_now; read -r full < $d/charge_full } 2>/dev/null
      fi
      [[ $now == <-> && $full == <-> ]] && (( full > 0 )) && cap=$(( 100 * now / full ))
    fi
    [[ $cap == <-> ]] || continue

    (( cap > 100 )) && cap=100
    { read -r state < $d/status } 2>/dev/null
    REX_BATT_PCT=$cap
    REX_BATT_STATE=$state
    return 0
  done

  # macOS fallback when the same file is reused outside Linux.
  if (( $+commands[pmset] )); then
    local batt
    batt=$(pmset -g batt 2>/dev/null)
    if [[ $batt =~ '([0-9]+)%' ]]; then
      REX_BATT_PCT=${match[1]}
      case $batt in
        *discharging*) REX_BATT_STATE=Discharging ;;
        *charging*)    REX_BATT_STATE=Charging ;;
        *charged*)     REX_BATT_STATE=Full ;;
        *)             REX_BATT_STATE=Unknown ;;
      esac
      return 0
    fi
  fi
  return 1
}

# Sets REPLY to a prompt-escaped, coloured battery string; fails when there is
# no battery (or it is hidden by REX_BATTERY_HIDE_FULL).
function _rex_battery_text() {
  emulate -L zsh
  REPLY=
  _rex_battery || return 1

  local pct=$REX_BATT_PCT state=$REX_BATT_STATE
  local style=${REX_BATTERY_STYLE:-icon}
  local low=${REX_BATTERY_LOW:-20} warn=${REX_BATTERY_WARN:-40}
  local plugged=0 charging=0 color=183 glyph text
  local -a levels
  levels=(󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)

  [[ $state == Charging ]] && charging=1
  [[ $state == (Charging|Full|Not\ charging) ]] && plugged=1
  [[ ${REX_BATTERY_HIDE_FULL:-0} == 1 && $state == (Full|Not\ charging) ]] && return 1

  if (( plugged )); then
    color=46
  elif (( pct <= low )); then
    color=196
  elif (( pct <= warn )); then
    color=220
  fi

  if (( charging )); then
    glyph='󰂄'
  elif [[ $state == (Full|Not\ charging) ]]; then
    glyph='󰂅'
  else
    glyph=$levels[$(( pct / 10 + 1 ))]
  fi

  case $style in
    bar)
      local n=$(( (pct + 10) / 20 )) i bar=
      for (( i = 1; i <= 5; i++ )); do
        (( i <= n )) && bar+='▰' || bar+='▱'
      done
      text="$bar ${pct}%%" ;;
    plain)
      text="${pct}%%"
      (( plugged )) && text+=' ⚡' ;;
    *)
      text="$glyph ${pct}%%" ;;
  esac

  REPLY="%F{$color}${text}%f"
}

function rex-battery-debug() {
  emulate -L zsh
  local d f
  for d in /sys/class/power_supply/*(N); do
    print -r -- "${d:t}:"
    for f in type scope status capacity energy_now energy_full charge_now charge_full; do
      [[ -e $d/$f ]] && print -r -- "  $f = $(command cat -- $d/$f 2>&1)"
    done
  done
  (( $+commands[pmset] )) && command pmset -g batt
  if _rex_battery; then
    print -r -- "picked: ${REX_BATT_PCT}% (${REX_BATT_STATE:-unknown state})"
  else
    print -r -- 'picked: nothing (no system battery found)'
  fi
}

# Row-2 right side: user@host at clock with battery (battery only if one exists).
# One segment, so the row never looks like unrelated widgets with big gaps.
function prompt_rex_host_status() {
  local user=${USER:-%n}
  local host=${HOST:-${HOSTNAME:-$(hostname 2>/dev/null)}}
  local now
  strftime -s now '%H:%M' ${EPOCHSECONDS:-0} 2>/dev/null || now=$(date +%H:%M 2>/dev/null)

  # user@host in teal, 'at' dimmed, clock in gold
  local text="%F{213}${user}@${host}%f %F{99}at%f %F{220}${now}%f"
  _rex_battery_text && text+=" %F{99}with%f ${REPLY}"

  p10k segment -f 250 -t "$text"
}

function prompt_incognito_flag() {
  [[ ${REX_INCOGNITO:-} == 1 ]] || return 0
  p10k segment -f 255 -t "%K{234}%F{177}%B󰛐%b%k%f %F{177}incognito%f"
}

function prompt_sudocheck() {
  case ${REX_SUDO:-} in
    root)
      p10k segment -f 255 -t "%K{234}%F{196}%B󰌆%b%k%f %F{196}root%f"
      ;;
    sudo)
      p10k segment -f 255 -t "%K{234}%F{220}%B󰌆%b%k%f %F{220}sudo%f"
      ;;
  esac
}

# -----------------------------------------------------------------------------
# NETWORK IDENTITY
# -----------------------------------------------------------------------------

function prompt_rex_network() {
  local -a parts
  local sep="%F{245} · %f"
  # Local/private address: router glyph, cool blue-violet rather than cyan.
  [[ -n ${REX_LOCAL_IP:-} ]] && parts+=("%K{234}%F{75}%B󰒍%b%k%f %F{75}${REX_LOCAL_IP}%f")
  # Public address: web glyph, separate violet accent.
  [[ -n ${REX_PUBLIC_IP:-} ]] && parts+=("%K{234}%F{135}%B󰖟%b%k%f %F{135}${REX_PUBLIC_IP}%f")
  (( ${#parts} )) || return 0
  p10k segment -f 255 -t "${(pj.$sep.)parts}"
}

# -----------------------------------------------------------------------------
# DIRECTORY
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_DIR_FOREGROUND=39
typeset -g POWERLEVEL9K_DIR_BACKGROUND=
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=54
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=28
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=32
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='…/'
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
typeset -g POWERLEVEL9K_DIR_VISUAL_IDENTIFIER_EXPANSION=

# -----------------------------------------------------------------------------
# GIT — preserve the detailed formatter from the original setup.
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
typeset -g POWERLEVEL9K_VCS_PREFIX=''
# Repository identity: explicitly render the provider glyph ourselves so the
# provider icon, branch icon, and branch name share one Git-state color.
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=''
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=''
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

function _rex_git_provider_glyph() {
  emulate -L zsh
  local remote=${VCS_STATUS_REMOTE_URL:-${VCS_STATUS_PUSH_REMOTE_URL:-}}
  local lower=${remote:l}
  case $lower in
    *github.com:*|*github.com/*) print -r -- '' ;;  # GitHub
    *gitlab.com:*|*gitlab.com/*) print -r -- '' ;;  # GitLab
    *bitbucket.org:*|*bitbucket.org/*) print -r -- '' ;; # Bitbucket
    *codeberg.org:*|*codeberg.org/*) print -r -- '' ;; # Codeberg
    *gitea.*:*|*gitea.*/*) print -r -- '' ;;         # Gitea-like host
    *) print -r -- '' ;;                              # generic Git
  esac
}

function my_git_formatter() {
  emulate -L zsh

  if [[ -n $P9K_CONTENT ]]; then
    typeset -g my_git_format=$P9K_CONTENT
    return
  fi

  # Every Nerd Font glyph we add here gets an explicit high-contrast color.
  local meta='%F{177}'
  local clean='%F{255}'
  local modified='%F{220}'
  local untracked='%F{51}'
  local conflicted='%F{196}'
  local provider_icon=$(_rex_git_provider_glyph)
  local branch_icon
  local reset='%f'
  local branch_color
  local res

  # State is encoded by the provider logo, branch logo and branch name together.
  # clean = green, modified = amber, untracked-only = cyan, conflict = red.
  if (( VCS_STATUS_NUM_CONFLICTED )) || [[ -n $VCS_STATUS_ACTION ]]; then
    branch_color='%F{196}'
  elif (( VCS_STATUS_NUM_STAGED || VCS_STATUS_NUM_UNSTAGED )); then
    branch_color='%F{220}'
  elif (( VCS_STATUS_NUM_UNTRACKED )); then
    branch_color='%F{51}'
  else
    branch_color='%F{46}'
  fi

  local provider="${branch_color}%B${provider_icon}%b${reset}"
  branch_icon="${branch_color}%B${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}%b${reset}"

  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
    (( $#branch > 32 )) && branch[13,-13]='…'
    res+="${provider} ${branch_icon} ${branch_color}%B${branch//\%/%%}%b${reset}"
  fi

  if [[ -n $VCS_STATUS_TAG && -z $VCS_STATUS_LOCAL_BRANCH ]]; then
    local tag=${(V)VCS_STATUS_TAG}
    (( $#tag > 32 )) && tag[13,-13]='…'
    res+="${provider} ${branch_icon} ${meta}#${reset}${clean}${tag//\%/%%}${reset}"
  fi

  [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&
    res+="${provider} ${branch_icon} ${meta}@${reset}${clean}${VCS_STATUS_COMMIT[1,8]}${reset}"

  if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
    res+="${meta}:${reset}${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}${reset}"
  fi

  [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]] &&
    res+=" ${modified}wip"

  (( VCS_STATUS_COMMITS_BEHIND )) && res+=" %F{51}⇣${VCS_STATUS_COMMITS_BEHIND}%f"
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=' '
  (( VCS_STATUS_COMMITS_AHEAD )) && res+="%F{46}⇡${VCS_STATUS_COMMITS_AHEAD}%f"
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" %F{51}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}%f"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=' '
  (( VCS_STATUS_PUSH_COMMITS_AHEAD )) && res+="%F{46}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}%f"
  (( VCS_STATUS_STASHES )) && res+=" %F{220}*${VCS_STATUS_STASHES}%f"
  [[ -n $VCS_STATUS_ACTION ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}%f"
  (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}%f"
  (( VCS_STATUS_NUM_STAGED )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}%f"
  (( VCS_STATUS_NUM_UNSTAGED )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}%f"
  (( VCS_STATUS_NUM_UNTRACKED )) && res+=" %F{51}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}%f${VCS_STATUS_NUM_UNTRACKED}"
  (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─%f"

  typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

# -----------------------------------------------------------------------------
# MISE PROJECT CONTEXT
#
# Do not use P10k's generic *_VERSION_PROJECT_ONLY detection here. A stray
# package.json in $HOME can make a whole home directory look like a Node project.
# mise is the authority: only explicitly configured project tools are shown.
# The result is cached for the current directory, so prompt redraws are cheap.
# -----------------------------------------------------------------------------

typeset -g _REX_MISE_CACHE_PWD=
typeset -g _REX_MISE_CACHE_TEXT=

function prompt_rex_mise_context() {
  (( $+commands[mise] )) || return 0

  if [[ $_REX_MISE_CACHE_PWD != $PWD ]]; then
    local output line tool version
    local -a bits
    _REX_MISE_CACHE_PWD=$PWD
    _REX_MISE_CACHE_TEXT=

    output=$(command mise ls --current --no-header 2>/dev/null) || output=

    while IFS= read -r line; do
      tool=${line%%[[:space:]]*}
      version=${line#*[[:space:]]}
      [[ -n $tool && $version != "$line" ]] || continue
      version=${version%%[[:space:]]*}

      case $tool in
        node|nodejs) bits+=("%F{46}%f ${version}") ;;
        python|python3) bits+=("%F{75}%f ${version}") ;;
        rust) bits+=("%F{208}%f ${version}") ;;
        go) bits+=("%F{39}%f ${version}") ;;
        java) bits+=("%F{196}%f ${version}") ;;
        deno) bits+=("%F{51}%f ${version}") ;;
        bun) bits+=("%F{208}%f ${version}") ;;
        ruby) bits+=("%F{203}%f ${version}") ;;
        php) bits+=("%F{75}%f ${version}") ;;
        *) ;;
      esac
    done <<< "$output"

    (( ${#bits} )) && _REX_MISE_CACHE_TEXT="${(j:  :)bits[1,4]}"
  fi

  [[ -n $_REX_MISE_CACHE_TEXT ]] || return 0
  p10k segment -f 46 -t "$_REX_MISE_CACHE_TEXT"
}

# -----------------------------------------------------------------------------
# NVIDIA — third row, right side only.
# -----------------------------------------------------------------------------

function prompt_nvidia_flag() {
  [[ ${REX_NVIDIA:-} == 1 ]] || return 0

  local icon='󰢮'
  if [[ -r /proc/modules ]] && grep -q '^nvidia ' /proc/modules 2>/dev/null; then
    p10k segment -f 112 -t "%K{234}%F{112}%B${icon}%b%k%f %F{112}NVIDIA%f"
  elif (( $+commands[nvidia-smi] )) && command nvidia-smi -L >/dev/null 2>&1; then
    p10k segment -f 112 -t "%K{234}%F{112}%B${icon}%b%k%f %F{112}NVIDIA%f"
  else
    p10k segment -f 183 -t "%K{234}%F{183}%B${icon}%b%k%f %F{183}NVIDIA?%f"
  fi
}

# -----------------------------------------------------------------------------
# PROMPT ICON VISIBILITY DOCTOR
# -----------------------------------------------------------------------------
function rex-prompt-icons() {
  emulate -L zsh
  print -r -- 'Rex Prompt Icon Audit'
  print -r -- '────────────────────'
  print -r -- "distro    : ${REX_DISTRO_ICON:-?}  color=${REX_DISTRO_COLOR:-?}"
  print -r -- 'repository: custom provider glyph +  branch + shared Git-state color'
  print -r -- 'github   :    gitlab: '
  print -r -- "network   : local=󰒍  public=󰖟"
  print -r -- 'nvidia   : 󰢮  color=87'
  print -r -- 'sudo     : 󰌆  color=220/196'
  print -r -- 'incognito: 󰛐  color=177'
  print -r -- 'battery  : dynamic green/gold/red'
}

# -----------------------------------------------------------------------------
# BATTERY — only appears where the OS exposes one.
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false
typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=203
typeset -g POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=120
typeset -g POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND=120
typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=183
typeset -g POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=
typeset -g POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND=
typeset -g POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND=
typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND=
typeset -g POWERLEVEL9K_BATTERY_STAGES='󰂎󰁾󰁿󰂀󰂁󰂂󰂃󰂄󰂅󰂆󰂇'

# -----------------------------------------------------------------------------
# CLOCK
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_TIME_FOREGROUND=183
typeset -g POWERLEVEL9K_TIME_BACKGROUND=
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=''

# -----------------------------------------------------------------------------
# PREVIOUS COMMAND STATUS + DURATION — third row, right side.
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
typeset -g POWERLEVEL9K_STATUS_OK=true
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=120
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✓'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=120
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✓'
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=203
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=203
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=203
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.1
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2
# Green < 5s, amber 5–30s, red > 30s
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=159
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_SLOW_FOREGROUND=220
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VERY_SLOW_FOREGROUND=196
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_SLOW_THRESHOLD=5
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VERY_SLOW_THRESHOLD=30
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='s'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION='◷'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX=' '

# -----------------------------------------------------------------------------
# COMMAND INPUT
# -----------------------------------------------------------------------------

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND=46
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_FOREGROUND=51
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND=203
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_FOREGROUND=203
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_CONTENT_EXPANSION='❮'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_CONTENT_EXPANSION='❮'

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
