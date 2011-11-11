COUNT=1
rm -r paginas
rm -r pictures
mkdir paginas
mkdir pictures
for page_sufix in  `grep href downloads.aspx\?x\=mtg%2Fdaily%2Fdownloads%2Fwallpapers | grep /magic/magazine/article.aspx | sed 's/^.*<a href="//' | sed 's/".*$//'`
do
	echo $page_sufix
	cd paginas
	NAME="pagina_$COUNT.html"
	wget -O $NAME "www.wizards.com$page_sufix"
	COUNT=$(($COUNT+1))
	for image in `grep href $NAME | grep x1024 | grep -o -E 'href="([^"]*)"' | cut -f2 -d'='| sed  -e 's/"//g'`
	do
		cd ../pictures
		echo "Downloading $image"
		wget "$image"
		cd ../paginas
	done
	cd ..
done
