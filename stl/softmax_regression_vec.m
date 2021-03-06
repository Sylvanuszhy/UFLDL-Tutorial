function [f,g] = softmax_regression(theta, X,y)
  %
  % Arguments:
  %   theta - A vector containing the parameter values to optimize.
  %       In minFunc, theta is reshaped to a long vector.  So we need to
  %       resize it to an n-by-(num_classes-1) matrix.
  %       Recall that we assume theta(:,num_classes) = 0.
  %
  %   X - The examples stored in a matrix.  
  %       X(i,j) is the i'th coordinate of the j'th example.
  %   y - The label for each example.  y(j) is the j'th example's label.
  %
  m=size(X,2);
  n=size(X,1);

  % theta is a vector;  need to reshape to n x num_classes.
  theta=reshape(theta, n, []);
  num_classes=size(theta,2);
  
  % initialize objective value and gradient.
  f = 0;
  g = zeros(size(theta));

  %
  % TODO:  Compute the softmax objective function and gradient using vectorized code.
  %        Store the objective function value in 'f', and the gradient in 'g'.
  %        Before returning g, make sure you form it back into a vector with g=g(:);
  %
%%% YOUR CODE HERE %%%
  tmp = theta'*X;
  %tmp = bsxfun(@minus, tmp, max(tmp, [], 2));
  numerator = exp(tmp);
  denominator = sum(numerator, 1);
  p = bsxfun(@rdivide, numerator, denominator);
  
  one = zeros(m, num_classes);
  I = sub2ind(size(one), 1:size(one,1), y);
  one(I) = 1;
  %one = one(:, 1:num_classes-1);
  
  f = (-1/m)*sum(sum(one'.*log(p)));
  g = (-1/m)*(one'-p)*X';
  g = g';
  g=g(:); % make gradient a vector for minFunc

