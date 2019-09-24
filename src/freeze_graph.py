import tensorflow as tf
from tensorflow.python.framework import graph_io
from tensorflow.keras.models import load_model
from tensorflow.python.keras import applications


# Clear any previous session.
tf.keras.backend.clear_session()

save_pb_dir = './models'


def freeze_graph(
    graph,
    session,
    output,
    save_pb_dir='.',
    save_pb_name='frozen_model.pb',
    save_pb_as_text=False
):
    with graph.as_default():
        graphdef_inf = tf.graph_util.remove_training_nodes(
            graph.as_graph_def()
        )
        graphdef_frozen = tf.graph_util.convert_variables_to_constants(
            session,
            graphdef_inf,
            output
        )
        graph_io.write_graph(
            graphdef_frozen,
            save_pb_dir,
            save_pb_name,
            as_text=save_pb_as_text
        )
        return graphdef_frozen


# This line must be executed before loading Keras model.
tf.keras.backend.set_learning_phase(0)

models = [
    applications.VGG16(weights="imagenet"),
    applications.ResNet50(weights="imagenet"),
    applications.InceptionV3(weights="imagenet"),
    applications.MobileNet(weights="imagenet"),
    applications.MobileNetV2(weights="imagenet"),
    applications.Xception(weights="imagenet"),
    applications.NASNetLarge(weights="imagenet"),
    applications.DenseNet121(weights="imagenet")
]

model_fname = [
    "VGG16.pb",
    "ResNet50.pb",
    "InceptionV3.pb",
    "MobileNet.pb",
    "MobileNetV2.pb",
    "Xception.pb",
    "NASNetLarge.pb",
    "DenseNet121.pb"
]

for i in range(len(models)):
    model = models[i]

    session = tf.keras.backend.get_session()

    frozen_graph = freeze_graph(
        session.graph, session,
        [out.op.name for out in model.outputs],
        save_pb_dir=save_pb_dir,
        save_pb_name=model_fname[i]
    )

    del model
