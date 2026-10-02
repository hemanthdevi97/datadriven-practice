select count(commit_id) total_commits , count(distinct(author)) distinct_authors
 from repo_commits
