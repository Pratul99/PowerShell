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
15-09-2024
----------
#>

Function Get-BobResponse() {
    <#
    .SYNOPSIS
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.
    
    .DESCRIPTION
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.

    Bob answers 'Sure.' if you ask him a question.

    He answers 'Whoa, chill out!' if you yell at him.

    He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

    He says 'Fine. Be that way!' if you address him without actually saying
    anything.

    He answers 'Whatever.' to anything else.
    
    .PARAMETER HeyBob
    The sentence you say to Bob.
    
    .EXAMPLE
    Get-BobResponse -HeyBob "Hi Bob"
    #>
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    Throw "Please implement this function"
}

