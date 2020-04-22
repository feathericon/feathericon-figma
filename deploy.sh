#! bash

set -e

rm -rf .git
rm -rf node_modules
rm -r .gitignore
rm -r download-feathericon.png
rm -r feathericon-figma.png
rm -r package.json
rm -r README.md
rm -r export.js
rm -r deploy.sh

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
