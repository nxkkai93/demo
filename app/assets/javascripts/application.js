function loadMoreRepositories(link) {
  var container = link.parentElement;
  container.classList.add('loading');

  fetch(link.href).then(function(response) {
    response.text().then(function(text) {
      $("#table-repositories tbody").append(text);


      var lastTd = $('#table-repositories  tr:last-child #repo-cursor').text();
      var href = link.getAttribute("href");

       // Check last load more
      var href = link.getAttribute("href");
      if(href.indexOf(lastTd) == -1) {
      	var newLoadMore = replaceQueryParam("after", lastTd, link.getAttribute("href"));
     	  link.setAttribute("href", newLoadMore);
      } else {
      	// $("#btn-repo-load-more").addClass("disabled-link disabled-none");
      	$("#btn-repo-load-more").addClass("disabled-none");
      }

    })
  })
}

// function toggleStar(el) {
//   fetch(el.action, { method: 'PUT', headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(function(response) {
//     response.text().then(function(text) {
//       // Parse text to get an actual element
//       var div = document.createElement('div')
//       div.innerHTML = text

//       // Find the star container
//       var container = el.closest('.star-badge')
//       container.replaceWith(div.firstElementChild)
//     })
//   })
// }

function replaceQueryParam(param, newval, search) {
    var regex = new RegExp("([?;&])" + param + "[^&;]*[;&]?");
    var query = search.replace(regex, "$1").replace(/&$/, '');

    return (query.length > 2 ? query + "&" : "?") + (newval ? param + "=" + newval : '');
}

document.addEventListener('submit', function(e) {
  var form = e.target
  toggleStar(form)
  e.preventDefault()
})

// Basic event delegation
document.addEventListener('click', function(e) {
  var loadMoreLink = e.target.closest('.js-load-more')
  if (loadMoreLink) {
    loadMoreRepositories(loadMoreLink)
    e.preventDefault()
  }
})

function loadStargazer(link, name) {
  var container = link.parentElement;
  container.classList.add('loading');

  fetch(link.href).then(function(response) {
    response.text().then(function(text) {
      $(".list-stargazers-" + name).append(text);

      $("#btn-load-stargazers-" + name).addClass("disabled-none");
      

      var ul = document.getElementById("list-stargazers-" + name);
      var lastLi = ul.children[ul.children.length - 1].innerHTML;    

      if (lastLi != "false") {
        $("#btn-load-more-stargazers-" + name).addClass("disabled-show");
        // Check last load more
        var link_more = document.getElementById("btn-load-more-stargazers-" + name);
        var href = link_more.getAttribute("href");
        if(href.indexOf(lastLi) == -1) {
          var newLoadMore = replaceQueryParam("after", lastLi, link_more.getAttribute("href"));
          link_more.setAttribute("href", newLoadMore);
        } else {
          // $("#btn-repo-load-more").addClass("disabled-link disabled-none");
          $("#btn-load-more-stargazers-" + name + " button").addClass("disabled-none");
        }
      }
      

    })
  })
}

function getURLParameter(url, name) {
    return (RegExp(name + '=' + '(.+?)(&|$)').exec(url)||[,null])[1];
}

// Basic event delegation
document.addEventListener('click', function(e) {
  var loadStargazersLink = e.target.closest('.js-load-stargazers')
  var url = loadStargazersLink.getAttribute("href");
  var name = getURLParameter(url, 'name');
  if (loadStargazersLink) {
    loadStargazer(loadStargazersLink, name)
    e.preventDefault()
  }
})


function loadMoreStargazer(link, name) {
  var container = link.parentElement;
  container.classList.add('loading');

  fetch(link.href).then(function(response) {
    response.text().then(function(text) {
      $(".list-stargazers-" + name).append(text);

      var ul = document.getElementById("list-stargazers-" + name);
      var lastLi = ul.children[ul.children.length - 1].innerHTML; 
      
      if (lastLi != "false") {
         // Check last load more
        var href = link.getAttribute("href");
        if(href.indexOf(lastLi) == -1) {
          var newLoadMore = replaceQueryParam("after", lastLi, link.getAttribute("href"));
          link.setAttribute("href", newLoadMore);
        } else {
          // $("#btn-repo-load-more").addClass("disabled-link disabled-none");
          $("#btn-load-more-stargazers-" + name + " button").addClass("disabled-none");
        }
       
      }
      else {
         $("#btn-load-more-stargazers-" + name + " button").addClass("disabled-none");
      }
    })
  })
}

// Basic event delegation
document.addEventListener('click', function(e) {
  var loadMoreStargazersLink = e.target.closest('.js-load-more-stargazers')
  var url = loadMoreStargazersLink.getAttribute("href");
  var name = getURLParameter(url, 'name');
  console.log(name);
  if (loadMoreStargazersLink) {
    loadMoreStargazer(loadMoreStargazersLink, name)
    e.preventDefault()
  }
})

function loadIssues(link, name) {
  var container = link.parentElement;
  container.classList.add('loading');

  fetch(link.href).then(function(response) {
    response.text().then(function(text) {
      $(".list-issues-" + name).append(text);
      $("#btn-load-issues-" + name).addClass("disabled-none");
     

      // Get curror last
      var ul = document.getElementById("list-issues-" + name);
      var lastLi = ul.children[ul.children.length - 1].innerHTML;    
      if (lastLi != "false") {
        // Show button load more issues
         $("#btn-load-more-issues-" + name).addClass("disabled-show");
           // Check last load more
        var link_more = document.getElementById("btn-load-more-issues-" + name);
        var href = link_more.getAttribute("href");

        if(href.indexOf(lastLi) == -1) {
          var newLoadMore = replaceQueryParam("after", lastLi, link_more.getAttribute("href"));
          link_more.setAttribute("href", newLoadMore);
        } else {
          // $("#btn-repo-load-more").addClass("disabled-link disabled-none");
          $("#btn-load-more-issues-" + name + " button").addClass("disabled-none");
        }
      }      

    })
  })
}

// Basic event delegation
document.addEventListener('click', function(e) {
  var loadMoreIssuesLink = e.target.closest('.js-load-issues')
  var url = loadMoreIssuesLink.getAttribute("href");
  var name = getURLParameter(url, 'name');
  console.log(name);
  if (loadMoreIssuesLink) {
    loadIssues(loadMoreIssuesLink, name)
    e.preventDefault()
  }
})


function loadMoreIssues(link, name) {
  var container = link.parentElement;
  container.classList.add('loading');

  fetch(link.href).then(function(response) {
    response.text().then(function(text) {
      $(".list-issues-" + name).append(text);

      var ul = document.getElementById("list-issues-" + name);
      var lastLi = ul.children[ul.children.length - 1].innerHTML;    

      if (lastLi != "false") {
         // Check last load more
          var href = link.getAttribute("href");
          if(href.indexOf(lastLi) == -1) {
            var newLoadMore = replaceQueryParam("after", lastLi, link.getAttribute("href"));
            link.setAttribute("href", newLoadMore);
          } else {
            // $("#btn-repo-load-more").addClass("disabled-link disabled-none");
            $("#btn-load-more-issues-" + name + " button").addClass("disabled-none");
          }
      }
      else {
         $("#btn-load-more-issues-" + name + " button").addClass("disabled-none");
      }
    })
  })
}

// Basic event delegation
document.addEventListener('click', function(e) {
  var loadMoreIssuesLink = e.target.closest('.js-load-more-issues')
  var url = loadMoreIssuesLink.getAttribute("href");
  var name = getURLParameter(url, 'name');
  console.log(name);
  if (loadMoreIssuesLink) {
    loadMoreIssues(loadMoreIssuesLink, name)
    e.preventDefault()
  }
})