@Metadata = React.createClass
  render: ->
    site_name = @props.site?.name or ''
    site_id = @props.site?.id
    author_name = @props.author?.name
    author_id = @props.author?.id
    `<div className="metadata">
      <button onClick={this.props.handleDecrement}>-</button>
      <button onClick={this.props.handleIncrement}>+</button>
      <div>{this.props.v1.md5 == this.props.v2.md5 ? 'equal' : 'different'}</div>
      <ul>
        <li>
          Site: <a href={"/sites/" + site_id}>{site_name}</a>
        </li>
        <li>
          Versions: {this.props.version_count}
        </li>
        <li>
          Submitted by: <a href={"/user/" + this.props.submitted_by.id}>{this.props.submitted_by.name}</a>
        </li>
        <li>
          Author: <a href={"/authors/" + author_id}>{author_name}</a>
        </li>
        <li>
          Comparing: Version {this.props.first} :: Version {this.props.last}
        </li>
        <li>
          <a href={this.props.url} target="_blank">Original</a>
        </li>
      </ul>
    </div>`

