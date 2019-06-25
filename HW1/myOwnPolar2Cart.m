function [x,y] = myOwnPolar2Cart(r,theta)
x = r * cos(theta);
y = r * sin(theta);
end