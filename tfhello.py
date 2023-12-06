import tensorflow as tf
print("Built with CUDA:", tf.test.is_built_with_cuda())
print()
print("Tensorflow version:", tf.__version__)
print()
print(tf.config.list_physical_devices("GPU"))
print()
print("Preparing a test case...")
mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0
model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10)
])
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
print("Compiling a model...")
model.compile(optimizer='adam', loss=loss_fn, metrics=['accuracy'])
print("Training the model...")
model.fit(x_train, y_train, epochs=5)
print("Evaluating the model...")
model.evaluate(x_test,  y_test, verbose=2)
print("Done")
