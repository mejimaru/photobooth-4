require 'fileutils'

namespace :picture_set do

  desc 'Re-create collage images'
  task :recreate_collage_images, [:path] => [:environment] do |_task, args|
    PictureSet::PICTURE_PATH = args[:path] if args[:path].present?
    PictureSet.all.each { |ps| ps.combine_images(overwrite: true) }
  end

  desc 'Re-create polaroid gifs'
  task :recreate_polaroid_images, [:path] => [:environment] do |_task, args|
    PictureSet::PICTURE_PATH = args[:path] if args[:path].present?
    PictureSet.all.each { |ps| ps.create_animation(overwrite: true) }
  end

  desc 'Exports all images into a single directory (without the single polaroids)'
  task :export, %i[output path] => [:environment] do |_task, args|
    PictureSet::PICTURE_PATH = args[:path] if args[:path].present?
    puts "copying from #{PictureSet::PICTURE_PATH} to #{args[:output]}."
    PictureSet.all.each do |ps|
      Dir.chdir(ps.dir) do
        FileUtils.cp(ps.animation, args[:output])
        FileUtils.cp(ps.pictures.map { |p| p[:full] }, args[:output])
      end
    end
  end

end
