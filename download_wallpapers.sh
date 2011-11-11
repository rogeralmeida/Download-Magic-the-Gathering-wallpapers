rm -r pictures
mkdir pictures
cd pictures
for page_sufix in  `curl http://www.wizards.com/magic/magazine/downloads.aspx?x=mtg/daily/downloads/wallpapers |grep href | grep /magic/magazine/article.aspx | sed 's/^.*<a href="//' | sed 's/".*$//'`
do
	for image in `curl "www.wizards.com$page_sufix" | grep href | grep x1024 | grep -o -E 'href="([^"]*)"' | cut -f2 -d'='| sed  -e 's/"//g'`
	do
		echo "$image" | awk -F"/" '{print $NF }'
		if [ ! -f `echo "$image" | awk -F"/" '{print $NF }'` ]; then
			echo "Downloading $image"
			wget "$image"
		fi
	done
done
