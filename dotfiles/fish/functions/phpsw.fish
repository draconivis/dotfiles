function phpsw -d 'switch to another php version'
    brew unlink php@$argv[1]
    brew link --overwrite --force shivammathur/php/php@$argv[1]
end

