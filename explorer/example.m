clear, clc, close all

% example plot
figure(1)
surf(peaks(100))
grid on

set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
title('Demo Plot')

% apply 3D exploration
explorer(gcf)