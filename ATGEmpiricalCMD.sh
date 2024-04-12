echo "Static Activity Translation Graph Generator."
echo "CS, UCR"
echo "Processing dex file."

apk_path=$1
jre_path=$2
result_dir=$3
working_dir=$(pwd)

apkname=$(basename $apk_path)

apk_path=$(realpath $apk_path)
jre_path=$(realpath $jre_path)

echo "APK path: $apk_path"
echo "JRE path: $jre_path"
echo "Apk Name: $apkname"
echo "Working dir: $working_dir"

if [ ! -d "$result_dir" ]; then
	mkdir -p "$result_dir"
fi
result_dir=$(realpath $result_dir)
echo "Result dir: $result_dir"

a3e_dir=$(dirname "$(readlink -f "$0")")"/satg"
echo "a3e dir: $a3e_dir"
cd $a3e_dir

sed -i '/java_runtime_dir/d' wala.properties
echo "java_runtime_dir=$jre_path" >> wala.properties

START=$(date +%s)
java -Xmx6g -jar sap.jar --android-lib=lib/android-2.3.7_r1.jar $apk_path | grep "<activity>" > $apk_path".g"
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "Processed in $DIFF seconds." 
echo "Generating output file."
if [ -f $apk_path".g" ]
then
	java -jar satg.jar $apk_path".g"
	rm $apk_path".g"
else
	echo "Error processing SATG"
fi

echo "Processed in $DIFF seconds."  >> $a3e_dir/sap.log

mv $a3e_dir/$apkname".g.xml" $result_dir
mv $a3e_dir/$apkname".g.xml.dot" $result_dir
mv $a3e_dir/sap.log $result_dir
