#!/bin/bash -x
echo "-------------Welcome To Tic Tac Toe Game-----------"

#CONSTANT
ARRAYSIZE=8

#DECLARE ARRAY
declare -a board

#FUNCTION TO RESET THE BOARD
for (( index=0; index<=$ARRAYSIZE; index++ ))
do
   board[$index]="-"
done

#FUNCTION TO PRINT BOARD
function printBoard()
{
   echo " | "${board[0]}" | "${board[1]}" | "${board[2]}" | "
   echo " -------------"
   echo " | "${board[3]}" | "${board[4]}" | "${board[5]}" | "
   echo " -------------"
   echo " | "${board[6]}" | "${board[7]}" | "${board[8]}" | "
   echo " -------------"
}

#FUNCTION TO ASSIGN LETTER TO PLAYER
function assignLetter()
{
   check=$((RANDOM%2))
   if [ $check -eq 0 ]
   then
      player="o"
      computer="x"
   else
      player="x"
      computer="o"
   fi
}

#FUNCTION TO TOSS FOR WHO WILL PLAY FIRST
function toss()
{
   randomToss=$((RANDOM%2))
   if [ $randomToss -eq 0 ]
   then
      win=0
   else
      win=1
   fi
   echo $win
}

printBoard
assignLetter
toss

