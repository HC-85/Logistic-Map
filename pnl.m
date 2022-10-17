function dydt = pnl(t,y)
dydt = [y(2);9.8*sin(y(1))];