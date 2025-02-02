{ pkgs, ... }:

{
  home.packages = with pkgs; [
    devenv
  ];

  editorconfig = {
    enable = true;

    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        max_line_width = 78;
        indent_style = "space";
        indent_size = 4;
      };
    };
  };

  imports = [
    ./git
    ./python
    ./javascript
    ./java
  ];

}
