#!/bin/sh

check_setup() {
    if [ ! -d "$HOME/.cfg" ]; then
        echo "❌ Error: Bare repo not found at $HOME/.cfg"
        echo "Did you forget to clone or init the bare repo?"
        return 1
    fi

    if [ ! -f "$HOME/.cfg/info/sparse-checkout" ]; then
        echo "❌ Error: Sparse-checkout file not found at $HOME/.cfg/info/sparse-checkout"
        echo "Did you configure sparse-checkout?"
        return 1
    fi

    if ! type config 2>/dev/null | grep -q 'alias'; then
        echo "❌ Error: 'config' alias is not configured."
        echo "Check README and add config alias to .zshrc or .bashrc"
        return 1
    fi

    echo "✅ .cfg, sparse-checkout file, and 'config' alias found."
}

show_remote_config_file() {
    FILE="$1"
    if [ -z "$FILE" ]; then
        echo "❌ Error: No file specified."
        return 1
    fi

    check_setup || return 1

    # Remove line from sparse-checkout 
    sed -i "/$FILE/d" "$HOME/.cfg/info/sparse-checkout"

    config checkout "$FILE"

    echo "🙉 $FILE added locally."
}

hide_remote_config_file() {
    FILE="$1"
    if [ -z "$FILE" ]; then
        echo "❌ Error: No file specified."
        return 1
    fi

    check_setup || return 1

    # Add negative match to sparse-checkout
    grep -q "!$FILE" "$HOME/.cfg/info/sparse-checkout" || echo "!$FILE" >> "$HOME/.cfg/info/sparse-checkout"

    config checkout

    echo "🙈 $FILE excluded and removed locally."
}
