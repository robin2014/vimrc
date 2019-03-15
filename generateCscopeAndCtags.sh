#/bin/bash
SOURCE_CODE_PATH="/home/zhangyun/Server/"
THIRD_PARTY_INCLUDE="/usr/local/mfw/3party-include/"
MFW_INCLUDE="/usr/local/mfw/include/"
TARGET_GENERATE_PATH_FILE="/home/zhangyun/csctags/cscope.files"
echo "begin generator cscope.files"
find $SOURCE_CODE_PATH $THIRD_PARTY_INCLUDE $MFW_INCLUDE -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.hxx" -o -name "*.hh" -o -name "*.cxx">$TARGET_GENERATE_PATH_FILE
echo "end generator cscope.files"
echo "-------------------------------------------------------------"
echo "begin generator cscope.in.out  cscope.out  cscope.po.out"
cscope -bkqR -i $TARGET_GENERATE_PATH_FILE
echo "end generator cscope.in.out  cscope.out  cscope.po.out"
echo "-------------------------------------------------------------"
echo "begin generator tags"
ctags -R ${SOURCE_CODE_PATH}*
echo "end generator tags"
echo "-------------------------------------------------------------"
