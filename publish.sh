now="$(date)"

cp -R _site/* ~/Downloads/ynorm/
cd ~/Downloads/ynorm/
git add .
git commit -m "Published: $now"
git push origin master
curl -X POST -d '' https://api.netlify.com/build_hooks/59f91b880b79b70963232f17
cd ~/Downloads/pbamotra.github.io/
git add .
git commit -m "Published: $now"
git push origin master
