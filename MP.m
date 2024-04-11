function z = MP(A, y, epsilon)
    % Initialize the sparse coefficient vector z to all zeros.
    z = zeros(size(A,2), 1);
    
    % Initialize the residual r to y.
    r = double(y);
    % Initialize a variable to keep track of used atoms
    used_atoms = false(1, size(A, 2)); % 100 in our case
    
    % Loop until the stopping criterion is met.
    it = 0;
    while norm(r, 2) > epsilon
        % Compute the inner products between A's columns and r.
        inner_products = A' * r;
        inner_products(inner_products < 0) = 0;
        % Find the index of the column with the maximum inner product.
        % Exclude already used atoms.
        [inner_product_values, indices] = sort(abs(inner_products), 'descend');

        k = find(~used_atoms(indices), 1, 'first');
        % The ~ operator in MATLAB negates the logical array; flipping 
        % So if not used it is false, but flip to true to use
        max_col_index = indices(k);

        % Check if we found an unused atom
        if isempty(max_col_index)
            break; % No more useful atoms to add, exit the loop
        end
        
        % Update the coefficient of the chosen atom.
        z(max_col_index) = z(max_col_index) + inner_products(max_col_index);
        
        % Update the residual by reapplying the boolean operation.
        r = double(y) - double(A * z >= 1);
        % Mark the used atom so it isn't selected again
        used_atoms(max_col_index) = true;
        it = it + 1; 
        % disp(z)
    end
end