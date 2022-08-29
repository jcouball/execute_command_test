git config --global user.name "Test User"
git config --global user.email "test@example.com"

git config --global init.defaultBranch main

mkdir test_repo
cd test_repo

git init

echo "main" > file1.txt
git add file1.txt
git commit -m "Add file1 on main"

git checkout -b branch1
echo "branch1" > file2.txt
echo "branch1" > file3.txt
git add file2.txt file3.txt
git commit -m "Add file2 and file3 on branch1"

git checkout main
git checkout -b branch2
echo "branch2" > file4.txt
echo "branch2" > file5.txt
git add file4.txt file5.txt
git commit -m "Add file4 and file5 on branch2"

git checkout main
git merge branch1 branch2 -m "Merge branch1 and branch2"

dir *.txt
