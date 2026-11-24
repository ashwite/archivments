require 'psych'

module CIBridge
  class Unsupported < StandardError; end

  ACTIONS = {
    'actions/checkout@v4' => %w[uses],
    'actions/setup-node@v4' => %w[uses with]
  }.freeze

  def self.convert(source)
    # Psych implements YAML 1.1, which treats an unquoted "on" as a boolean.
    source = source.sub(/^on(?=:)/, '"on"')
    workflow = Psych.safe_load(source, aliases: false)
    check_keys(workflow, %w[name on jobs], 'workflow')
    unless ['push', ['push'], { 'push' => nil }].include?(workflow['on'])
      raise Unsupported, 'Only an unfiltered push trigger is supported'
    end

    jobs = workflow['jobs']
    raise Unsupported, 'Expected at least one job' unless jobs.is_a?(Hash) && !jobs.empty?

    output = { 'workflow' => { 'rules' => [{ 'if' => '$CI_PIPELINE_SOURCE == "push"' }] } }
    jobs.each do |id, job|
      unless id.is_a?(String) && id.match?(/\A[a-zA-Z][a-zA-Z0-9_-]*\z/)
        raise Unsupported, "Invalid job ID: #{id.inspect}"
      end
      output["gha_#{id}"] = convert_job(job, id)
    end
    Psych.dump(output)
  end

  def self.convert_job(job, id)
    check_keys(job, %w[name runs-on steps], "job #{id}")
    raise Unsupported, "#{id}: only ubuntu-latest is supported" unless job['runs-on'] == 'ubuntu-latest'

    steps = job['steps']
    unless steps.is_a?(Array) && steps.length >= 3
      raise Unsupported, "#{id}: expected checkout, Node setup and at least one run step"
    end

    checkout, setup, *commands = steps
    [checkout, setup].zip(ACTIONS).each do |step, (action, keys)|
      check_keys(step, keys + ['name'], id)
      raise Unsupported, "#{id}: expected #{action}" unless step['uses'] == action
    end
    check_keys(setup['with'], ['node-version'], id)
    version = setup['with']['node-version'].to_s
    unless version.match?(/\A[1-9]\d*(?:\.\d+){0,2}\z/)
      raise Unsupported, "#{id}: use a numeric Node version"
    end

    script = commands.map do |step|
      check_keys(step, %w[name run], id)
      command = step['run']
      unless command.is_a?(String) && !command.strip.empty? && !command.include?('${{')
        raise Unsupported, "#{id}: expected a shell command without GitHub expressions"
      end
      # GitHub runs each step in a fresh shell. Keep shell state local to each step.
      "(\nset -e\n#{command.chomp}\n)"
    end
    { 'image' => "node:#{version}", 'script' => script }
  end

  def self.check_keys(value, allowed, location)
    unless value.is_a?(Hash) && (value.keys - allowed).empty?
      raise Unsupported, "#{location}: expected a mapping with only #{allowed.join(', ')}"
    end
  end
  private_class_method :convert_job, :check_keys
end
