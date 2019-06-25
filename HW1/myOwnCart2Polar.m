function [r,theta] = myOwnCart2Polar(dx,dy)
r = hypot(dx,dy);
theta = atan2(dx,dy);
end