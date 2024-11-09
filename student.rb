#!/usr/bin/env ruby
require 'date'

class Student
  @@students = []
  attr_accessor :name, :surname, :date_of_birth

  def initialize(name, surname, date_of_birth)
    @name = name
    @surname = surname
    @date_of_birth = date_of_birth

    raise ArgumentError, "Wrong date of birth" unless correct_date?
    add_student
  end

  def self.all_students
    @@students
  end

  def correct_date?
    @date_of_birth.is_a?(Date) && @date_of_birth < Date.today
  end

  def student_duplicate?
    @@students.any? do |student|
      student.name == @name && student.surname == @surname && student.date_of_birth == @date_of_birth
    end
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today.month < @date_of_birth.month || (today.month == @date_of_birth.month && today.day < @date_of_birth.day)
    age
  end

  def add_student
    raise ArgumentError, "Duplicate student.rb" if student_duplicate?
    @@students << self
  end

  def self.remove_student(student)
    @@students.delete_if { |s| student.name == s.name && student.surname == s.surname && student.date_of_birth == s.date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end
end
