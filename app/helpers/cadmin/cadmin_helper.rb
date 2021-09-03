module Cadmin::CadminHelper
  #stimulus conf
  def cadmin_stimulus_include_tags
    safe_join [
      javascript_include_tag("stimulus/libraries/es-module-shims", type: "module"),
      tag.script(type: "importmap-shim", src: asset_path("cadmin/importmap.json")),
      javascript_include_tag("stimulus/libraries/stimulus", type: "module-shim"),
      javascript_include_tag("stimulus/loaders/autoloader", type: "module-shim")
    ], "\n"
  end
end
