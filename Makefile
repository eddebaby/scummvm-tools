SRC=.

CC      := gcc
CXX     := g++
CFLAGS  += -g -O -Wall -Wuninitialized -Wno-long-long -Wno-multichar
# LDFLAGS +=

# Additional warnings
CFLAGS+= -Wshadow
CFLAGS+= -pedantic
CFLAGS+= -Wpointer-arith -Wcast-qual -Wcast-align
# -Wconversion
CFLAGS+= -Wshadow -Wimplicit -Wundef -Wwrite-strings 

# Uncomment this if you are on a big endian system
# CFLAGS += -DSCUMM_BIG_ENDIAN

TARGETS := \
	compress_queen$(EXEEXT) \
	compress_saga$(EXEEXT) \
	compress_san$(EXEEXT) \
	compress_scumm_sou$(EXEEXT) \
	compress_simon$(EXEEXT) \
	compress_sword1$(EXEEXT) \
	compress_sword2$(EXEEXT) \
	dekyra$(EXEEXT) \
	descumm$(EXEEXT) \
	desword2$(EXEEXT) \
	kyra_unpak$(EXEEXT) \
	loom_tg16_extract$(EXEEXT) \
	mm_nes_extract$(EXEEXT) \
	rescumm$(EXEEXT) \
	simon1decr$(EXEEXT)

all: $(TARGETS)

compress_san$(EXEEXT): compress_san.o util.o
	$(CXX) $(LDFLAGS) -o $@ $+ -lz

descumm$(EXEEXT): descumm-tool.o descumm.o descumm6.o descumm-common.o util.o
	$(CXX) $(LDFLAGS) -o $@ $+

desword2$(EXEEXT): desword2.o util.o
	$(CXX) $(LDFLAGS) -o $@ $+

dekyra$(EXEEXT): dekyra.o util.o
	$(CXX) $(LDFLAGS) -o $@ $+

kyra_unpak$(EXEEXT): kyra_unpak.o util.o
	$(CXX) $(LDFLAGS) -o $@ $+

compress_scumm_sou$(EXEEXT): compress_scumm_sou.o compress.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

loom_tg16_extract$(EXEEXT): loom_tg16_extract.o
	$(CC) $(LDFLAGS) -o $@ $+

mm_nes_extract$(EXEEXT): mm_nes_extract.o
	$(CC) $(LDFLAGS) -o $@ $+

compress_queen$(EXEEXT): compress_queen.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

rescumm$(EXEEXT): rescumm.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

compress_saga$(EXEEXT): compress_saga.o compress.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

simon1decr$(EXEEXT): simon1decr.o
	$(CC) $(LDFLAGS) -o $@ $+

compress_simon$(EXEEXT): compress_simon.o compress.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

compress_sword1$(EXEEXT): compress_sword1.o compress.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

compress_sword2$(EXEEXT): compress_sword2.o compress.o util.o
	$(CC) $(LDFLAGS) -o $@ $+

descumm.o descumm6.o descumm-common.o descumm-tool.o: descumm.h util.h
compress_saga.o compress_scumm_sou.o compress_simon.o compress_sword1.o compress_sword2.o compress.o: util.h compress.h
desword2.o compress_queen.o rescumm.o util.o: util.h

clean:
	rm -f *.o $(TARGETS)

.cpp.o:
	$(CXX) $(CFLAGS) $(CPPFLAGS) -c $(<) -o $*.o

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $(<) -o $*.o
