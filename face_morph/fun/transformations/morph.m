%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This module calculate the face morphism (for mean
%   calculation).
%
%   Marina von Steinkirch, spring/2013
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function final_morph = morph(source, target, origin_pts, target_pts, warp_frac)

% add points on the corners of the images
[h, w, number_ch] = size(target); 
origin_pts = [origin_pts; 1,1; 1,h; w,1; w,h];
target_pts = [target_pts; 1,1; 1,h; w,1; w,h];


% local arrays
final_morph = cell(length(warp_frac), 1);
[X,Y] = meshgrid(1:w, 1:h);
ind_array = cell(number_ch, 1);


% convert subscripts to linear indices
for ch = 1:number_ch
    ind_array{ch} = sub2ind([h,w,number_ch], Y(:), X(:), ones(h*w,1)*ch);
end


% calculate the morph for all the warp_frac values
for j = 1:length(warp_frac)
    
    % find the middle
    wrap_here = warp_frac(j);
    middle = origin_pts + wrap_here*(target_pts - origin_pts);
    
    % find the delaunay triangulation 
    tri = delaunay(middle(:,1), middle(:,2));
    tri_array = size(tri,1);
    
    %define local arrays
    partial_img = ones(h, w, number_ch);
    source_array = cell(tri_array, 1);
    destination_array = cell(tri_array, 1);
    inter_array = cell(number_ch, tri_array);

    % find the triangle corresponding to each point
    triangle = mytsearch(middle(:,1), middle(:,2), tri, X(:), Y(:));
    
	% find the transformations
    for i = 1:tri_array
        X_inverse = inv([middle(tri(i,:),1), middle(tri(i,:),2), ones(3,1)]');
        XY1 = [origin_pts(tri(i,:),1), origin_pts(tri(i,:),2), ones(3,1)]' * X_inverse;
        XY2 = [target_pts(tri(i,:),1), target_pts(tri(i,:),2), ones(3,1)]' * X_inverse;
        trans_found=find(triangle==i);
        inverse = [X(trans_found), Y(trans_found), ones(length(trans_found),1)]';
        source_array{i} = XY1*inverse;
        destination_array{i} = XY2*inverse;
        for k = 1:number_ch
            inter_array{k,i} = ind_array{k}(trans_found);
        end
    end
    
    
   % interpolate  --> this is the difference from the
   % previous morph.m module (for face morphism)
    source_array = cat(2, source_array{:});
    destination_array = cat(2, destination_array{:});
    for c = 1:number_ch
        partial_img(cat(1,inter_array{c,:})) = (1-wrap_here)*interp2( source(:,:,c), source_array(1,:), source_array(2,:), '*cubic', 1 )+ ...
                wrap_here*interp2(target(:,:,c), destination_array(1,:), destination_array(2,:), '*cubic', 1 );
    end
  
    
    % final frame
    final_morph{j} = partial_img;
end