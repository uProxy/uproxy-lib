module.exports = (grunt) ->

  path = require 'path';

  #-------------------------------------------------------------------------
  grunt.initConfig {
    pkg: grunt.file.readJSON 'package.json'

    typescript:
      taskmanager:  # source code
        src: ['src/taskmanager/taskmanager.ts']
        dest: 'build/'
        options:
          basePath: 'src/'
      taskmanager_spec:  # spec test files
        src: ['src/taskmanager/taskmanager.spec.ts']
        dest: 'build/'
        options:
          basePath: 'src/'
      arraybuffers:  # source code
        src: ['src/arraybuffers/**.ts',
              '!src/arraybuffers/**.spec.ts',
              '!src/arraybuffers/**.d.ts']
        dest: 'build/'
        options:
          basePath: 'src/'
          ignoreError: false
      arraybuffers_spec:  # spec test files
        src: ['src/arraybuffers/arraybuffers.spec.ts']
        dest: 'build/'
        options:
          basePath: 'src/'
          ignoreError: false
    jasmine:
      taskmanager:
        src: ['build/taskmanager/taskmanager.js']
        options:
          specs: 'build/taskmanager/taskmanager.spec.js'
          outfile: 'build/_SpecRunner.html'
          keepRunner: true
      arraybuffers:
        src: ['build/arraybuffers/**/*.js', '!build/arraybuffers/**/*.spec.js']
        options:
          specs: 'build/arraybuffers/**/*.spec.js'
    clean: ['build/**']
  }  # grunt.initConfig

  #-------------------------------------------------------------------------
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-typescript'

  #-------------------------------------------------------------------------
  grunt.registerTask 'build', [
    'typescript:taskmanager'
    'typescript:taskmanager_spec'
    'typescript:arraybuffers'
    'typescript:arraybuffers_spec'
  ]

  # This is the target run by Travis. Targets in here should run locally
  # and on Travis/Sauce Labs.
  grunt.registerTask 'test', [
    'build'
    'jasmine:taskmanager'
    'jasmine:arraybuffers'
  ]

  grunt.registerTask 'default', [
    'test'
  ]
