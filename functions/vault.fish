function vault
  set -gx modes set get rm ls
  set -gx mode $argv[1]
  if contains $mode $modes
    emit vault-action $argv
  else
    return 1
  end
end

function vault-listener --on-event vault-action
  if test -n "$SECRETS_PATH"
    set -gx secrets $SECRETS_PATH
  else
    set -gx secrets ~/.secrets
  end

  switch $argv[1]
    case set
      echo $argv[3] > "$secrets/$argv[2].secret"
    case get
      cat "$secrets/$argv[2].secret"
    case rm
      rm "$secrets/$argv[2].secret"
    case ls
      for f in (ls $secrets/*.secret);
        echo (basename $f .secret)
      end
  end
end

abbr -a v vault
abbr -a vg vault get
abbr -a vs vault set
abbr -a vls vault ls
abbr -a vrm vault rm
