require 'minitest/autorun'
require_relative '../lib/ci_bridge'

class CIBridgeTest < Minitest::Test
  SOURCE = File.read(File.expand_path('../.github/workflows/node-example.yml', __dir__))
  EXAMPLE = File.read(File.expand_path('../examples/gitlab-node.yml', __dir__))

  def test_converts_node_workflow
    result = Psych.safe_load(CIBridge.convert(SOURCE))
    assert_equal [{ 'if' => '$CI_PIPELINE_SOURCE == "push"' }], result.fetch('workflow').fetch('rules')
    job = result.fetch('gha_node')
    assert_equal 'node:24', job.fetch('image')
    assert_equal %w[ci test run\ build].map { |task| "(\nset -e\nnpm --prefix examples/node #{task}\n)" }, job.fetch('script')
    assert_equal Psych.safe_load(EXAMPLE), result
  end

  def test_rejects_unsupported_trigger
    assert_raises(CIBridge::Unsupported) { CIBridge.convert(SOURCE.sub('on: push', 'on: pull_request')) }
  end

  def test_rejects_unknown_actions
    assert_raises(CIBridge::Unsupported) { CIBridge.convert(SOURCE.sub('actions/checkout@v4', 'other/action@v1')) }
  end

  def test_rejects_expression
    source = SOURCE.sub('npm --prefix examples/node test', 'echo ${{ github.actor }}')
    assert_raises(CIBridge::Unsupported) { CIBridge.convert(source) }
  end

  def test_rejects_extra_job_options
    source = SOURCE.sub('    steps:', "    timeout-minutes: 15\n    steps:")
    assert_raises(CIBridge::Unsupported) { CIBridge.convert(source) }
  end
end
