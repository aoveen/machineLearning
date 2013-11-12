function [ param_values ] = optimise_gdm_params( x, y)
%OPTIMISE_GDM_PARAMS Summary of this function goes here

    param_values = containers.Map;
    optimised_epochs = optimise_epochs(x, y, 'traingdm');
    param_values('epochs') = optimised_epochs;
end

