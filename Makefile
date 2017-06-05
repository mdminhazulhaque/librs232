PREFIX = /usr/local

LIBRARY = librs232.so
OBJS = src/rs232.o

ifeq ($(WIN32),1)
	OBJS += src/rs232_windows.o
else
	OBJS += src/rs232_posix.o
endif

CFLAGS += -Iinclude -fPIC -Wall -ansi -pedantic -W -Wmissing-prototypes -Wmissing-declarations -Werror -std=gnu99 -O2
LDFLAGS += -shared

$(LIBRARY): $(OBJS)
	$(LD) -o $(LIBRARY) $(LDFLAGS) $(OBJS)
.c.o:
	$(CC) $(CFLAGS) -o $@ -c $?
clean:
	$(RM) $(LIBRARY) src/*.o
install:
	$(shell) mkdir -p $(PREFIX)/lib
	$(shell) mkdir -p $(PREFIX)/include
	$(shell) cp ${LIBRARY} $(PREFIX)/lib
	$(shell) cp -r include/librs232 $(PREFIX)/include
