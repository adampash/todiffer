@DiffViewer = React.createClass
  render: ->
    # <h2>{@props.title}</h2>
    `<div>
      <h2>{this.props.title}</h2>
      <div>{this.props.text}</div>
    </div>`
