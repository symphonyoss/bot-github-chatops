[#ftl output_format="HTML" auto_esc=true strip_whitespace=true]
[#switch issue.state]
  [#case "open"]
    [#assign accentStyle="tempo-bg-color--red"]
    [#assign textStyle="tempo-text-color--red"]
    [#assign titleBgStyle="tempo-bg-color--red"]
    [#break]
  [#default]
    [#assign accentStyle="tempo-bg-color--gray"]
    [#assign textStyle="tempo-text-color--gray"]
    [#assign titleBgStyle="tempo-bg-color--white"]
[/#switch]

<card accent="${accentStyle}">
  <header>
    <p>
      <div class="${titleBgStyle}"><hr/></div>
      <b><a href="${issue.html_url}">${repoSlug} issue #${issue.number} - ${issue.title}</a></b><br/>
      <b>State: <span class="${textStyle}">${issue.state}</span></b> ❖
      <b>Type:</b> [#if issue.pull_request??]Pull request[#else]Issue[/#if] ❖
      <b>Created by:</b> <a href="${issue.user.html_url}">${issue.user.login}</a> on ${issue.created_at?datetime.iso?string["yyyy-MM-dd h:mm:ssa z"]} ❖
      <b>Last updated:</b> ${issue.updated_at?datetime.iso?string["yyyy-MM-dd h:mm:ssa z"]}[#if issue.closed_by??] ❖
      <b>Closed by:</b> <a href="${issue.closed_by.html_url}">${issue.closed_by.login}</a> on ${issue.closed_at?datetime.iso?string["yyyy-MM-dd h:mm:ssa z"]}[/#if]
    </p>
[#if issue.body??]
    <p><b>Description:</b> ${issue.body}</p>
[/#if]
    <p><b>Add Comment Command:</b> ac ${repoSlug} ${issue.number} [COMMENT TEXT HERE]</p>
[#if issue.comments > 0 && issue.comment_data??]
    <p><i>Click to see ${issue.comments} comments</i></p>
[/#if]
  </header>
[#if issue.comments > 0 && issue.comment_data??]
  <body>
    <table>
      <thead><tr><th>Author</th><th>Last Updated</th><th>Comment</th></tr></thead>
      <tbody>
  [#list issue.comment_data as comment]
        <tr><td><a href="${comment.user.html_url}">${comment.user.login}</a></td><td>${comment.updated_at?datetime.iso?string["yyyy-MM-dd h:mm:ssa z"]}</td><td>${comment.body}</td></tr>
  [/#list]
      </tbody>
    </table>
  </body>
[/#if]
</card>
