@Articles = React.createClass
  getInitialState: ->
    articles: @props.data
  getDefaultProps: ->
    articles: []
  render: ->
    React.DOM.div
      className: "articles-page"
      React.DOM.div
        className: "row"
        for article in @state.articles
          React.createElement Article, key: article.id, article: article
