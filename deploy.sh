#! bash

set -e

rm -rf .git
rm -r .gitignore
rm -rf download-feathericon.png
rm -rf feathericon-figma.png
rm -rf package.json
rm -rf README.md
rm -rf export.js
rm -rf deploy.sh

if [[ "false" != "$TRAVIS_PULL_REQUEST" ]]; then
	echo "Not deploying pull requests."
	exit
fi

if [[ "master" != "$TRAVIS_BRANCH" ]]; then
	echo "Not on the 'master' branch."
	exit
fi

echo "*.json
*.yml
.DS_store
*.log
.npmignore
note_modules" > .gitignore

git init
git config user.name "featherplain"
git config user.email "${GH_USER_EMAIL}"
git add .
git commit --quiet -m "Deploy from travis"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:release > /dev/null 2>&1
