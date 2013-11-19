load('../../support/cleandata_students.mat') 

load('./config_maps/config_6_output.mat')
load('./config_maps/config_single_outputs.mat')

confusion_six_output = cell(1, 10);
confusion_six_single_output = cell(1, 10);
for i = 1:10
    [testX, trainingX] = select_fold(x, i, 10);
    [testY, trainingY] = select_fold(y, i, 10);
    
    %Six ouput network
    net = create_nn(trainingX, trainingY, -1, config_6_output);
    predictions = testANN(net, testX);
    confusion_six_output{i} = calc_confusion_matrix(testY, predictions);
    [r, p, f, e] = stats(confusion_six_output{i});
    
    %Single output networks
    nets = cell(1,6);
    for j = 1:6
        trainingYSingle = trainingY == j;
        nets{j} = create_nn(trainingX, trainingYSingle, -1, config_single_outputs{j});
    end
    predictions = testANN(nets, testX);
    confusion_six_single_output{i} = calc_confusion_matrix(testY, predictions);
    
end

avg_six_ouput_f1s = [];
avg_single_ouputs_f1s = [];
for i = 1:10
    [~, ~, f_six_output, ~] = stats(confusion_six_output{i});
    avg_six_ouput_f1s(end+1) = mean(f_six_output);
    [~, ~, f_single_output, ~] = stats(confusion_six_single_output{i});
    avg_single_ouputs_f1s(end+1) = mean(f_single_output);
end

plot(1:10, avg_six_ouput_f1s, 'r-x', 'MarkerSize', 8)
hold on
plot(1:10, avg_single_ouputs_f1s, 'b-x','MarkerSize', 8)
axis([0, 10, 0, 100])
hold on
xlabel('Fold')
ylabel('Mean f1')
grid on





