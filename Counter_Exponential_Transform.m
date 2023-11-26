function [Illumination_Equalized_Image] = Counter_Exponential_Transform(Input_Image, Slope_Control_Parameter)
%%%Convert the input image from RGB colour space to HSV colour space%%%
HSV_Image = rgb2hsv(Input_Image);
%%%Seperate Hue, Saturation and Value Components%%%
Hue_Component=HSV_Image(:,:,1);
Saturation_Component=HSV_Image(:,:,2);
Value_Component=HSV_Image(:,:,3);
Normalized_Value_Component=(Value_Component-min(Value_Component(:)))/(max(Value_Component(:))-min(Value_Component(:)));
Equalized_Value_Component=1-exp(-1*(Normalized_Value_Component/Slope_Control_Parameter));
Normalized_Equalized_Value_Component=(Equalized_Value_Component-min(Equalized_Value_Component(:)))/(max(Equalized_Value_Component(:))-min(Equalized_Value_Component(:)));


%%%Plot the Transformation Curve%%%

X_Axis=(unique(Normalized_Value_Component))';

Y_Axis=1-exp(-1*(X_Axis/Slope_Control_Parameter));

%figure,plot(X_Axis,Y_Axis);

xlabel('Actual Value');

ylabel('Enhanced Value');

title('Transformation Curve');

%%%Create a 2D array for enhanced image%%%
Equalized_HSV_Image=HSV_Image;
%%%Insert the enhanced value component%%%
Equalized_HSV_Image(:,:,3)=Normalized_Equalized_Value_Component;
%%%HSV to RGB colour space conversion%%%
Equalized_RGB_Image = hsv2rgb(Equalized_HSV_Image);
Illumination_Equalized_Image=uint8(255*Equalized_RGB_Image);