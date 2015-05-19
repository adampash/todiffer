@DiffViewer = React.createClass
  getInitialState: ->
    {
      v1: @props.versions[@props.first_index],
      v2: @props.versions[@props.last_index],
    }
  # first_version: (version=0) ->
  #   @props.versions[version]
  # last_version: (version) ->
  #   version = (@props.versions.length - 1) unless version?
  #   @props.versions(version)
  render: ->
    text = ""
    if @props.version_count is 1
      text = @state.v1.text
      title = @state.v1.title
    else
      text = differ.parse(@state.v1.text, @state.v2.text)
      title = differ.parse(@state.v1.title, @state.v2.title)
      # text = @props.first_version # diffed w/last version
    `<div>
      <h2>{title}</h2>
      <div dangerouslySetInnerHTML=
        {{
            __html: marked(text, {sanitize: true})
        }}
      />
    </div>`
