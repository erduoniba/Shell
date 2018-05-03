# 添加注释代码

function mix() {
    for file in `ls $1` 
    do
        if test -f $1"/"$file  
        then
            echo $file 是文件
            if echo $file | grep -q '.m$'
            then
                echo .m文件
                insertCodeToFile  $1"/"$file
            fi
        else 
            echo $file 是目录
            mix $1"/"$file
        fi
    done
}

injected_content="//66"

function insertCodeToFile() {
    # mark: sed 命令中使用变量 http://blog.csdn.net/lepton126/article/details/36374933
    # sed -i '/- (/ a\ '"$injected_content"'' $1

    sed -i '/^- \(.*\){$/{
            a\ '"$injected_content"'
        }' $1
}

mix $1