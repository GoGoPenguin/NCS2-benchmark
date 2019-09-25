#!/bin/bash

n_itr=32

python3 ncs_inference.py $n_itr 224 VGG16       2> /dev/null
python3 ncs_inference.py $n_itr 224 ResNet50    2> /dev/null
python3 ncs_inference.py $n_itr 299 InceptionV3 2> /dev/null
python3 ncs_inference.py $n_itr 224 MobileNet   2> /dev/null
python3 ncs_inference.py $n_itr 224 MobileNetV2 2> /dev/null
python3 ncs_inference.py $n_itr 299 Xception    2> /dev/null
python3 ncs_inference.py $n_itr 331 NASNetLarge 2> /dev/null
python3 ncs_inference.py $n_itr 224 DenseNet121 2> /dev/null