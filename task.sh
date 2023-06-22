#!/bin/bash
case $1 in
	add)
		shift
		if [[ -z $1 ]]; then
			echo "[Error] This command needs an argument" >/dev/stderr
			exit 1
		else
			str_tmp=""
			flag=true
			while [[ -n $1 ]]; do
				str_tmp+=" $1"	
				if echo $1 | grep -qi "(important)"; then
					#echo imp found
					echo M $str_tmp >> tasks.txt
					echo Added task $(wc -l < tasks.txt) with priority M
					flag=false
					break
				elif echo $1 | grep -qi "(very"; then
					echo H $str_tmp >> tasks.txt
					echo Added task $(wc -l < tasks.txt) with priority H
					flag=false
					break
				fi
				shift
			done
			if $flag; then
			echo L $str_tmp >> tasks.txt
			echo Added task $(wc -l < tasks.txt) with priority L
			fi
		fi
	;;

	list)
		if [ -s tasks.txt ]; then
			awk -v n=1 '{ if ($1 == "L") {
						 	 $1 = "*    ";
						 	 print n" "$0;
							}
						  if ($1 == "M") {
							$1 = "***  ";
							print n" "$0;
							}
						  if ($1 == "H") {
							$1 = "*****";
							print n" "$0;
							}
			} {n++;}' tasks.txt
		else
			echo "No tasks found..."
		fi
    ;;

	done)
		shift
		if [[ -z $1 ]]; then
			echo "[Error] This command needs an argument" >/dev/stderr
			exit 1
		else
			echo Completed task $1:$(awk -v i=$1 'NR == i {$1=""; print $0}' tasks.txt)
			awk -v i=$1 'NR != i {print}' tasks.txt > tmp
			cat tmp > tasks.txt
		fi
	;;

	*)
		echo "[Error] Invalid command" >/dev/stderr
	exit 1
	;;
esac
