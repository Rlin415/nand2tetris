// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

@8191
D=A
@n // number of pixels
M=D
@i
M=0
@SCREEN
D=A
@address // base address of screen
M=D
@state
M=1 // initial state is set to 1 to signal screen is clear

(LOOP)
  @KBD
  D=M
  @COLOR
  D;JGT // if key is pressed color screen
  @CLEAR
  0;JMP // else clear

(CLEAR)

  @state
  D=M

  @LOOP
  D;JGT // goto loop if (state > 0)

  @i
  D=M
  @address
  A=M+D
  M=0 // RAM[address] = 0

  @i
  M=M+1 // i++

  @n
  M=M-1 // n--
  D=M

  @COLOR
  D;JGE // jump back to COLOR if (n >= 0)

  @i
  M=0 // set back to 0

  @8191
  D=A

  @n
  M=D // set back to 8191

  @SCREEN
  D=A
  @address
  M=D // set back to base address of screen

  @state
  M=1

  @LOOP
  0;JMP // else goto LOOP

(COLOR)

  @state
  D=M

  @LOOP
  D;JLT // goto loop if (state < 0)

  @i
  D=M
  @address
  A=M+D
  M=-1 // RAM[address] = -1

  @i
  M=M+1 // i++

  @n
  M=M-1 // n--
  D=M

  @COLOR
  D;JGE // jump back to COLOR if (n >= 0)

  @i
  M=0 // set back to 0

  @8191
  D=A

  @n
  M=D // set back to 8191

  @SCREEN
  D=A
  @address
  M=D // set back to base address of screen

  @state
  M=-1

  @LOOP
  0;JMP // else goto LOOP
