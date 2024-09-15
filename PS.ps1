# Jai Shree Ram


<#
11-09-2024
----------
#>

<# 
Can you below format to give infomation about your func.
    
    .SYNOPSIS
    Outputs "Hello, World!"
    
    .DESCRIPTION
    Output "Hello, World!".
    
    .EXAMPLE
    Get-HelloWorld
#>	



# Collatz Conjecture

    $n = 17
    function CollatzConjecture {
        param (
            # To ensure $n should be atleast 1 and not -ve
            [Parameter(Mandatory=$true)]
            [ValidateRange(1, [Int64]::Maxvalue)]
            [Int64] $n
        )
        
        # Initialize step
        $steps = 0

        # Real function start

        while ($n -ne 1) {
            if ($n % 2 -eq 0) {
                <# If $n is even divide by 2#>
                $n = $n / 2
            } else {
                <# If $n is odd multiply by 3 and add 1 #>
                $n = $n * 3 + 1
            }
            # Increment the steps count
            $steps++
        }

        # Return steps
        return $steps
    }

    CollatzConjecture


    # ------------------------------------------------------------- x ----------------------------------------------------------


<#
1-09-2024
----------
#>


