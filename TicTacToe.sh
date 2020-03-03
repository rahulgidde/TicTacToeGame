#!/bin/bash -x
echo "-------------Welcome To Tic Tac Toe Game-----------"

#CONSTANT
ARRAYSIZE=8

#VARIABLE
winner=0
position=0

#DECLARE ARRAY
declare -a board

#FUNCTION TO RESET THE BOARD
for (( index=0; index<=$ARRAYSIZE; index++ ))
do
   board[$index]="-"
done

#FUNCTION TO PRINT BOARD
function displayBoard()
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

#FUNCTION TO CHECK WINNER HORIZONTALY
function checkHorizontal()
{
   local row=3
   local value=$1
   for (( index1=0; index1<$row; index1++ ))
   do
      local flag=0
      for (( index2=$index1*$row; index2<=$(($(($index1*$row))+2)); index2++ ))
      do
         if [ ${board[$index2]} == $value ]
         then
            ((flag++))
         fi
      done
      if [ $flag -eq $row ]
      then
         returnValue=1
         break;
      else
         returnValue=0
      fi
   done
   echo $returnValue
}

#FUNCTION TO CHECK WINNER VERTICALY
function checkVertical()
{
   local row=3
   local value=$1
   for (( index1=0; index1<$row; index1++ ))
   do
      local flag=0
      for (( index2=$index1; index2<=$index1+6; index2=$index2+3 ))
      do
         if [ ${board[$index2]} == $value ]
         then
            ((flag++))
         fi
      done
      if [ $flag -eq $row ]
      then
         returnValue=1
         break;
      else
         returnValue=0
      fi
   done
   echo $returnValue
}

#FUNCTION TO CHECK WINNER DIGONALY
function checkDiagonal()
{
   if [[ ${board[0]} == ${board[4]} ]] && [[ ${board[4]}  ==  ${board[8]} ]] && [[ ${board[8]} == $1 ]]
   then
      echo 1
   elif [[ ${board[2]} == ${board[4]} ]] && [[ ${board[4]}  ==  ${board[6]} ]] && [[ ${board[6]} == $1 ]]
   then
      echo  1
   else
      echo 0
   fi
}

#FUNCTION TO CHECK WINNER
function getBoard()
{
	value=$1
	board[$position]=$value
	displayBoard
	if [[ 1 == $(checkHorizontal $value) ]]
	then
		winner=1
	elif [[ 1 == $(checkVertical $value) ]]
	then
		winner=1
	elif [[ 1 == $(checkDiagonal $value) ]]
	then
		winner=1
	else
		winner=0
	fi
}

#FUNCTION FOR PLAYER TURN
function playerTurn()
{
	read -p "Enter your position in between 0 to 8: " position
	if [ $position -gt 8 ]
	then
		echo "Enter Valid Position"
	elif [ ${board[$position]} == x ] || [ ${board[$position]} == o ]
	then
		echo "Position Occupied"
	else
		getBoard $player $position
		if [[ $winner == 1 ]]
		then
			echo "You Win"
		fi
		flag=1
	fi
}

#FUNCTION FOR COMPUTER TURN
function computerTurn()
{
	position=$((0+RANDOM%8))
	if [ $position -gt 8 ]
	then
		echo "Enter Valid Position"
	elif [ ${board[$position]} == x ] || [ ${board[$position]} == o ]
	then
		echo "Position Occupied"
	else
		getBoard $computer $position
		flag=0
	fi
	if [[ $winner == 1 ]]
	then
		echo "Computer Win"
	fi
}

assignLetter
flag=$(toss)
displayBoard
while [ $winner -ne 1 ]
do
	if [ $flag -eq 0 ]
	then
		echo "Your Turn:"
		playerTurn $player
	else
		echo "Computer Turn:"
		computerTurn $computer
	fi
done
