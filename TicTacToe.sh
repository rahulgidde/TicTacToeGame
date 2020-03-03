#!/bin/bash -x
echo "-------------Welcome To Tic Tac Toe Game-----------"

#CONSTANT
ARRAYSIZE=8
TOTAL_TURN=9

#VARIABLES
winner=0
position=0
turnCount=0

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

#FUNCTION TO CHECK WINNING MOVE FOR COMPUTER
function checkWinningMove()
{
	#CHECK ROW WISE
	local row=0
	local count1=1
	local count2=2
	local checkSign=$1
	played=0
	for (( index=1; index<=3; index++ ))
	do
		if [[ ${board[$row]} == $checkSign ]] && [[ ${board[$row]} == ${board[$count1]} ]] && [[  ${board[$(($count1+1))]} == "-" ]] || [[ ${board[$count1]} == $checkSign ]] && [[ ${board[$count1]} == ${board[$row]} ]] && [[ ${board[$(($count1+1))]} == "-" ]]
		then
			board[$(($count1+1))]=$computer
			played=1
			return
		elif [[ ${board[$row]} == $checkSign ]] && [[ ${board[$row]} == ${board[$count2]} ]] && [[ ${board[$(($count2-1))]} == "-" ]] || [[ ${board[$count2]} == $checkSign ]] && [[ ${board[$count2]} == ${board[$row]} ]] && [[ ${board[$(($count2-1))]} == "-" ]]
		then
			board[$(($count2-1))]=$computer
			played=1
			return
		elif [[ ${board[$count1]}${board[$count2]} == $checkSign$checkSign  &&  ${board[$(($count1-1))]} == "-" ]]
		then
			board[$(($count1-1))]=$computer
			played=1
			return
		else
			count1=$(($count1+3))
			count2=$(($count2+3))
			row=$(($row+3))
		fi
	done

	#CHECK COLUMN WISE
	column=0
	count1=3
	count2=6
	for (( index=1; index<=3; index++ ))
	do
		if [[ ${board[$column]} == $checkSign ]] && [[ ${board[$column]} == ${board[$count1]} ]] && [[ ${board[$(($count1+3))]} == "-" ]] || [[ ${board[$count1]} == $checkSign ]] && [[ ${board[$count1]} == ${board[$column]} ]] && [[ ${board[$(($count1+3))]} == "-" ]]
		then
			board[$(($count1+3))]=$computer
			played=1
			return
		elif [[ ${board[$column]}  == $checkSign  ]] && [[ ${board[$column]} == ${board[$count2]} ]] && [[ ${board[$(($count2-3))]} == "-" ]] || [[ ${board[$count2]} == $checkSign ]] && [[ ${board[$count2]} == ${board[$column]} ]] && [[ ${board[$(($count2-3))]} == "-" ]]
		then
			board[$(($count2-3))]=$computer
			played=1
			return
		elif [[ ${board[$count1]}${board[$count2]} == $checkSign$checkSign  &&  ${board[$(($count1-3))]} == "-" ]]
		then
			board[$(($count1-3))]=$computer
			played=1
			return
		else
			count1=$(($count1+1))
			count2=$(($count2+1))
			column=$(($column+1))
		fi
	done

	#CHECK DIAGONAL
	diagonal=0
	count1=4
	count2=8
	if [[ ${board[$diagonal]} == $checkSign ]] && [[ ${board[$diagonal]} == ${board[$count1]} ]] && [[ ${board[$(($count1+4))]} == "-" ]] || [[ ${board[$count1]} == $checkSign ]] && [[ ${board[$count1]} == ${board[$diagonal]} ]] && [[ ${board[$(($count1+4))]} == "-" ]]
	then
		board[$(($count1+4))]=$computer
		played=1
		return
	elif [[ ${board[$diagonal]} == $checkSign  ]]  && [[  ${board[$diagonal]} == ${board[$count2]} ]] && [[ ${board[$(($count2-4))]} == "-" ]] || [[ ${board[$count2]} == $checkSign ]] && [[ ${board[$count2]} == ${board[$diagonal]} ]] && [[ ${board[$(($count2-4))]} == "-" ]]
	then
		board[$(($count2-4))]=$computer
		played=1
		return
	elif  [[ ${board[$count1]}${board[$count2]} == $checkSign$checkSign  &&  ${board[$(($count1-4))]} == "-" ]]
	then
		board[$(($count1-4))]=$computer
		played=1
		return
	fi
	count2=$(($count2-2))
	diagonal=$(($diagonal+2))
	if [[ ${board[$diagonal]} == $checkSign ]] && [[ ${board[$diagonal]} == ${board[$count1]} ]] && [[ ${board[$(($count1+2))]} == "-" ]] || [[ ${board[$count1]} == $checkSign ]] && [[ ${board[$count1]} == ${board[$diagonal]} ]] && [[ ${board[$(($count1+2))]} == "-" ]]
	then
		board[$(($count1+2))]=$computer
		played=1
		return
	elif [[ ${board[$diagonal]} == $checkSign  ]]  && [[  ${board[$diagonal]} == ${board[$count2]} ]] && [[ ${board[$(($count2-2))]} == "-" ]] || [[ ${board[$count2]} == $checkSign ]] && [[ ${board[$count2]} == ${board[$diagonal]} ]] && [[ ${board[$(($count2-2))]} == "-" ]]
	then
		board[$(($count2-2))]=$computer
		played=1
		return
	elif  [[ ${board[$count1]}${board[$count2]} == $checkSign$checkSign  &&  ${board[$(($count1-4))]} == "-" ]]
	then
		board[$(($count1-4))]=$computer
		played=1
		return
	fi
}

#FUNCTION TO CHECK CORNERS ARE EMPTY IF YES THEN OCCUPY
function checkCorners()
{
	for (( index=0; index<=$ARRAYSIZE; index=$index+2 ))
	do
		if [[ ${board[$index]} == "-" && $index != 4 ]]
		then
			board[$index]=$computer
			played=1
			return
		fi
	done
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
		flag=1
		board[$position]=$player
	fi
	displayBoard
	if [[ 1 == $(checkHorizontal $player) ]]
	then
		winner=1
	elif [[ 1 == $(checkVertical $player) ]]
	then
		winner=1
	elif [[ 1 == $(checkDiagonal $player) ]]
	then
		winner=1
	else
		winner=0
	fi
	if [[ $winner == 1 ]]
	then
		echo "You Win"
	fi
	((turnCount++))
}

#FUNCTION FOR COMPUTER TURN
function computerTurn()
{
	checkWinningMove $computer
	if [[ $played == 0 ]]
	then
		checkWinningMove $player
	fi
	if [[ $played == 0 ]]
	then
		checkCorners
	fi
	if [ $played == 0 ]
	then
		position=$((RANDOM%9))
		while [[ ${board[$position]} != "-" ]]
		do
			position=$((RANDOM%9))
		done
		board[$position]=$computer
	fi
	displayBoard
	if [[ 1 == $(checkHorizontal $computer) ]]
	then
		winner=1
	elif [[ 1 == $(checkVertical $computer) ]]
	then
		winner=1
	elif [[ 1 == $(checkDiagonal $computer) ]]
	then
		winner=1
	else
		winner=0
	fi
	if [[ $winner == 1 ]]
	then
		echo "Computer Win"
	fi
	flag=0
	((turnCount++))
}

assignLetter
flag=$(toss)
displayBoard
while [ $winner -ne 1 ]
do
	if [ $flag -eq 0 ]
	then
		playerTurn $player
	else
		computerTurn $computer
	fi
	if [[ $turnCount -eq $TOTAL_TURN ]]
	then
		echo "Tie..!!"
	fi
done

