# 定义数组，用来保存找到的.m文件的路径

declare -a implement_source_file_array
implement_source_file_count=0

function read_implement_file_recursively {
	echo "read_implement_file_recursively"

	# 判断$1目录是否存在
	if [[ -d $1 ]]; then

		# 遍历$1目录下的所有内容
		for item in $(ls $1); do
			itemPath="$1/${item}"

			# 判断$itemPath目录是否存在
			if [[ -d $itemPath ]]; then
				# 目录
				echo "处理目录 ${itemPath}"

				# 循环遍历目录下的内容
				read_implement_file_recursively $itemPath
				echo "处理目录结束====="
			else 
				# 文件
				echo "处理文件 ${itemPath}"

				# expr命令可以实现数值运算、数值或字符串比较、字符串匹配、字符串提取、字符串长度计算等功能。
				# 它还具有几个特殊功能，判断变量或参数是否为整数、是否为空、是否为0等。
				# https://www.cnblogs.com/f-ck-need-u/p/7231832.html
				# 匹配以 .m 结束的字符串的个数， -gt: 大于等于（）匹配.m字符串个数大于0则表明是.m文件
				if [[ $(expr "$item" : '.*\.m$') -gt 0 ]]; then
					echo "找到.m文件，地址为：" $itemPath
					implement_source_file_array[$implement_source_file_count]=${itemPath}
					implement_source_file_count=$[ implement_source_file_count + 1 ];
				fi
				echo ""
			fi
		done
	else
		echo "err:不是一个目录"
	fi
}

# 执行 “遍历$1目录下所有的.m文件” 操作
read_implement_file_recursively $1

# 打印找到的.m文件的路径
echo "================================================================"
for filePath in ${implement_source_file_array[@]}
do
	echo $filePath
done
echo "================================================================"

# 使用方式
# denglibing$ ./findFileType.sh /Users/denglibing/Desktop/ChartDemo/ChartDemo
