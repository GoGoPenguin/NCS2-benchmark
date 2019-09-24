#!/bin/bash

mo_tf_path='/opt/intel/openvino/deployment_tools/model_optimizer/mo_tf.py'
output_dir='./optimization'
data_type='FP16'

python3 $mo_tf_path --input_model ./models/VGG16.pb       --output_dir $output_dir --input_shape [1,224,224,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/ResNet50.pb    --output_dir $output_dir --input_shape [1,224,224,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/InceptionV3.pb --output_dir $output_dir --input_shape [1,299,299,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/MobileNet.pb   --output_dir $output_dir --input_shape [1,224,224,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/MobileNetV2.pb --output_dir $output_dir --input_shape [1,224,224,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/Xception.pb    --output_dir $output_dir --input_shape [1,299,299,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/NASNetLarge.pb --output_dir $output_dir --input_shape [1,331,331,3] --data_type $data_type 2> /dev/null
python3 $mo_tf_path --input_model ./models/DenseNet121.pb --output_dir $output_dir --input_shape [1,224,224,3] --data_type $data_type 2> /dev/null