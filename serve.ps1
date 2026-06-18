$l = New-Object Net.HttpListener
$l.Prefixes.Add('http://localhost:3000/')
$l.Start()
Write-Host "Listening on port 3000..."
while ($l.IsListening) {
    try {
        $ctx = $l.GetContext()
        $method = $ctx.Request.HttpMethod
        Write-Host "Request: $method $($ctx.Request.Url.PathAndQuery)"
        $b = [IO.File]::ReadAllBytes('C:\Users\krist\Desktop\Code\index.html')
        $ctx.Response.ContentType = 'text/html; charset=utf-8'
        $ctx.Response.ContentLength64 = [long]$b.Length
        if ($method -ne 'HEAD') {
            $ctx.Response.OutputStream.Write($b, 0, $b.Length)
        }
        $ctx.Response.OutputStream.Close()
        Write-Host "Done"
    } catch {
        Write-Host "ERROR: $_"
    }
}
