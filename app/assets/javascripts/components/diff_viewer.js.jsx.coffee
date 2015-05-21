@DiffViewer = React.createClass
  getInitialState: ->
    text = ""
    v1 = @props.versions[@props.first_index]
    v2 = @props.versions[@props.last_index]
    {
      v1: v1
      v2: v2
      first_index: @props.first_index
      last_index: @props.last_index
      text: @calculateDiff(v1.text, v2.text)
      title: @calculateDiff(v1.title, v2.title, false)
    }

  calculateDiff: (text1, text2) ->
    if @props.version_count is 1
      text = marked text1
    else
      dmp = new diff_match_patch()
      dmp.Diff_EditCost = 15
      text1 = marked text1
      text2 = marked text2
      d = dmp.diff_main(text1, text2)
      # dmp.diff_cleanupSemantic(d)
      dmp.diff_cleanupEfficiency(d)
      text = dmp.diff_prettyHtml(d)
      # decodeHTML text
      # text = $('<textarea />').html(text).text()

  handleIncrement: ->
    new_last_index = Math.min(@props.version_count-1, @state.last_index + 1)
    v2 = @props.versions[new_last_index]
    @setState(
      v2: v2
      last_index: new_last_index
      text: @calculateDiff(@state.v1.text, v2.text)
      title: @calculateDiff(@state.v1.title, v2.title)
    )
  handleDecrement: ->
    new_last_index = Math.max(0, @state.last_index - 1)
    v2 = @props.versions[new_last_index]
    @setState(
      v2: v2
      last_index: new_last_index
      text: @calculateDiff(@state.v1.text, v2.text)
      title: @calculateDiff(@state.v1.title, v2.title)
    )
  render: ->
    `<div>
      <Metadata
        version_count={this.props.version_count}
        submitted_by={this.props.submitted_by}
        first={this.state.first_index + 1}
        last={this.state.last_index + 1}
        site={this.props.site}
        handleIncrement={this.handleIncrement}
        handleDecrement={this.handleDecrement}
        v1={this.state.v1}
        v2={this.state.v2}
      />
      <div className="text_view">
        <h2 dangerouslySetInnerHTML=
          {{
            __html: this.state.title
          }}
        />
        <div dangerouslySetInnerHTML=
          {{
              __html: this.state.text
          }}
        />
      </div>
      <div className="tiny_text">
        <h2 dangerouslySetInnerHTML=
          {{
            __html: this.state.title
          }}
        />
        <div dangerouslySetInnerHTML=
          {{
              __html: this.state.text
          }}
        />
      </div>
    </div>`
