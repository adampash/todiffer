@Metadata = React.createClass
  render: ->
    site_name = @props.site?.name or ''
    `<div className="metadata">
      <button onClick={this.props.handleDecrement}>-</button>
      <button onClick={this.props.handleIncrement}>+</button>
      <div>{this.props.v1.md5 == this.props.v2.md5 ? 'equal' : 'different'}</div>
      <ul>
        <li>
          Site: {site_name}
        </li>
        <li>
          Versions: {this.props.version_count}
        </li>
        <li>
          Submitted by: <a href={"/user/" + this.props.submitted_by.id}>{this.props.submitted_by.name}</a>
        </li>
        <li>
          Author: {this.props.author ? this.props.author.name : ''}
        </li>
        <li>
          Comparing: Version {this.props.first} :: Version {this.props.last}
        </li>
        <li>
          <a href={this.props.url} target="_blank">Original</a>
        </li>
      </ul>
    </div>`

