prices = xlsread('cocoa.xlsx');
returns = tick2ret(prices(:,1));
signal = 1*(rsindex(prices(:,1)) < 40) - 1*(rsindex(prices(:,1)) > 70);
portReturns = returns .* signal(1:end-1);
sharpeRatio = sharpe(portReturns,0)*sqrt(252)