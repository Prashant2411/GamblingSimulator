#!/bin/bash -x

echo "Welcome to the Gambling Simulator."

BET_AMOUNT=1
WIN=1
LOSS=0

stakeAmount=100
lowerStackLimit=$(( $stakeAmount / 2 ))
upperStackLimit=$(( $stakeAmount + $stakeAmount / 2 ))

function getDailyGamblingResult () {
	while (( $stakeAmount > $lowerStackLimit && $stakeAmount < $upperStackLimit ))
	do
		winLoss=$(( RANDOM % 2 ))
		case $winLoss in
			$WIN )
				((stakeAmount++));;
			$LOSS )
				((stakeAmount--));;
		esac
	done
	echo $stakeAmount
}

function main () {
	stakeAmount=$( getDailyGamblingResult )
	echo "$stakeAmount"
}

main
