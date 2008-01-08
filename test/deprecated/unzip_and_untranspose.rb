
def test_unzip_and_untranspose
  a = [1,2,3]
  b = %w{a b c}
  assert_equal [a, b], a.zip(b).to_a.untranspose
  assert_equal [a, b], [a, b].transpose.untranspose
  assert_equal a, a.zip(b).to_a.unzip

  c = [nil, false, true]
  assert_equal [a, b, c], a.zip(b, c).to_a.untranspose
  assert_equal [a, b, c], [a, b, c].transpose.untranspose
  assert_equal a, a.zip(b, c).to_a.unzip
end
