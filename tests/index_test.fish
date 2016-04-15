set r (index foo foo bar baz)
if test $status -a $r -eq 1
  emit success
else
  emit fail
end

set r (index bar foo bar baz)
if test $status -a $r -eq 2
  emit success
else
  emit fail
end

index eggs foo bar baz
if test !$status
  emit success
else
  emit fail $r
end
