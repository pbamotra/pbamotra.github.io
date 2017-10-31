now="$(date)"

cp -R _site/* ~/Downloads/ynorm/
cd ~/Downloads/ynorm/
git add .
git commit -m "Published: $now"
git push origin master
cd ~/Downloads/pbamotra.github.io/
git add .
git commit -m "Published: $now"
git push origin master
