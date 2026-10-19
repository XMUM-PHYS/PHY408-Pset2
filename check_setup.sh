#!/bin/bash
# ------------------------------------------------------------------
# PHY408 Problem Set 2 -- setup check
# Run from anywhere inside your clone:   bash check_setup.sh
# It only reads your setup; it does not change anything.
# ------------------------------------------------------------------

pass=0; warn=0; fail=0
ok()   { echo "  [ OK ]  $1"; pass=$((pass+1)); }
wn()   { echo "  [WARN]  $1"; warn=$((warn+1)); }
bad()  { echo "  [FAIL]  $1"; fail=$((fail+1)); }

echo "PHY408 Pset 2 setup check"
echo "========================="

# 1. Python
echo "1. Python"
if command -v python3 >/dev/null 2>&1; then
    ok "python3 found: $(python3 --version 2>&1)"
else
    bad "python3 not found. Activate your course environment (mamba activate ...)."
fi

# 2. ROOT / PyROOT
echo "2. ROOT and PyROOT"
if python3 -c "import ROOT" >/dev/null 2>&1; then
    ok "PyROOT imports, ROOT version $(python3 -c 'import ROOT; print(ROOT.gROOT.GetVersion())' 2>/dev/null)"
    if python3 -c "import ROOT; ROOT.RDataFrame(1); ROOT.TMath.BreitWigner(91.,91.,2.5)" >/dev/null 2>&1; then
        ok "RDataFrame and TMath::BreitWigner work"
    else
        bad "ROOT imports, but RDataFrame or TMath failed. Reinstall ROOT in your environment."
    fi
else
    bad "'import ROOT' failed. Install it in your environment: mamba install -c conda-forge root"
fi

# 3. Jupyter
echo "3. Jupyter"
if command -v jupyter >/dev/null 2>&1; then
    ok "jupyter found"
else
    bad "jupyter not found: mamba install -c conda-forge jupyterlab"
fi

# 4. Download tool
echo "4. Download tool"
if command -v wget >/dev/null 2>&1; then
    ok "wget found"
else
    bad "wget not found: sudo apt install wget  (macOS: brew install wget)"
fi

# 5. Git identity
echo "5. Git"
if command -v git >/dev/null 2>&1; then
    ok "git found: $(git --version)"
    name=$(git config --global user.name); email=$(git config --global user.email)
    if [ -n "$name" ] && [ -n "$email" ]; then
        ok "git identity set: $name <$email>"
    else
        bad "git identity missing. Run: git config --global user.name \"Your Name\" and git config --global user.email \"you@example.com\""
    fi
else
    bad "git not found: sudo apt install git"
fi

# 6. GitHub login
echo "6. GitHub login (needed for git push)"
if command -v gh >/dev/null 2>&1; then
    if gh auth status >/dev/null 2>&1; then
        ok "logged in to GitHub with the gh tool"
    else
        bad "gh is installed but you are not logged in. Run: gh auth login"
    fi
else
    wn "gh tool not installed. Either install it (sudo apt install gh, then gh auth login) or use a personal access token as your password when git push asks."
fi

# 7. Repository and branch
echo "7. Repository and branch"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git rev-parse --abbrev-ref HEAD)
    remote=$(git config --get remote.origin.url)
    ok "inside a git repository (origin: $remote)"
    case "$branch" in
        PHY408_*) ok "on your branch: $branch" ;;
        main|master) wn "you are on '$branch'. Create and switch to your branch: git branch PHY408_<StudentID>; git checkout PHY408_<StudentID>" ;;
        *) wn "on branch '$branch'. The branch must be named PHY408_<StudentID>." ;;
    esac
else
    wn "not inside a git repository. Run this script from inside your clone of the course repository."
fi

# 8. Data file (optional until Part C)
echo "8. CMS data file (needed from Part C)"
datafile=$(find . -maxdepth 4 -name "Run2012BC_DoubleMuParked_Muons.root" 2>/dev/null | head -n 1)
if [ -n "$datafile" ]; then
    size=$(du -h "$datafile" | cut -f1)
    ok "found $datafile ($size; the complete file is about 2.1G)"
else
    wn "data file not found yet. Write get_data.sh (Part A6) and run it from your student folder."
fi

echo "========================="
echo "Summary: $pass OK, $warn warnings, $fail failures"
if [ "$fail" -gt 0 ]; then
    echo "Fix the FAIL items before you start. Ask in the lab if you are stuck."
    exit 1
fi
echo "You are ready to start."
