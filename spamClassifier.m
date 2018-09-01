clc
clear all
filename = 'emailSample1.txt'; %change the filename to the file or the email you want to classify.
                               %spamSample1,2 and emailSample1,2 are testing emails.
                     
% Email Preprocessing
fprintf('\nPreprocessing email\n');
fprintf('\n\n');

% Extract Features
file_contents = readFile(filename);
word_indices  = processEmail(file_contents);
fprintf('\n\n');
fprintf('Word Indices: \n');
fprintf(' %d', word_indices);
fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%%Feature Extraction

fprintf('\nExtracting features from email\n');

% Extract Features

features      = emailFeatures(word_indices);

fprintf('\n');
fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

fprintf('Program paused. Press enter to continue.\n');
pause;

x = emailFeatures(word_indices);
load('spamTrain.mat');
C = 0.1;
model = svmTrain(X, y, C, @linearKernel);
p = svmPredict(model, x);

fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
fprintf('(1 indicates spam, 0 indicates not spam)\n\n');
fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

