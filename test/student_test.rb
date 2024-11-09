require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../student'

if ENV['RM_INFO'].nil?
  Minitest::Reporters.use! [
                             Minitest::Reporters::HtmlReporter.new(
                               report_filename: 'html_reports/index.html',
                               add_timestamp: true
                             )
                           ]
end


class StudentUnitTest < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, [])
  end

  def test_initialize_student
    student = Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15))
    assert_equal "Oleksandr", student.name
    assert_equal "Helevan", student.surname
    assert_equal Date.new(2006, 3, 15), student.date_of_birth
  end

  def test_duplicate_student
    Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15))
    assert_raises(ArgumentError) { Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15)) }
  end

  def test_correct_date
    student = Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15))
    assert student.correct_date?
    assert_raises(ArgumentError) { Student.new("Oleksandr", "Helevan", Date.new(2025, 1, 1)) }
  end
end

describe 'Student' do
  before do
    Student.class_variable_set(:@@students, [])
  end

  it 'should initialize with correct name, surname and birthdate' do
    student = Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15))
    _(student.name).must_equal 'Oleksandr'
    _(student.surname).must_equal 'Helevan'
    _(student.date_of_birth).must_equal Date.new(2006, 3, 15)
  end

  it 'should raise error when duplicate student is added' do
    Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15))
    _ { Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15)) }.must_raise ArgumentError
  end


  it 'should calculate correct age' do
    student = Student.new("Oleksandr", "Helevan", Date.new(2006, 3, 15))
    expected_age = Date.today.year - 2006 - (Date.today < Date.new(Date.today.year, 3, 15) ? 1 : 0)
    _(student.calculate_age).must_equal expected_age
  end
end
