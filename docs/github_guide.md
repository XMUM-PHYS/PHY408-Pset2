# GitHub guide for PHY408 Problem Set 2

This guide takes you from no GitHub account to a submitted pull request. Week 1 covered
`git clone`, `add`, `commit`, `push`, `branch` and `checkout`; the two new things here are
**logging in to GitHub from the terminal** (step 3) and **opening a pull request** (step 7).

Replace `<StudentID>` with your own ID and `<your-username>` with your GitHub user name.

---

## Step 1. Create a GitHub account

Go to <https://github.com> and click **Sign up**. The free plan is all you need.

<!-- LECTURER: screenshot of the GitHub sign-up page -->

## Step 2. Tell Git who you are (once per computer)

```bash
git config --global user.name  "Your Name"
git config --global user.email "the-email-you-used-for-github"
```

## Step 3. Log in from the terminal (once per computer)

GitHub no longer accepts your password for `git push`. Use the GitHub command-line tool:

```bash
sudo apt install gh      # Ubuntu / WSL
brew install gh          # macOS
gh auth login
```

Answer the questions: **GitHub.com**, **HTTPS**, **Yes** (authenticate Git), **Login with a web
browser**. Copy the one-time code, press Enter, paste the code in the browser and approve.

*Alternative:* on GitHub go to **Settings → Developer settings → Personal access tokens →
Tokens (classic) → Generate new token**, tick the **repo** scope, and copy the token. When
`git push` asks for a password, paste the token.

## Step 4. Fork the course repository

Open the course repository and click **Fork** (top right), then **Create fork**. You now have
your own copy at `https://github.com/<your-username>/PHY408-Pset2`.

<!-- LECTURER: screenshot showing the Fork button -->

## Step 5. Clone your fork, create your branch and your folder

```bash
git clone https://github.com/<your-username>/PHY408-Pset2.git
cd PHY408-Pset2
bash check_setup.sh
git branch PHY408_<StudentID>
git checkout PHY408_<StudentID>
mkdir -p students/PHY408_<StudentID>/data
mkdir -p students/PHY408_<StudentID>/plots
cd students/PHY408_<StudentID>
```

Check where you are at any time with `git status`: the first line should say
`On branch PHY408_<StudentID>`.

## Step 6. Work, commit and push regularly

```bash
git add get_data.sh
git commit -m "Part A: add data download script"
git push origin PHY408_<StudentID>
```

Always push to **your branch**, never to `main`. Push at least once a week: you need at least
five commits, pushed in at least two different weeks.

## Step 7. Open the pull request

1. Open your fork on GitHub. After a push you usually see a yellow banner with
   **Compare & pull request**; click it. (Otherwise click **Contribute → Open pull request**.)
2. Check the four boxes at the top:
   - **base repository:** the course repository, **base:** `main`
   - **head repository:** your fork, **compare:** `PHY408_<StudentID>`
3. Title: `PHY408_<StudentID> Pset2 submission`.
4. Fill in the template that appears in the description box.
5. Click **Create pull request**.
6. Copy the link of your pull request and submit it on Moodle.

<!-- LECTURER: screenshot of the Compare & pull request banner -->
<!-- LECTURER: screenshot of the base/head selector with the four boxes highlighted -->

Anything you push to your branch after this, before the deadline, is added to the same pull
request automatically. You do not need to open a new one.

---

## Common problems

| Message | What it means | Fix |
|---|---|---|
| `Support for password authentication was removed` | GitHub refused your password | Do step 3 (`gh auth login` or a token) |
| `src refspec PHY408_... does not match any` | You have no commit on the branch yet, or a typo in the name | Commit something first; check the name with `git branch` |
| `Updates were rejected because the remote contains work...` | Your fork has commits you don't have locally | `git pull origin PHY408_<StudentID>`, then push again |
| `File ... is 2.1 GB; this exceeds GitHub's file size limit` | You committed the data file | Make sure `.gitignore` lists `data/` and `*.root`, then ask the lecturer for help removing it |
| You committed on `main` by mistake | Your work is on the wrong branch | `git checkout -b PHY408_<StudentID>` keeps your work and moves it to a new branch |
