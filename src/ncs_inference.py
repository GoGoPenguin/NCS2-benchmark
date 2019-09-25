# Inference test with OpenVINO Inference Engine(IE)

import sys
import time
from tensorflow.keras.applications.inception_v3 import decode_predictions
from PIL import Image
import numpy as np
import os

try:
    from openvino import inference_engine as ie
    from openvino.inference_engine import IENetwork, IEPlugin
except Exception as e:
    exception_type = type(e).__name__
    print(
        "The following error happened while importing Python API module:\n\
        [ {} ] {}".format(exception_type, e)
    )
    sys.exit(1)


def pre_process_image(imagePath, img_height=224):
    # Model input format
    n, c, h, w = [1, 3, img_height, img_height]
    image = Image.open(imagePath)
    processedImg = image.resize((h, w), resample=Image.BILINEAR)

    # Normalize to keep data between 0 - 1
    processedImg = (np.array(processedImg) - 0) / 255.0

    # Change data layout from HWC to CHW
    processedImg = processedImg.transpose((2, 0, 1))
    processedImg = processedImg.reshape((n, c, h, w))

    return image, processedImg, imagePath


# Plugin initialization for specified device
# and load extensions library if specified.
n_itr = int(sys.argv[1])
img_height = int(sys.argv[2])
model = sys.argv[3]
model_xml = './optimization/'+model+'.xml'
model_bin = './optimization/'+model+'.bin'
plugin_dir = None

# Devices: GPU (intel), CPU, MYRIAD
plugin = IEPlugin("MYRIAD", plugin_dirs=plugin_dir)

# Read IR
net = IENetwork(model=model_xml, weights=model_bin)
assert len(net.inputs.keys()) == 1
assert len(net.outputs) == 1
input_blob = next(iter(net.inputs))
out_blob = next(iter(net.outputs))

# Load network to the plugin
exec_net = plugin.load(network=net)
del net

# Run inference
fileName = './data/elephant.jpg'
image, processedImg, imagePath = pre_process_image(fileName, img_height)
times = []

for i in range(n_itr):
    start_time = time.time()
    res = exec_net.infer(inputs={input_blob: processedImg})
    delta = (time.time() - start_time)
    times.append(delta)

mean_delta = np.array(times).mean()
fps = 1/mean_delta
print('[{}] average:{} sec, inf/s:{}'.format(model, mean_delta, fps))
