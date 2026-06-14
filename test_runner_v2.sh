#!/bin/bash
for f in compiler/tests/integration/*.atl; do
    echo "Testing $f..."
    
    # Check if this is a type-error test
    if grep -q "// Type Error:" "$f"; then
        # Type-error test: compiler should fail with semantic error
        output=$(./bootstrap/atlasc/src/main_v2 build --stdlib stdlib "$f" 2>&1)
        ret=$?
        if [ $ret -eq 0 ]; then
            echo "FAIL: $f - expected type error but compilation succeeded"
            exit 1
        fi
        if echo "$output" | grep -q "Semantic\|Error"; then
            echo "OK: type error detected"
        else
            echo "FAIL: $f - compilation failed but no error message found"
            exit 1
        fi
        continue
    fi
    
    # Normal test: compile, run, check exit code
    ./bootstrap/atlasc/src/main_v2 build --stdlib stdlib "$f" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed to compile $f"
        exit 1
    fi
    exec_name="${f%.atl}"
    
    expected=$(grep "Exit Code:" "$f" | awk -F':' '{print $2}' | tr -d ' ')
    if [ -z "$expected" ]; then
        expected=0
    fi
    
    ./"$exec_name" >/dev/null 2>&1
    result=$?
    
    if [ "$result" -ne "$expected" ]; then
        echo "Test failed for $f! Expected $expected, got $result"
        exit 1
    fi
done
echo "All tests passed with self-hosted compiler!"
