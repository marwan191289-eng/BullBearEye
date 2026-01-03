@{
    # Customize rules as needed; this is a minimal example to start
    Rules = @{
        PSUseDeclaredVarsMoreThanAssignments = @{
            Enable = $true
        }
        PSAvoidUsingPlainTextForSecret = @{
            Enable = $true
        }
    }
    ExcludeRules = @(
        # Example: 'AvoidUsingWriteHost' 
    )
}
