
% Step 1: Image Acquisition
handImage = imread('images.jpeg');
figure, imshow(handImage);
title('Original Hand Image');

% Step 2: Preprocessing
grayImage = rgb2gray(handImage);
figure, imshow(grayImage);
title('Grayscale Image');

enhancedImage = adapthisteq(grayImage);
figure, imshow(enhancedImage);
title('Contrast Enhanced Image');

smoothedImage = imgaussfilt(enhancedImage, 2);
figure, imshow(smoothedImage);
title('Smoothed Image');

% Step 3: Vein Detection
edges = edge(smoothedImage, 'Canny');
figure, imshow(edges);
title('Edge Detected Image');

se = strel('line', 3, 90);
veins = imdilate(edges, se);
figure, imshow(veins);
title('Dilated Edges');

veinThinned = bwmorph(veins, 'thin', Inf);
figure, imshow(veinThinned);
title('Thinned Veins');

% Step 4: Post-Processing
cleanVeins = bwareaopen(veinThinned, 50);
figure, imshow(cleanVeins);
title('Cleaned Veins');

% Step 5: Overlay on Original Image (Optional)
overlayImage = imoverlay(handImage, cleanVeins, [1 0 0]); % Red color for veins
figure, imshow(overlayImage);
title('Veins Overlay on Original Image');