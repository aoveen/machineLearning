folds = 10;

confuse = zeros(6);

for i=1:folds
    [testX, trainingX] = select_fold(x, i, folds);
    [testY, trainingY] = select_fold(y, i, folds);
    cbr = CBRinit(trainingX, trainingY);
    p = testCBR(cbr, testX);
    confuse = confuse + calc_confusion_matrix(testY, p);
end

confuse