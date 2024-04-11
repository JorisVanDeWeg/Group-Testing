function x_estimate = COMP(A, y)
    % COMP algorithm for group testing.
    % A is the measurement matrix and y is the vector of test outcomes.

    % Initialize all items as defective.
    x_estimate = ones(size(A, 2), 1); % Defective (1) until proven nondefective
    
    % Loop through each test outcome
    for test_idx = 1:length(y)
        if y(test_idx) == 0
            % If the test is negative, all items in that test are nondefective.
            x_estimate(A(test_idx, :) == 1) = 0;
        end
    end
end