load('../../support/noisydata_students.mat')

params = containers.Map;
params('show') = NaN;
params('showCommandLine') = 0;
params('showWindow') = 0;
params('time') = inf;

params('hidden_layers') = [1, 17];
params('trainFcn') = 'trainlm';
params('epochs') = 1000;
params('goal') = 7e-4;
params('max_fail') = 6;
params('min_grad') = 2.7e-7;
params('mu') = 8e-4;
params('mu_dec') = 0.21;
params('mu_inc') = 10;
params('mu_max') = 1e10;

%params('lr') = 0.01;
%params('mc') = 0.9;

confusion = cell(1, 10);
for i = 1:10
    [testX, trainingX] = select_fold(x, i, 10);
    [testY, trainingY] = select_fold(y, i, 10);
    net = create_nn(trainingX, trainingY, -1, params);
    predictions = testANN(net, testX);
    confusion{i} = calc_confusion_matrix(testY, predictions);
    [r, p, f, e] = stats(confusion{i});
end

avg_f1s = [];
for i = 1:10
    [~, ~, f, ~] = stats(confusion{i});
    avg_f1s(end+1) = mean(f);
end

plot(1:10, avg_f1s, 'r-x','MarkerSize', 8)
axis([0, 10, 0, 100])
hold on
xlabel('Fold')
ylabel('Mean f1')
grid on





