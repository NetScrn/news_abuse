@Article = React.createClass
  render: ->
    React.DOM.a
      className: 'article-link col-xs-12 col-sm-12 col-md-12',
      href: 'articles/' + @props.article.id
      React.DOM.article null,
        React.DOM.h3 null,
          @props.article.title
        React.DOM.small null,
          @props.article.description
