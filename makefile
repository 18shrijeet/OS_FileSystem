username = $(shell shrijeet_abhinav)
SRCDIR = src
files = $(SRCDIR)/file_sys_main.c $(SRCDIR)/file_sys_operations.c $(SRCDIR)/file_sys_tree.c $(SRCDIR)/file_sys_map.c $(SRCDIR)/file_sys_disc.c
opflag = -o fs
flags = `pkg-config fuse --cflags --libs` -DFUSE_USE_VERSION=25 -lm -g

all: run

run: compile
	./fs -f /home/$(username)/Desktop/mountpoint

debugrun: dcompile
	valgrind --track-origins=yes ./fs -d -f -s /home/$(username)/Desktop/mountpoint

compile: checkdir
	gcc -Wall -g $(files) $(opflag) $(flags)

dcompile: checkdir	
	gcc -Wall -g $(files) $(opflag) $(flags)

checkdir:
	if [ -d "/home/$(username)/Desktop/mountpoint" ]; then echo "mountpoint exists"; else mkdir /home/$(username)/Desktop/mountpoint; fi
