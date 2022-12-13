
consul :
	ecpg consul_tennis.sql -o consul_tennis.c -I /usr/include/postgresql/
	gcc consul_tennis.c -g -o consul_tennis.a -I /usr/include/postgresql/ -lecpg



update :
	ecpg update_tennis.sql -o update_tennis.c -I /usr/include/postgresql/
	gcc update_tennis.c -g -o update_tennis.a -I /usr/include/postgresql/ -lecpg