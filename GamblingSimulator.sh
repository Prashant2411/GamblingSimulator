#!/bin/bash -x

echo "Welcome to the Gambling Simulator."

BET_AMOUNT=1
WIN=1
LOSS=0
PERCENT=50
STAKE_AMOUNT=100
NO_OF_DAYS=20
LOWER_STACK_LIMIT=$(( $stakeAmount * $PERCENT / 100 ))
UPPER_STAKE_LIMIT=$(( $stakeAmount + $LOWER_STACK_LIMIT ))

declare -A dailyAmount

function getDailyGamblingResult () {
	winCount=0
	lossCount=0
	for (( i=0;i<$NO_OF_DAYS;i++ ))
	do
		stakeAmount=$STAKE_AMOUNT
		while (( $stakeAmount > $LOWER_STAKE_LIMIT && $stakeAmount < $UPPER_STAKE_LIMIT ))
		do
			winLoss=$(( RANDOM % 2 ))
			case $winLoss in
				$WIN )
					((winCount++))
					((stakeAmount++));;
				$LOSS )
					((lossCount++))
					((stakeAmount--));;
			esac
		done
		dailyAmount[Day"$i"]=$(( $stakeAmount - $STAKE_AMOUNT ))
	done
}

function getCumulativeAddition () {
	sumOfDict=0
	for i in ${!dailyAmount[@]}
	do
		sumOfDict=$(( $sumOfDict + ${dailyAmount[$i]} ))
		dailyAmount[$i]=$sumOfDict
	done
}

function printLuckyDay () {
	echo "Luckiest Day:"
	for i in ${!dailyAmount[@]}
	do
		echo "$i ${dailyAmount[$i]}"
	done | sort -k2 -nr | head -1
}

function printUnluckyDay () {
	echo "Unluckiest Day:"
	for i in ${!dailyAmount[@]}
	do
		echo "$i ${dailyAmount[$i]}"
	done | sort -k2 -nr | tail -1
}

function nextMonth () {
	if [ $1 -gt 0 ]
	then
		main
	else
		echo "No money left"
	fi
}

function main () {
	getDailyGamblingResult
	for i in ${!dailyAmount[@]}
	do
		echo "$i ${dailyAmount[$i]}"
	done
	getCumulativeAddition
	echo ${dailyAmount[@]}
	printLuckyDay
	printUnluckyDay
	echo "Total Earning: $(( $winCount - $lossCount ))"
	nextMonth $(( $winCount - $lossCount ))
}

main
