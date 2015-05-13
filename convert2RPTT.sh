git filter-branch --prune-empty --subdirectory-filter CaseStudies/Case6PttGossiping/RPTT/ --tag-name-filter cat -- --all
git remote remove origin
git remote add github https://github.com/agilearning/RPTT.git
git push -f origin master
