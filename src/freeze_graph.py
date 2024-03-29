import sys
import tensorflow as tf
from tensorflow.python.framework import graph_io
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

model_name = sys.argv[1]

model = getattr(applications, model_name)(weights="imagenet")

session = tf.keras.backend.get_session()

frozen_graph = freeze_graph(
    session.graph, session,
    [out.op.name for out in model.outputs],
    save_pb_dir=save_pb_dir,
    save_pb_name=model_name+'.pb'
)
