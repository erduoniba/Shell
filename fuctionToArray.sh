# 读取文件的内容到数组，并且打印

declare -a config_content_array
cfg_line_count=0

IFS_OLD=$IFS
IFS=$'\n'

cfg_file=$1

for line in $(cat $cfg_file | sed 's/^[ \t]*//g') 
do
	if [[ ${#line} -eq 0 ]]; then
		echo "black line"
	else
		echo ${line}
		config_content_array[cfg_line_count]=$line
	fi
	cfg_line_count=$[ $cfg_line_count + 1 ]
done
IFS=${IFS_OLD}


echo "================================================================"
echo "cfg_line_count:" ${cfg_line_count}
for item in ${config_content_array[@]}
do
	echo $item
done
echo "================================================================"