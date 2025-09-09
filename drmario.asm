################# CSC258 Assembly Final Project ###################
# This file contains my implementation of Dr Mario.
# Aakaash Rohra, 1009948737
# I assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       1
# - Unit height in pixels:      1
# - Display width in pixels:    32
# - Display height in pixels:   32
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
ADDR_DSPL:
    .word 0x10008000
ADDR_KBRD:
    .word 0xffff0000

# first int is width, second is height, third is starting position (in bytes) on display, the rest is the map
# used this website to convert my 32x32 pixel designs to hex codes (hope this is allowed!) 
# https://onlinetools.com/image/convert-image-to-hex-codes
PLAY_AREA_DATA: 
    .word 10, 19, 268,
          0x000000, 0x000000, 0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 0x000000, 0x000000, 
          0x808080, 0x808080, 0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 0x808080, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080,
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x808080, 
          0x808080, 0x808080, 0x808080, 0x808080, 0x808080, 0x808080, 0x808080, 0x808080, 0x808080, 0x808080         
LOGO_DATA:
    .word 22, 8, 2964,
          0xff0000, 0xff0000, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0xffff00, 0xffff00, 0xffff00, 0x000000, 0xff0000, 0xff0000,
          0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0xffff00, 0xffff00, 0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0xff0000, 
          0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xffff00, 0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0xff0000, 
          0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xffff00, 0xff0000, 0xff0000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0xff0000, 
          0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0xffff00, 0x000000, 0xffff00, 0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0xff0000, 
          0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xffff00, 0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0xff0000, 
          0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xffff00, 0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0x000000, 0xff0000, 0x000000, 0xff0000, 
          0xff0000, 0xff0000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0xffffff, 0xffff00, 0x000000, 0xffff00, 0xff0000, 0x000000, 0xff0000, 0x0094ff, 0x000000, 0x0094ff, 0xffff00, 0xffff00, 0xffff00, 0xff0000, 0xff0000, 0xff0000
MARIO_DATA:
    .word 15, 19, 320,
          0xff0000, 0xff0000, 0x0094ff, 0x0094ff, 0x000000, 0xffffff, 0xffffff, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0x000000, 0x000000, 0x000000, 
          0xff0000, 0xff0000, 0x0094ff, 0x0094ff, 0xffffff, 0x000000, 0xffffff, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0x000000, 0x000000, 
          0x000000, 0x000000, 0xffeeaa, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 
          0x000000, 0xffeeaa, 0xffeeaa, 0x000000, 0x000000, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0xffeeaa, 0x772f00, 0x772f00, 0x772f00, 0x000000, 0x000000, 
          0x000000, 0xffeeaa, 0xffeeaa, 0xffeeaa, 0x000000, 0xffffff, 0x000000, 0xffeeaa, 0x000000, 0xffffff, 0x772f00, 0x772f00, 0xffeeaa, 0x000000, 0x000000, 
          0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffeeaa, 0xffffff, 0xffffff, 0xffeeaa, 0x772f00, 0xffcd2b, 0x000000, 0x000000, 
          0x000000, 0x000000, 0xffffff, 0xffffff, 0x000000, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0x772f00, 0xffeeaa, 0xffeeaa, 0x000000, 0x000000, 0x000000, 
          0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffeeaa, 0xff0000, 0xff0000, 0xff0000, 0xffeeaa, 0xffeeaa, 0xffffff, 0x000000, 0x000000, 0x000000, 
          0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xffffff, 0xffffff, 0x000000, 
          0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 
          0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xcccccc, 0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0xffffff, 
          0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xe2e2e2, 0xe2e2e2, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0xffffff, 
          0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xeaeaea, 0xe2e2e2, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffeeaa, 0xffeeaa, 
          0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffeeaa, 
          0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xcccccc, 0xcccccc, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 
          0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xcccccc, 0xcccccc, 0xcccccc, 0xcccccc, 0xcccccc, 0xcccccc, 0xcccccc, 0xffffff, 0x000000, 0x000000, 
          0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xcccccc, 0xcccccc, 0xcccccc, 0x000000, 0xcccccc, 0xcccccc, 0xcccccc, 0x000000, 0x000000, 0x000000, 
          0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0xcccccc, 0x000000, 0xcccccc, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 
          0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0x000000
VIRUS_DATA:
    .word 2, 2, 1724,
          0x000000, 0x000000,
          0x000000, 0x000000

GAME_OVER_DATA:
    .word 32, 32, 0,
          0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0xffff00, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0xffff00, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0xffff00, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0xffff00, 0xffff00, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0x000000, 0x000000, 0xffff00, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0xff0000, 0x000000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0x000000, 0xff0000, 0x000000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0xffff00, 0xffff00, 0xffff00, 0xffff00, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0xff0000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0xffff00, 0x000000, 0xffff00, 0xffff00, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0x000000, 0x000000, 0xff0000, 0x000000, 0xff0000, 0xff0000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0xffff00, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0xffff00, 0xffff00, 0xffff00, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0xffff00, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0xffff00, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x0094ff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0xffff00, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x0094ff, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x0094ff, 0x000000, 0x000000, 0x0094ff, 0x000000, 0xffff00, 0xffff00, 0x000000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000

RED:
    .word 0xff0000
BLUE:
    .word 0x0094ff
YELLOW:
    .word 0xffff00
BLACK:
    .word 0x000000

# format is pitch, duration
DOWN_SFX:
    .word 42, 10
SIDEWAYS_SFX:
    .word 44, 10
ROTATE_SFX:
    .word 37, 10
BLOCKED_SFX:
    .word 49, 10
PLACE_CAPSULE_SFX:
    .word 31, 10
COMPLETE_ROW_SFX:
    .word 77, 30

# first 4 spaces (16 bytes) are each of the viruses. when scanning for blocks to drop, skip these.
# past this, capsules cover 8 bytes. the first 4 are an address to the location of that half in PLAY_AREA_DATA, the next 4 are for the other half.
# space of 512 is semi-arbitrary. (8 columns * 16 rows * 4 bytes = 512, * 2 for padding = 1024). Padding is because blocks get erased but that
# space is never used again the way this is implemented. There are potentially better ways to implement this.
CAPSULES:
    .space 1

##############################################################################
	.text
	.globl main

main:
    addi $gp, $zero, 1000 # $gp will be target for auto-dropping capsule
start_new_game:
    addi $v1, $zero, 0    # $v1 will be counter in milliseconds (for gravity mechanics)
    # I am dropping register conventions at times due to lack of registers available. (v1 and gp would not be used like this, conventionally)
    la $t1, COMPLETE_ROW_SFX
    jal short_sound
    lw $s5, BLACK
    lw $t0, ADDR_DSPL
    add $t6, $zero, $zero
    addi $t7, $zero, 1024
initialize_board:
    beq $t6, $t7, initialize_viruses
    sw $s5, 0($t0)
    addi $t0, $t0, 4
    addi $t6, $t6, 1
    j initialize_board
initialize_viruses:
    la $s1, VIRUS_DATA
    addi $s6, $zero, 0
    la $s7, CAPSULES
    jal generate_half
    jal virus_generate
    jal generate_half
    jal virus_generate
    jal generate_half
    jal virus_generate
    jal generate_half
    jal virus_generate
draw_map:    # draw the map and start the game loop
    addi $t0, $zero, 68    # used to keep track of where in PLAY_AREA_DATA to store placed blocks
    la $t5, PLAY_AREA_DATA
    jal draw_image
    la $t5, LOGO_DATA
    jal draw_image
    la $t5, MARIO_DATA
    jal draw_image
    la $t5, VIRUS_DATA
    jal draw_image
    jal generate_half
    addi $s2, $t1, 0
    jal generate_half
    addi $s3, $t1, 0
    jal draw_pill_starting
    j game_loop
    
draw_image:        # function to draw image onto bitmap display. assumes $t5 has been set correctly
    lw $s0, ADDR_DSPL    # s0 will always be ADDR_DSPL
    lw $t1, 0($t5)    # t1 = width of image
    lw $t2, 4($t5)    # t2 = height of image
    lw $t7, 8($t5)    # t7 = starting point on bitmap display
    addi $t5, $t5, 12
    add $s0, $s0, $t7
    add $t3, $zero, $zero    # t3 = current row tracker
    addi $t4, $zero, 1    # t4 = current column tracker
    mul $t6, $t1, 4    # bytes in 1 row
    j draw_row 
draw_row:
    beq $t1, $t3, increment_row
    lw $a0, 0($t5)    # load current value in data array to a0
    sw $a0, 0($s0)
    addi $s0, $s0, 4
    addi $t5, $t5, 4    # increment to next data array value
    addi $t3, $t3, 1
    j draw_row
increment_row:
    beq $t2, $t4, end_draw
    sub $s0, $s0, $t6    # move to start of row
    addi $s0, $s0, 128    # move to next column
    add $t3, $zero, $zero    # reset row tracker to 0
    addi $t4, $t4, 1    # increment column tracker
    j draw_row
end_draw:
    jr $ra
  
generate_half:        # generate a random colour and store its hex in $t1
    li $v0, 42
    li $a0, 0
    li $a1, 3
    syscall
    beq $a0, 0, red_half
    beq $a0, 1, blue_half
    beq $a0, 2, yellow_half
red_half:
    lw $t1, RED
    jr $ra
blue_half:
    lw $t1, BLUE
    jr $ra
yellow_half:
    lw $t1, YELLOW
    jr $ra

draw_pill_starting:        # draw pill at starting location (and set $s0 to starting location)
    lw $s0, ADDR_DSPL
    addi $s0, $s0, 412
    sw $s2, 0($s0)
    sw $s3, 4($s0)
    add $s4, $zero, $zero
    jr $ra

draw_pill:        # send to horizontal if $s4 == 0, or vertical if $s4 == 1
    beq $s4, 0, draw_pill_horizontal
    beq $s4, 1, draw_pill_vertical
draw_pill_horizontal:        # draw pill horizontally at set location $s0. assumes $s2 and $s3 set correctly
    sw $s2, 0($s0)
    sw $s3, 4($s0)
    j game_loop
draw_pill_vertical:        # draw pill vertically at set location $s0. assumes $s2 and $s3 set correctly
    sw $s2, 0($s0)
    sw $s3, -128($s0)
    j game_loop
    
remove_pill:        
    beq $s4, 0, remove_pill_horizontal
    beq $s4, 1, remove_pill_vertical
remove_pill_horizontal:
    sw $s5, 0($s0)
    sw $s5, 4($s0)
    jr $ra
remove_pill_vertical:
    sw $s5, 0($s0)
    sw $s5, -128($s0)
    jr $ra

virus_generate:    
    li $v0, 42
    li $a0, 0
    li $a1, 87
    syscall
    addi $t8, $a0, 94    # arithmetic to navigate to valid spot for virus (bottom half of play area)
    mul $t8, $t8, 4
    la $t5, PLAY_AREA_DATA
    add $t5, $t5, $t8
    
    lw $t7, 0($t5)
    beq $t7, $s5, virus_draw    # if branch doesn't occur, navigated to border, try again
    j virus_generate
virus_draw:
    sw $t5, 0($s7)       # store address of virus location into CAPSULES array
    addi $s7, $s7, 4
    sw $t1, 0($t5)
    sw $t1, 12($s1)       # store colour of virus into VIRUS_DATA array
    addi $s1, $s1, 4
    jr $ra

game_loop:
    lw $t7, BLACK
    lw $s1, ADDR_KBRD    # s1 is ADDR_KBRD
    lw $t8, 0($s1)
    beq $t8, 1, keyboard_input

    la $t8, PLAY_AREA_DATA    # these lines check if the spawn area for the capsule is full and quits the game if so
    addi $t8, $t8, 68
    lw $t9, 0($t8)
    bne $t9, $s5, game_over
    addi $t8, $t8, 4
    lw $t9, 0($t8)
    bne $t9, $s5, game_over

    li $v0, 32    # sleep for about 1/60th of a second
    li $a0, 16
    syscall
    addi $v1, $v1, 16    # add 16 milliseconds having passed (could be more if keyboard input occurred, but at least 16 have passed due to sleep)
    bge $v1, $gp, gravity
    
    j game_loop

gravity:
    addi $v1, $zero, 0
    bge $gp, 100, increase_speed
    j down_collision_check
increase_speed:
    subi $gp, $gp, 2
    j down_collision_check

keyboard_input:
    lw $a0, 4($s1)
    beq $a0, 0x73, down_collision_check
    beq $a0, 0x61, left_collision_check
    beq $a0, 0x64, right_collision_check
    beq $a0, 0x77, w_press
    beq $a0, 0x71, quit
    beq $a0, 0x70, pause
    j game_loop

pause:
    lw $a2, ADDR_DSPL
    addi $a2, $a2, 3204
    li $a1, 0xffffff
    sw $a1, 0($a2)
    sw $a1, 8($a2)
    sw $a1, 128($a2)
    sw $a1, 136($a2)
    sw $a1, 256($a2)
    sw $a1, 264($a2)
    sw $a1, 384($a2)
    sw $a1, 392($a2)
    lw $s1, ADDR_KBRD
    lw $t8, 0($s1)
    bne $t8, 1, pause
    lw $a0, 4($s1)
    beq $a0, 0x70, unpause
    j pause
unpause:
    lw $a2, ADDR_DSPL
    addi $a2, $a2, 3204
    sw $s5, 0($a2)
    sw $s5, 8($a2)
    sw $s5, 128($a2)
    sw $s5, 136($a2)
    sw $s5, 256($a2)
    sw $s5, 264($a2)
    sw $s5, 384($a2)
    sw $s5, 392($a2)
    j game_loop

down_collision_check:
    beq $s4, 0, down_collision_check_horizontal
    beq $s4, 1, down_collision_check_vertical
down_collision_check_horizontal:
    lw $t5, 128($s0)
    lw $t6, 132($s0)
    bne $t5, $s5, down_collision
    bne $t6, $s5, down_collision
    j s_press
down_collision_check_vertical:
    lw $t6, 128($s0)
    bne $t6, $s5, down_collision
    j s_press
s_press:
    la $t1, DOWN_SFX
    jal short_sound
    addi $t0, $t0, 40
    jal remove_pill
    addi $s0, $s0, 128
    j draw_pill

left_collision_check:
    beq $s4, 0, left_collision_check_horizontal
    beq $s4, 1, left_collision_check_vertical
left_collision_check_horizontal:
    lw $t6, -4($s0)
    bne $t6, $s5, invalid_move
    j a_press
left_collision_check_vertical:
    lw $t5, -4($s0)
    lw $t6, -132($s0)
    bne $t5, $s5, invalid_move
    bne $t6, $s5, invalid_move
    j a_press
a_press:
    la $t1, SIDEWAYS_SFX
    jal short_sound
    addi $t0, $t0, -4
    jal remove_pill
    addi $s0, $s0, -4
    j draw_pill

right_collision_check:
    beq $s4, 0, right_collision_check_horizontal
    beq $s4, 1, right_collision_check_vertical
right_collision_check_horizontal:
    lw $t6, 8($s0)
    bne $t6, $s5, invalid_move
    j d_press
right_collision_check_vertical:
    lw $t5, 4($s0)
    lw $t6, -124($s0)
    bne $t5, $s5, invalid_move
    bne $t6, $s5, invalid_move
    j d_press
d_press:
    la $t1, SIDEWAYS_SFX
    jal short_sound
    addi $t0, $t0, 4
    jal remove_pill
    addi $s0, $s0, 4
    j draw_pill

w_press:
    beq $s4, 0, rotate_to_vertical
    beq $s4, 1, rotate_to_horizontal
rotate_to_vertical:
    lw $t5, -124($s0)          # stop rotation from happening if not enough space
    bne $t5, $s5, invalid_move #
    la $t1, ROTATE_SFX
    jal short_sound
    addi $t0, $t0, 4
    jal remove_pill
    addi $s0, $s0, 4
    addi $s4, $zero, 1
    j draw_pill
rotate_to_horizontal:
    lw $t5, -4($s0)            # stop rotation from happening if not enough space
    bne $t5, $s5, invalid_move #
    la $t1, ROTATE_SFX
    jal short_sound
    addi $t0, $t0, -4
    jal remove_pill
    addi $s0, $s0, -4
    addi $t6, $s2, 0    # these 3 lines just swap s2 and s3 so the pill rotates correctly
    addi $s2, $s3, 0    #
    addi $s3, $t6, 0    #
    addi $s4, $zero, 0
    j draw_pill

invalid_move:
    la $t1, BLOCKED_SFX
    jal short_sound
    j game_loop

quit:
    li $v0, 10
    syscall

down_collision:  
    la $t1, PLACE_CAPSULE_SFX
    jal short_sound
    la $t5, PLAY_AREA_DATA
    add $t5, $t5, $t0    # offset t5 by t0 bytes
    beq $s4, 0, down_collision_horizontal
    beq $s4, 1, down_collision_vertical
down_collision_horizontal:
    sw $s2, 0($t5)
    sw $s3, 4($t5)

    sw $t5, 0($s7)     # these lines store the addresses of the placed block in PLAY_AREA_DATA, into the CAPSULES array.
    addi $t5, $t5, 4
    sw $t5, 4($s7)
    addi $t5, $t5, -4
    addi $s7, $s7, 8
    addi $s6, $s6, 1

    j horizontal_line_check
down_collision_vertical:
    sw $s2, 0($t5)
    sw $s3, -40($t5)
    
    sw $t5, 0($s7)     # these lines store the addresses of the placed block in PLAY_AREA_DATA, into the CAPSULES array.
    addi $t5, $t5, -40
    sw $t5, 4($s7)
    addi $t5, $t5, 40
    addi $s7, $s7, 8
    addi $s6, $s6, 1
    
    j horizontal_line_check

horizontal_line_check:
    la $t5, PLAY_AREA_DATA    # $t5 = PLAY_AREA_DATA
    add $t5, $t5, 96
    add $t6, $zero, $zero     # $t6 = counter for current row
    addi $t7, $zero, 1        # $t7 = counter for which row is current
    addi $t2, $zero, 1        # $t2 = counter for consecutive colors
    lw $t4, BLACK             # $t4 = last color seen
row_loop:
    beq $t6, 8, next_row
    lw $t3, 0($t5)            # $t3 = current color
    beq $t3, $s5, hori_reset  # reset if current color is black
    bne $t3, $t4, hori_reset  # reset if current color does not match last color
    addi $t2, $t2, 1          # if we've made it here, the current color is the same as the last one, and is not black
    bge $t2, 4, find_rightmost_block # call delete function if we've now seen 4 or more of same color
    addi $t5, $t5, 4          # move to next block in row
    addi $t6, $t6, 1          # increment current row counter
    j row_loop
hori_reset:
    add $t4, $t3, $zero       # set last seen color
    addi $t2, $zero, 1        # reset consecutive color counter
    addi $t5, $t5, 4          # move to next block in row
    addi $t6, $t6, 1          # increment current row counter
    j row_loop
next_row:
    beq $t7, 16, vertical_line_check # check if all 16 rows have been checked, move on to vertical_line_check if so
    addi $t2, $zero, 1        # reset consecutive color counter
    lw $t4, BLACK             # reset last seen color
    add $t6, $zero, $zero     # reset current row counter
    addi $t7, $t7, 1          # increment counter for which row is current
    addi $t5, $t5, 8          # reposition play_area_data
    j row_loop

find_rightmost_block:         # moves current position in data array $t5 to rightmost consecutive color
    la $t1, COMPLETE_ROW_SFX
    jal short_sound
    lw $t8, 0($t5)
    lw $t9, 4($t5)
    bne $t9, $t8, horizontal_line_deletion
    addi $t5, $t5, 4
    j find_rightmost_block
horizontal_line_deletion:
    la $t1, CAPSULES          # load beginning of CAPSULES array to $t1
    jal capsule_data_loop
    lw $t8, 0($t5)            # $t8 = current color
    lw $t9, -4($t5)           # $t9 = last color
    sw $s5, 0($t5)            # store black into current location in data array

    bne $t9, $t8, done_horizontal_line_deletion # stop loop if we have reached the end of the line (no longer consecutive colors)
    addi $t5, $t5, -4         # not end of the line: move original position $t5 back one block and repeat
    j horizontal_line_deletion
done_horizontal_line_deletion:
    jal capsule_drop_scan_start
    j horizontal_line_check

vertical_line_check:
    la $t5, PLAY_AREA_DATA    # $t5 = PLAY_AREA_DATA
    addi $t5, $t5, 56
    addi $t6, $zero, 0        # $t6 = counter for current column
    addi $t7, $zero, 1        # $t7 = counter for which column is current
    addi $t2, $zero, 1        # $t2 = counter for consecutive colors
    lw $t4, BLACK             # $t4 = last color seen
col_loop:
    beq $t6, 17, next_col
    lw $t3, 0($t5)            # $t3 = current color
    beq $t3, $s5, vert_reset  # reset if current color is black
    bne $t3, $t4, vert_reset  # reset if current color does not match last color
    addi $t2, $t2, 1          # if we've made it here, the current color is the same as the last one, and is not black
    bge $t2, 4, find_bottom_block # call delete function if we've now seen 4 or more of same color
    addi $t5, $t5, 40         # move to next block in column
    addi $t6, $t6, 1          # increment current column counter
    j col_loop
vert_reset:
    add $t4, $t3, $zero       # set last seen color
    addi $t2, $zero, 1        # reset consecutive color counter
    addi $t5, $t5, 40         # move to next block in column
    addi $t6, $t6, 1          # increment current column counter
    j col_loop
next_col:
    beq $t7, 8, check_viruses_start # check if all 8 columns have been checked
    addi $t2, $zero, 1        # reset consecutive color counter
    lw $t4, BLACK             # reset last seen color
    addi $t6, $zero, 0        # reset current column counter
    addi $t7, $t7, 1          # increment counter for which column is current
    addi $t5, $t5, -676       # reposition play_area_data
    j col_loop

find_bottom_block:            # moves current position in data array $t5 to bottom-most consecutive color
    la $t1, COMPLETE_ROW_SFX
    jal short_sound
    lw $t8, 0($t5)
    lw $t9, 40($t5)
    bne $t9, $t8, vertical_line_deletion
    addi $t5, $t5, 40
    j find_bottom_block
vertical_line_deletion:
    la $t1, CAPSULES          # load beginning of CAPSULES array to $t1
    jal capsule_data_loop
    lw $t8, 0($t5)
    lw $t9, -40($t5)
    sw $s5, 0($t5)
    bne $t9, $t8, done_vertical_line_deletion
    addi $t5, $t5, -40  
    j vertical_line_deletion
done_vertical_line_deletion:
    jal capsule_drop_scan_start
    j horizontal_line_check

capsule_data_loop:
    lw $t0, 0($t1)            # load first value in CAPSULES array
    beq $t5, $t0, found_capsule_data
    addi $t1, $t1, 4          # first address in CAPSULES array is not the same as the address to be removed from PLAY_AREA_DATA. check next
    j capsule_data_loop
found_capsule_data:
    sw $s5, 0($t1)            # replace the address in CAPSULE array to 0/black.
    jr $ra
    
capsule_drop_scan_start:      # for each capsule/8bytes in CAPSULES array, call drop_half_algo if 1 half exists, or drop_full_capsule if both do.
    la $s1, CAPSULES          # dropping convention of reserving $s for saved values and $a for arguments here -- running out of registers
    addi $a1, $zero, 0        # counter for parsing through CAPSULES array
    addi $s1, $s1, 16         # skipping viruses in array (first 4)
capsule_drop_scan_loop:
    beq $a1, $s6, return_to_deletion
    lw $t0, 0($s1)            # load the two addresses in CAPSULE array for current capsule
    lw $t1, 4($s1)
    beq $t0, 0, zero_off      # if address0 is blank (erased), go to zero_off
    beq $t1, 0, one_off       # if address1 is blank (erased) (and address0 still exists) go to one_off
    j drop_full_capsule       # if both still exist
return_to_deletion:
    jr $ra
zero_off:                     # these two functions do the same thing, make sure t0 is the block that still exists, and call drop_half_algo
    move $t0, $t1
    addi $a3, $zero, 1        # $a3 = 1 means we're working with the block to the right in the capsule (in CAPSULES ARRAY)
    bne $t0, 0, drop_half_algo
    addi $s1, $s1, 8
    addi $a1, $a1, 1
    j capsule_drop_scan_loop  # makes it here if both are actually gone -- return to loop
one_off:
    addi $a3, $zero, 0        # $a3 = 0 means we're working with the block to the left in the capsule (in CAPSULES ARRAY)
    bne $t0, 0, drop_half_algo
    addi $s1, $s1, 8
    addi $a1, $a1, 1
    j capsule_drop_scan_loop

drop_half_algo:               # drops a block until it hits non-black (color or floor).
    lw $t1, 40($t0)
    beq $t1, $s5, drop_down
    addi $s1, $s1, 8
    addi $a1, $a1, 1
    j capsule_drop_scan_loop
drop_down:                    # shifting blocks down 1, moving current position up, and calling drop_half_algo again
    lw $t1, 0($t0)            
    sw $t1, 40($t0)
    sw $s5, 0($t0)
    addi $t0, $t0, 40
    beq $a3, 0, new_capsule_position_zero    # these functions update the address in the CAPSULES array to reflect the new position of the block
    beq $a3, 1, new_capsule_position_adjusted
new_capsule_position_zero:
    sw $t0, 0($s1)
    j drop_half_algo
new_capsule_position_adjusted:
    sw $t0, 4($s1)
    j drop_half_algo

drop_full_capsule:
    addi $a2, $t0, 4
    addi $a3, $t1, 4
    beq $a2, $t1, drop_hori_capsule   # goes to drop_hori_capsule if the blocks are next to each other
    beq $a3, $t0, drop_hori_capsule

    addi $t0, $t0, 40
    addi $a3, $zero, 0
    beq $t0, $t1, prep_vert_drop_one
    addi $t0, $t0, -40
    addi $t1, $t1, 40
    beq $t0, $t1, prep_vert_drop_zero    # goes to vertical drop if the blocks are stacked vertically
    j capsule_drop_scan_loop  # should never make it here -- used for debugging

prep_vert_drop_zero:    # these just make sure the address for the bottom block of the two is stored in $t0
    j vert_drop_loop
prep_vert_drop_one:
    add $t0, $zero, $t1
    j vert_drop_loop
vert_drop_loop:               # drops a vertical block until it hits non-black (color or floor).
    lw $t1, 40($t0)
    beq $t1, $s5, vert_drop_execute
    addi $s1, $s1, 8
    addi $a1, $a1, 1
    j capsule_drop_scan_loop
vert_drop_execute:            # shifting bottom block down 1, moving current position up
    lw $t1, 0($t0)            
    sw $t1, 40($t0)
    sw $s5, 0($t0)
    addi $t0, $t0, 40
    sw $t0, 0($s1)            # updating address in CAPSULES array
    addi $t0, $t0, -80

    lw $t1, 0($t0)            # shifting top block down 1 to meet bottom block, moving current position up        
    sw $t1, 40($t0)
    sw $s5, 0($t0)
    addi $t0, $t0, 40
    sw $t0, 4($s1)            # updating address in CAPSULES array

    j capsule_drop_scan_start # re-scan everything (there may now be suspended blocks mid-air that weren't there before)
    
drop_hori_capsule:            # drops a capsule until one of its halves hits non-black (color or floor). same assumption as drop_half_algo
    lw $a2, 40($t0)
    lw $a3, 40($t1)
    beq $a2, $s5, condition_one # passes condition one if the first block has black below it
    addi $a1, $a1, 1
    addi $s1, $s1, 8
    j capsule_drop_scan_loop
condition_one:
    beq $a3, $s5, drop_two    # passes condition two if the second block has black below it
    addi $a1, $a1, 1
    addi $s1, $s1, 8
    j capsule_drop_scan_loop
drop_two:
    lw $a2, 0($t0)            # pushes the block to the space below it (for both blocks)      
    sw $a2, 40($t0)
    sw $s5, 0($t0)
    lw $a2, 0($t1)
    sw $a2, 40($t1)
    sw $s5, 0($t1)
    
    addi $t0, $t0, 40         # reposition the address to the new place where the block is
    addi $t1, $t1, 40

    sw $t0, 0($s1)            # update the address in CAPSULES array
    sw $t1, 4($s1)
    
    j capsule_drop_scan_start

check_viruses_start:
    la $t1, VIRUS_DATA
    addi $t1, $t1, 12
    la $t0, CAPSULES
    addi $t3, $zero, 0
    addi $t4, $zero, 0
check_viruses_loop:
    beq $t3, 4, draw_map
    lw $t2, 0($t0)
    beq $t2, $s5, remove_virus
    addi $t1, $t1, 4
    addi $t0, $t0, 4
    addi $t3, $t3, 1
    j check_viruses_loop
remove_virus:
    sw $s5, 0($t1)
    addi $t1, $t1, 4
    addi $t0, $t0, 4
    addi $t3, $t3, 1
    addi $t4, $t4, 1    # increment counter of how many viruses are gone
    beq $t4, 4, next_level_setup # if all 4 are gone, move onto next level
    j check_viruses_loop  
next_level_setup:
    jal reset_play_area_data
    subi $gp, $gp, 200  # whatever the speed was at, make it 200 milliseconds faster
    b start_new_game

game_over:
    la $t1, BLOCKED_SFX
    jal short_sound
    la $t5, GAME_OVER_DATA
    jal draw_image
game_over_loop:
    lw $s1, ADDR_KBRD
    lw $t8, 0($s1)
    beq $t8, 1, keyboard_input_game_over
    j game_over_loop
keyboard_input_game_over:
    lw $a0, 4($s1)
    beq $a0, 0x79, play_again
    beq $a0, 0x71, quit
    j game_over_loop
play_again:
    jal reset_play_area_data
    b main
    
reset_play_area_data:        # reset the play_area_data to be all black (within the bottle) so that a new game can be played
    la $t5, PLAY_AREA_DATA
    addi $t5, $t5, 24
    sw $s5, 0($t5)
    sw $s5, 4($t5)
    sw $s5, 8($t5)
    sw $s5, 12($t5)
    addi $t5, $t5, 40
    sw $s5, 0($t5)
    sw $s5, 4($t5)
    sw $s5, 8($t5)
    sw $s5, 12($t5)
    addi $t5, $t5, 32
    addi $t6, $zero, 0
    addi $t7, $zero, 0
map_reset_row_loop:
    beq $t6, 8, map_reset_next_row
    sw $s5, 0($t5)
    addi $t5, $t5, 4
    addi $t6, $t6, 1
    j map_reset_row_loop
map_reset_next_row:
    beq $t7, 15, done_play_area_reset # go back to main to restart game if play_area_data is finished being reset
    addi $t5, $t5, 8
    addi $t7, $t7, 1
    addi $t6, $zero, 0
    j map_reset_row_loop
done_play_area_reset:
    jr $ra

short_sound:
    li $v0, 31
    lw $a0, 0($t1)
    lw $a1, 4($t1)
    li $a2, 118
    li $a3, 60
    syscall
    jr $ra