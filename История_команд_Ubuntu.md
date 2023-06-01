$ cat > Домашние_животные

кот;Барсик;3

кот;Том;8

собака;Шарик;6

собака;Джек;9

хомяк;Стив;1

хомяк;Родж;1


$ cat > Вьючные_животные

лошадь;Роза;10

лошадь;Белка;9

верблюд;Сопатый;2

верблюд;Лохматый;4

осел;Иа;1

осел;Рав;2


$ cat Домашние_животные Вьючные_животные > Новый

$ cat Новый 

$ mv Новый Друзья_человека

$ mkdir Животные

$ mv Друзья_человека Животные/

$ wget https://dev.mysql.com/get/mysql-apt-config_0.8.25-1_all.deb

$ sudo dpkg -i mysql-apt-config_0.8.25-1_all.deb

$ sudo apt-get update

$ sudo apt-get install mysql-server

$ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

$ sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

$ sudo dpkg -r google-chrome-stable
