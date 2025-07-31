script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Cleaning build..."
flutter clean

env_file="$script_dir/lib/env/env.g.dart"
if [ -e "$env_file" ]; then
    echo "Deleting env.g.dart..."
    rm "$env_file"
fi

echo "Running build runner..."
dart run build_runner build --delete-conflicting-outputs

echo "Environment variables updated."
