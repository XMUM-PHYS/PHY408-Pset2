# PHY408 Problem Set 2: From Raw Data to a Fitted Z Boson

Course repository for PHY408 Data Intensive Science, Xiamen University Malaysia.

## What is here

| File | Purpose |
|---|---|
| `PHY408_Pset2_handout.pdf` | The assignment: tasks, marks and rubric |
| `docs/github_guide.md` | Step-by-step GitHub guide: account, login, fork, branch, pull request |
| `check_setup.sh` | Checks that ROOT, Python, Jupyter, Git and your GitHub login are ready |
| `top_mass.csv` | Top-quark mass measurements for Part A6 |
| `students/` | Each student works in their own folder `students/PHY408_<StudentID>/` |

## Quick start

```bash
# after forking this repository on GitHub:
git clone https://github.com/<your-username>/PHY408-Pset2.git
cd PHY408-Pset2
bash check_setup.sh
git branch PHY408_<StudentID>
git checkout PHY408_<StudentID>
```

Then follow `docs/github_guide.md` and the handout.

## Rules

- Work only inside `students/PHY408_<StudentID>/` on the branch `PHY408_<StudentID>`.
- **Never commit data files.** The CMS file is 2.1 GB; download it with your own `get_data.sh`.
- This repository is public. Copying another student's code or results is plagiarism.
- Submit by opening a pull request to this repository and posting its link on Moodle.
