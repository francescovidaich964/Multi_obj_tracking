# MOT_with_YOLOv3_and_SORT

$ ./init_mot.sh build_flag dataset

where 'dataset' is the name of the folder in ${root}/MOT_datasets/'dataset' containing images that we want to analyze eand their Ground Truth and 'build_flag' has to be a True if you want to perform MOT on the new sequence and to build the GT video, otherwise the already computed results will be evaluated.
