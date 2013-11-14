load('/homes/hjd11/proj/machineLearning/support/cleandata_students.mat');
[params, confusion] = train_a_single_net(x, y);
params
confusion
[recall, precision, fs, error] = stats(confusion);
recall
precision
fs
error