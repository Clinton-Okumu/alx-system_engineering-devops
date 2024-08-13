#!/usr/bin/python3
"""Function that queries the Reddit API and returns a list of
titles of all hot articles for a given subreddit.
"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """Queries the Reddit API recursively to get a list of
    titles of all hot articles for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit.
        hot_list (list): List to store the titles of hot posts.
        after (str): The "after" parameter for pagination.

    Returns:
        list: The list containing.
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "Mozilla/5.0"}
    params = {"after": after}

    try:
        response = requests.get(url, headers=headers,
                                params=params, allow_redirects=False)
        if response.status_code == 200:
            data = response.json().get("data")
            after = data.get("after")
            children = data.get("children")
            for child in children:
                hot_list.append(child.get("data").get("title"))
            if after is not None:
                return recurse(subreddit, hot_list, after)
            return hot_list
        else:
            return None
    except Exception:
        return None
