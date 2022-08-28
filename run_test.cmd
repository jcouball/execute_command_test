mkdir test_repo
cd test_repo
git config user.name "Test User"
git config user.email "test@example.com"

git init

git checkout main
git checkout -b branch1
echo "branch1" > file1.txt
echo "branch1" > file2.txt
git add file1.txt file2.txt
git commit -m "Add file1 and file2 on branch1"

git checkout main
git checkout -b branch2
echo "branch2" > file3.txt
echo "branch2" > file4.txt
git add file3.txt file4.txt
git commit -m "Add file3 and file4 on branch2"

git checkout main
git merge branch1 branch2

dir *.txt
