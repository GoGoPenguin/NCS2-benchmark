# README

- **OS**: Ubuntu 16.04
- **Device**: Intel Neural Compute Stick 2
- **SDK**: OpenVINO Toolkit
- **SDK Version**: 2019.2.275
- **Python**: 3.5.2
- **Tensorflow**: 1.14.0

## Makefile

- **make all**

  Run all scripts

- **make inference**

  Runs benchmark

- **make optimizer**

  Optimize tensorflow model

- **make freeze**

  Freeze tensorflow model

## Docker

- Pull from registry

  [private docker registry](http://192.168.1.83:8081/?page=1#!taglist/emb-ncsdk)

- Build local image

  ```bash
  docker-compose build
  ```

- Start container

  ```bash
  docker-compose up -d
  ```

## Benchmark

- Precision: FP16
- Iteration: 32

Model       | inf/s
----------- | ------------------
VGG16       | 7.710265137769467
ResNet50    | 40.37231715214834
InceptionV3 | 27.81452277557246
MobileNet   | 168.06753869926396
MobileNetV2 | 258.0380700071326
Xception    | 17.56228527642683
NASNetLarge | 2.71533457243054
DenseNet121 | 40.51237094046917

## Reference

- [Install Intel Distribution of OpenVINO toolkit for Linux](https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_linux.html)
- [Converting a TensorFlow Model](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_Convert_Model_From_TensorFlow.html#Convert_From_TF)
- [Tony607/keras_openvino](https://github.com/Tony607/keras_openvino)
