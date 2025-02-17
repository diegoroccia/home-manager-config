{
  version = 2;
  console_title_template = "{{if .Root}}(Admin){{end}}{{.PWD}}";
  shell_integration = true;
  disable_notice = true;
  blocks = [
    {
      type = "prompt";
      alignment = "left";
      segments = [{
        type = "session";
        style = "plain";
        foreground = "#BF616A";
        template = "{{ .UserName }} ";
      }
        {
          type = "path";
          style = "plain";
          foreground = "#81A1C1";
          template = "{{ .Path }} ";
          properties = {
            style = "short";
          };
        }];
    }
    {
      type = "prompt";
      alignment = "left";
      segments = [{
        type = "git";
        style = "plain";
        foreground = "#6C6C6C";
        template = "{{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}<#FFAFD7>*</>{{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }} ";
        properties = {
          branch_ahead_icon = "<#88C0D0>⇡ </>";
          branch_behind_icon = "<#88C0D0>⇣ </>";
          branch_icon = "";
          fetch_stash_count = true;
          fetch_status = true;
          fetch_upstream_icon = true;
          github_icon = "";
        };
      }];
    }
    {
      type = "prompt";
      alignment = "left";
      segments = [{
        type = "executiontime";
        style = "plain";
        foreground = "#A3BE8C";
        template = " {{ .FormattedMs }} ";
        properties = {
          style = "austin";
        };
      }];
    }
    {
      type = "prompt";
      alignment = "left";
      segments = [{
        type = "status";
        style = "plain";
        foreground = "#B48EAD";
        foreground_templates = [ "{{ if gt .Code 0 }}#BF616A{{ end }}" ];
        template = "❯ ";
        properties = {
          always_enabled = true;
        };
      }];
      newline = true;
    }
  ];
  tooltips = [{
    type = "aws";
    tips = [ "aws" "zalando-aws-cli" "zaws" ];
    style = "plain";
    foreground = "#FFA400";
    template = " {{.Profile}}";
  }
    {
      type = "kubectl";
      tips = [ "zkubectl" "kubectl" "flux" ];
      style = "plain";
      foreground = "#ebcc34";
      template = " ﴱ {{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}} ";
    }];
  transient_prompt = {
    foreground = "#B48EAD";
    foreground_templates = [ "{{ if gt .Code 0 }}#BF616A{{ end }}" ];
    template = "❯ ";
  };
}
