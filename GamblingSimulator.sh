#!/bin/bash -x

echo "Welcome to the Gambling Simulator."

BET_AMOUNT=1
WIN=1
LOSS=0
STAKE_AMOUNT=100

function getWinLoss () {
	winLoss=$(( RANDOM%2 ))
	case $winLoss in
	$WIN )
		echo "Win";;
	$LOSS )
		echo "Loss";;
	esac
}

getWinLoss
