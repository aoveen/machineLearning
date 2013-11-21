function [predictions] = testCBR(cbr, x)
    predictions = zeros(1, length(x));
    predict = cbr.predict;
    for i=1:length(x)
        predictions(i) = predict(cbr, x(i, :));
    end
end

