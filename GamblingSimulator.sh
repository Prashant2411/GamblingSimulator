#!/bin/bash -x

echo "Welcome to the Gambling Simulator."

BET_AMOUNT=1
WIN=1
LOSS=0

winCount=0
lossCount=0

declare -A dailyAmount

function getDailyGamblingResult () {
	for (( i=0;i<20;i++ ))
	do
		stakeAmount=100
		lowerStackLimit=$(( $stakeAmount / 2 ))
		upperStackLimit=$(( $stakeAmount + $stakeAmount / 2 ))
		while (( $stakeAmount > $lowerStackLimit && $stakeAmount < $upperStackLimit ))
		do
			winLoss=$(( RANDOM % 2 ))
			case $winLoss in
				$WIN )
					winCount=$(( $winCount + 1 ))
					((stakeAmount++));;
				$LOSS )
					((lossCount++))
					((stakeAmount--));;
			esac
		done
		dailyAmount[Day"$i"]=$(( $stakeAmount - 100 ))
	done
}

function main () {
	getDailyGamblingResult
	echo "Total Earning: $(( $winCount - $lossCount ))"
	for i in ${!dailyAmount[@]}
	do
		echo "$i ${dailyAmount[$i]}"
	done
}

main
