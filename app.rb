require 'sinatra'
require 'sinatra/contrib'
require 'tilt/plain'

Tilt.register :html, Tilt[:erb]

set :views, ['views', 'public/projects']

helpers do
  def html(*args)
    render :html, *args
  end

  def find_template(views, name, engine, &block)
    views.each { |v| super(v, name, engine, &block) }
  end
end

get '/' do
  html :index
end

get '/resume' do
  send_file('public/pdf/resume.pdf', type: :pdf)
end

get '/game-of-life' do
  html :game_of_life
end

get '/julia' do
  html :julia
end

get '/music-visualizer' do
  html :'soundcloud-visualizer/html/index'
end

get '/blog/?*' do
  blog(request.path) { 404 }
end

get '/itp-portfolio' do
  algorithmic_geometric_sketches = [
    # { order: 11, file_name: 'circles', source_url: '', description: '' },
    { order: 24, file_name: 'lissajous', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-2/lissajous-of/src/ofApp.cpp', description: 'Lissajous figures.', type: 'openframeworks' },
    # { order: 21, file_name: 'logarithmic_spiral', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-4/homework/muriel-cooper-noise-reduction/sketch.js', description: '' },
    { order: 5, file_name: 'rose_equation', source_url: 'https://github.com/oshoham/code-sketches/blob/master/rose-OF/src/ofApp.cpp', description: 'Animation of the Rose Equation.', type: 'openframeworks' },
    { order: 6, file_name: 'sorting_pixels', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sorting/src/ofApp.cpp', description: 'Sorting the pixels of an image by brightness.', type: 'openframeworks' },
    { order: 3, file_name: 'tiles', source_url: 'https://github.com/oshoham/code-sketches/blob/master/polar-tiles/sketch.js', description: 'Animation of ceiling tiles found in a gazebo in Prospect Park.', type: 'p5' },
    # { order: 11, file_name: 'voronoi_resize', source_url: '', description: '' },
    { order: 22, file_name: 'walking_man', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-3/homework/walking-person/src/ofApp.cpp', description: 'Motion capture data and branching lines.', type: 'openframeworks' },
    { order: 20, file_name: 'waves', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/image-example/src/ofApp.cpp', description: 'Pixel colors set by sine waves.', type: 'openframeworks' },
  ].sort_by { |s| s[:order] }.reverse

  webcam_experiments = [
    { order: 18, file_name: 'ascii_webcam', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/homework/halftone/src/ofApp.cpp', description: 'Webcam video mapped to ASCII characters.', type: 'openframeworks' },
    { order: 19, file_name: 'motion_waves', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/mosaic-example-video/src/ofApp.cpp', description: 'Mapping webcam video to geometric shapes and tracking motion.', type: 'openframeworks' },
    { order: 15, file_name: 'optical_flow_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 14, file_name: 'optical_flow_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 13, file_name: 'optical_flow_3', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 12, file_name: 'optical_flow_4', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 16, file_name: 'voronoi_sampling', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/poisson-disc-mosaic/src/ofApp.cpp', description: 'A Voronoi diagram of a Poisson-disc sampling of webcam video.', type: 'openframeworks' },
    { order: 17, file_name: 'mosaic_of_mosaics', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/homework/ken-knowlton/src/ofApp.cpp', description: "A mosaic of Ken Knowlton's face mosaics, using webcam video.", type: 'openframeworks' },
  ].sort_by { |s| s[:order] }.reverse

  recreating_the_past_sketches = [
    { order: 4, file_name: 'osamu_sato', source_url: 'https://github.com/oshoham/code-sketches/blob/master/art-of-computer-designing/ch-1/step-2-lesson-3-crystal/sketch.js', description: "Animation of a design from Osamu Sato's book The Art of Computer Designing.", type: 'p5' },
    { order: 3, file_name: 'sol_lewitt_1', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sol-lewitt-wall-drawing-118/sketch.js', description: "Animation of Sol LeWitt's Wall Drawing 118.", type: 'p5' },
    { order: 2, file_name: 'sol_lewitt_2', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sol-lewitt-wall-drawing-138/sketch.js', description: "Animation of Sol LeWitt's Wall Drawing 138.", type: 'p5' },
    { order: 1, file_name: 'sol_lewitt_3', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sol-lewitt-wall-drawing-91/sketch.js', description: "Animation of Sol LeWitt's Wall Drawing 91.", type: 'p5' },
    { order: 6, file_name: 'vera_molnar_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-1/homework/vera-molnar-molndrian-1974-recreation-animated/sketch.js', description: "Animation of Vera Molnar's Molndrian.", type: 'p5' },
    { order: 5, file_name: 'vera_molnar_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-1/homework/vera-molnar-hommage-a-durer-recreation-animated/sketch.js', description: "Animation of Vera Molnar's Hommage à Dürer.", type: 'p5' },
    { order: 8, file_name: 'whitney_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-2/homework/whitney/src/ofApp.cpp', description: "Recreation of a scene from John Whitney's film Arabesque.", type: 'openframeworks' },
    { order: 9, file_name: 'whitney_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/digital-harmony-arabesque/src/ofApp.cpp', description: "Recreation of a scene from John Whitney's film Arabesque.", type: 'openframeworks' },
    { order: 7, file_name: 'whitney_3', source_url: 'https://github.com/oshoham/code-sketches/blob/master/whitney-digital-harmony/src/ofApp.cpp', description: "Animation of the cover of John Whitney's book Digital Harmony.", type: 'openframeworks' }
  ].sort_by { |s| s[:order] }.reverse

  turbine_sketches = [
    { order: 10, file_name: 'spiral_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/turbine/src/ofApp.cpp', description: 'Tracing the path of a spinning turbine.', type: 'openframeworks' },
    { order: 9, file_name: 'spiral_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/turbine/src/ofApp.cpp', description: 'Turbines.', type: 'openframeworks' },
    { order: 8, file_name: 'spiral_3', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/turbine/src/ofApp.cpp', description: 'Turbine paths modulated by sine waves.', type: 'openframeworks' },
  ]

  erb :itp_portfolio, locals: { algorithmic_geometric_sketches: algorithmic_geometric_sketches, webcam_experiments: webcam_experiments, recreating_the_past_sketches: recreating_the_past_sketches, turbine_sketches: turbine_sketches }
end

get '/portfolio' do
  algorithmic_geometric_sketches = [
    # { order: 11, file_name: 'circles', source_url: '', description: '' },
    { order: 24, file_name: 'lissajous', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-2/lissajous-of/src/ofApp.cpp', description: 'Lissajous figures.', type: 'openframeworks' },
    # { order: 21, file_name: 'logarithmic_spiral', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-4/homework/muriel-cooper-noise-reduction/sketch.js', description: '' },
    { order: 5, file_name: 'rose_equation', source_url: 'https://github.com/oshoham/code-sketches/blob/master/rose-OF/src/ofApp.cpp', description: 'Animation of the Rose Equation.', type: 'openframeworks' },
    { order: 6, file_name: 'sorting_pixels', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sorting/src/ofApp.cpp', description: 'Sorting the pixels of an image by brightness.', type: 'openframeworks' },
    { order: 3, file_name: 'tiles', source_url: 'https://github.com/oshoham/code-sketches/blob/master/polar-tiles/sketch.js', description: 'Animation of ceiling tiles found in a gazebo in Prospect Park.', type: 'p5' },
    # { order: 11, file_name: 'voronoi_resize', source_url: '', description: '' },
    { order: 22, file_name: 'walking_man', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-3/homework/walking-person/src/ofApp.cpp', description: 'Motion capture data and branching lines.', type: 'openframeworks' },
    { order: 20, file_name: 'waves', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/image-example/src/ofApp.cpp', description: 'Pixel colors set by sine waves.', type: 'openframeworks' },
  ].sort_by { |s| s[:order] }.reverse

  webcam_experiments = [
    { order: 18, file_name: 'ascii_webcam', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/homework/halftone/src/ofApp.cpp', description: 'Webcam video mapped to ASCII characters.', type: 'openframeworks' },
    { order: 19, file_name: 'motion_waves', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/mosaic-example-video/src/ofApp.cpp', description: 'Mapping webcam video to geometric shapes and tracking motion.', type: 'openframeworks' },
    { order: 15, file_name: 'optical_flow_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 14, file_name: 'optical_flow_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 13, file_name: 'optical_flow_3', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 12, file_name: 'optical_flow_4', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/optical-flow-particles/src/ofApp.cpp', description: 'Experiments with webcam video, optical flow, and particle systems.', type: 'openframeworks' },
    { order: 16, file_name: 'voronoi_sampling', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-6/poisson-disc-mosaic/src/ofApp.cpp', description: 'A Voronoi diagram of a Poisson-disc sampling of webcam video.', type: 'openframeworks' },
    { order: 17, file_name: 'mosaic_of_mosaics', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-5/homework/ken-knowlton/src/ofApp.cpp', description: "A mosaic of Ken Knowlton's face mosaics, using webcam video.", type: 'openframeworks' },
  ].sort_by { |s| s[:order] }.reverse

  recreating_the_past_sketches = [
    { order: 4, file_name: 'osamu_sato', source_url: 'https://github.com/oshoham/code-sketches/blob/master/art-of-computer-designing/ch-1/step-2-lesson-3-crystal/sketch.js', description: "Animation of a design from Osamu Sato's book The Art of Computer Designing.", type: 'p5' },
    { order: 3, file_name: 'sol_lewitt_1', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sol-lewitt-wall-drawing-118/sketch.js', description: "Animation of Sol LeWitt's Wall Drawing 118.", type: 'p5' },
    { order: 2, file_name: 'sol_lewitt_2', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sol-lewitt-wall-drawing-138/sketch.js', description: "Animation of Sol LeWitt's Wall Drawing 138.", type: 'p5' },
    { order: 1, file_name: 'sol_lewitt_3', source_url: 'https://github.com/oshoham/code-sketches/blob/master/sol-lewitt-wall-drawing-91/sketch.js', description: "Animation of Sol LeWitt's Wall Drawing 91.", type: 'p5' },
    { order: 6, file_name: 'vera_molnar_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-1/homework/vera-molnar-molndrian-1974-recreation-animated/sketch.js', description: "Animation of Vera Molnar's Molndrian.", type: 'p5' },
    { order: 5, file_name: 'vera_molnar_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-1/homework/vera-molnar-hommage-a-durer-recreation-animated/sketch.js', description: "Animation of Vera Molnar's Hommage à Dürer.", type: 'p5' },
    { order: 8, file_name: 'whitney_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-2/homework/whitney/src/ofApp.cpp', description: "Recreation of a scene from John Whitney's film Arabesque.", type: 'openframeworks' },
    { order: 9, file_name: 'whitney_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/digital-harmony-arabesque/src/ofApp.cpp', description: "Recreation of a scene from John Whitney's film Arabesque.", type: 'openframeworks' },
    { order: 7, file_name: 'whitney_3', source_url: 'https://github.com/oshoham/code-sketches/blob/master/whitney-digital-harmony/src/ofApp.cpp', description: "Animation of the cover of John Whitney's book Digital Harmony.", type: 'openframeworks' }
  ].sort_by { |s| s[:order] }.reverse

  turbine_sketches = [
    { order: 10, file_name: 'spiral_1', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/turbine/src/ofApp.cpp', description: 'Tracing the path of a spinning turbine.', type: 'openframeworks' },
    { order: 9, file_name: 'spiral_2', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/turbine/src/ofApp.cpp', description: 'Turbines.', type: 'openframeworks' },
    { order: 8, file_name: 'spiral_3', source_url: 'https://github.com/oshoham/sfpc__recreating-the-past/blob/master/week-9/turbine/src/ofApp.cpp', description: 'Turbine paths modulated by sine waves.', type: 'openframeworks' },
  ]

  erb :portfolio, locals: { algorithmic_geometric_sketches: algorithmic_geometric_sketches, webcam_experiments: webcam_experiments, recreating_the_past_sketches: recreating_the_past_sketches, turbine_sketches: turbine_sketches }
end


namespace '/recreating-the-past' do
  get '/vera-molnar-molndrian' do
    html :'recreating-the-past/vera-molnar-molndrian'
  end
  get '/vera-molnar-molndrian-animated' do
    html :'recreating-the-past/vera-molnar-molndrian-animated'
  end
end

def blog(path, &missing_file_block)
  @title = 'orenshoham.com | blog'

  file_path = File.join(File.dirname(__FILE__), 'blog/_site', path.gsub('/blog', ''))
  unless file_path =~ /\.[a-z]+$/i
    if file_path == './blog/_site/'
      file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    else
      file_path = file_path + '.html'
    end
  end

  if File.exist?(file_path)
    file = File.open(file_path, 'rb')
    contents = file.read
    file.close

    html contents
  else
    html :not_found
  end
end
