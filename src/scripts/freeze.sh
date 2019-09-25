#!/bin/bash

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze VGG16";
python3 freeze_graph.py VGG16       2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze ResNet50";
python3 freeze_graph.py ResNet50    2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze InceptionV3";
python3 freeze_graph.py InceptionV3 2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze MobileNet";
python3 freeze_graph.py MobileNet   2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze MobileNetV2";
python3 freeze_graph.py MobileNetV2 2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze Xception";
python3 freeze_graph.py Xception    2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze NASNetLarge";
python3 freeze_graph.py NASNetLarge 2> /dev/null

echo "[`date "+%Y/%m/%d %H:%M:%S"`] Freeze DenseNet121";
python3 freeze_graph.py DenseNet121 2> /dev/null
