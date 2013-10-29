classdef treesTest < matlab.unittest.TestCase
    properties
        fns
    end
 
    methods(TestMethodSetup)
        function createFigure(testCase)
            testCase.fns = trees();
        end
    end
    
    methods (Test)

        function testTruth(testCase)
            testCase.verifyEqual(1, 1);
        end
        
        function testSplit(testCase)
            examples = [0 0; 
                        1 0; 
                        1 0];
            targets  = [1; 
                        0; 
                        1];
                    
            [ex, bin] = testCase.fns.split_examples_targets(examples, targets, 1, 0);
            testCase.verifyEqual(ex, [0 0]);
            testCase.verifyEqual(bin, [1]);
            
            [ex, bin] = testCase.fns.split_examples_targets(examples, targets, 2, 0);
            testCase.verifyEqual(ex, [0 0; 1 0; 1 0]);
            testCase.verifyEqual(bin, [1; 0; 1]);
            
            [ex, bin] = testCase.fns.split_examples_targets(examples, targets, 1, 1);
            testCase.verifyEqual(ex, [1 0; 1 0]);
            testCase.verifyEqual(bin, [0; 1]);
            
            [ex, bin] = testCase.fns.split_examples_targets(examples, targets, 2, 1);
            testCase.verifyEqual(ex, zeros(0, 2));
            testCase.verifyEqual(bin, zeros(0, 1));
        end
    end
end