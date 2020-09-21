
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"


# IF provided, check for the dataset '$2'; if it exist,
# copy it to the working folder ./data, otherwise continue 
# working with the dataset already stored in the folder
if [ -n "$2" ]; then

	echo -e "\n   ----- Copying $2 dataset in working folder ----- \n"
	new_data_path="./data/MOT_datasets/$2"

	if [ -d $new_data_path ]; then
		rm ./data/images/*
		cp $new_data_path/img1/* ./data/images/
		cp $new_data_path/gt/gt.txt ./data/gt.txt
		echo -e "     DONE!\n"
	else
		echo -e "     Folder ./data/MOT_datasets/$2 is missing!"
		echo -e "      -> Using the one in ./data/images \n"
	fi
fi

# If build_flag is true, solve MOT task over the 
# dataset in ./data and build ground truth video
if [ "$1" == "True" ]; then
	cd pytorch_objectdetecttrack
	echo -e "\n   ----- Performing MOT inference ----- \n"
	python PyTorch_Object_Tracking.py
	mv ./output_boxes.txt ../data/out.txt
	echo -e "\n\n   ----- Building Ground Truth video ----- \n"
	python build_gt_tracking_video.py
	cd ../
fi


echo -e "\n\n   ----- Evaluating MOT results ----- \n"
cp ./data/out.txt ./py-motmetrics/motmetrics/data/out/out.txt
cp ./data/gt.txt ./py-motmetrics/motmetrics/data/out/gt/gt.txt

cd py-motmetrics
python -m motmetrics.apps.eval_motchallenge motmetrics/data/ motmetrics/data/out/
echo ""
