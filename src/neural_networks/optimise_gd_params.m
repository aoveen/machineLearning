function [ param_values ] = optimise_gd_params( x, y)
%OPTIMISE_GD_PARAMS Summary of this function goes here
%   Detailed explanation goes here

    param_values = containers.Map;
    optimised_epochs = optimise_epochs(x, y, 'traingd');
    param_values('epochs') = optimised_epochs;
end

