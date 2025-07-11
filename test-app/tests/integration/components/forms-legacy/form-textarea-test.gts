import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, fillIn, blur, focus, find } from '@ember/test-helpers';
import FormTextarea from '@frontile/forms-legacy/components/form-textarea';
import { fn, array } from '@ember/helper';
import { cell } from 'ember-resources';

module('Integration | Component | @frontile/forms-legacy/FormTextarea', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><FormTextarea @label="Name" /></template>);

    assert.dom('label').hasText('Name');
  });

  test('it renders html attributes', async function (assert) {
    await render(
      <template><FormTextarea @label="Name" name="some-name" data-test-input /></template>
    );

    assert.dom('[data-test-input]').exists();
    assert.dom('[name="some-name"]').exists();
  });

  test('it should have id attr with matching label attr `for`', async function (assert) {
    await render(<template><FormTextarea @label="Comment" data-test-input /></template>);

    const el = find('[data-test-input]') as HTMLInputElement;
    const id = el.getAttribute('id') || '';

    assert.ok(/ember[1-9.]/.test(id), 'should have generated an id');

    assert.dom('[data-test-id="form-field-label"]').hasAttribute('for', id);
  });

  test('it renders yielded block next to input', async function (assert) {
    await render(
      <template>
        <FormTextarea @label="Name" data-test-input>
          <button type="submit">My Button</button>
        </FormTextarea>
      </template>
    );

    assert.dom('[data-test-input] + button').exists();
  });

  test('show value on input, does not mutate value by default', async function (assert) {
    const myInputValue = cell('Josemar');
    await render(
      <template>
        <FormTextarea data-test-input @label="Name" @value={{myInputValue.current}} />
      </template>
    );

    assert.dom('[data-test-input]').hasValue('Josemar');
    await fillIn('[data-test-input]', 'Sam');
    assert.equal(myInputValue.current, 'Josemar', 'should have not mutated the value');
  });

  test('should mutate the value using onInput action', async function (assert) {
    const myInputValue = cell('Josemar');
    await render(
      <template>
        <FormTextarea
          data-test-input
          @label="Name"
          @value={{myInputValue.current}}
          @onInput={{fn (mut myInputValue.current)}}
        />
      </template>
    );

    assert.dom('[data-test-input]').hasValue('Josemar');
    await fillIn('[data-test-input]', 'Sam');
    assert.equal(myInputValue.current, 'Sam', 'should have mutated the value');
  });

  test('show error messages when errors array has items', async function (assert) {
    await render(
      <template>
        <div class="my-container">
          <FormTextarea data-test-input @errors={{array "This field is required"}} @label="Name" />
        </div>
      </template>
    );

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');

    await focus('[data-test-input]');
    await blur('[data-test-input]');

    assert.dom('[data-test-input]').hasAttribute('aria-invalid');
    assert.dom('[data-test-id="form-field-feedback"]').hasText('This field is required');
  });

  test('do not show error messages if errors has no elements', async function (assert) {
    const errors = []
    await render(
      <template>
        <div class="my-container">
          <FormTextarea data-test-input @errors={{errors}} @label="Name" />
        </div>
      </template>
    );

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');

    await focus('[data-test-input]');
    await blur('[data-test-input]');

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');
    assert.dom('[data-test-id="form-field-feedback"]').doesNotExist();
  });

  test('do not show errors if hasError is false even if errors has elements', async function (assert) {
    await render(
      <template>
        <div class="my-container">
          <FormTextarea
            data-test-input
            @errors={{array "This field is required"}}
            @label="Name"
            @hasError={{false}}
          />
        </div>
      </template>
    );

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');

    await focus('[data-test-input]');
    await blur('[data-test-input]');

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');
    assert.dom('[data-test-id="form-field-feedback"]').doesNotExist();
  });

  test('shows error message and adds the aria-invalid only when focus out', async function (assert) {
    await render(
      <template>
        <div class="my-container">
          <FormTextarea
            data-test-input
            @errors={{array "This field is required"}}
            @label="Name"
            @hasError={{true}}
          />
        </div>
      </template>
    );

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');

    await focus('[data-test-input]');
    await blur('[data-test-input]');

    assert.dom('[data-test-input]').hasAttribute('aria-invalid');
    assert.dom('[data-test-id="form-field-feedback"]').hasText('This field is required');
  });

  test('it removes error indication when input is in focus', async function (assert) {
    await render(
      <template>
        <div class="my-container">
          <FormTextarea
            data-test-input
            @label="Name"
            @errors={{array "Some error"}}
            @hasError={{true}}
          />
        </div>
      </template>
    );

    await focus('[data-test-input]');
    await blur('[data-test-input]');

    assert.dom('[data-test-input]').hasAttribute('aria-invalid');

    await focus('[data-test-input]');

    assert.dom('[data-test-input]').doesNotHaveAttribute('aria-invalid');
  });

  test('always show error messages when hasSubmitted is true', async function (assert) {
    await render(
      <template>
        <div class="my-container">
          <FormTextarea
            @hasSubmitted={{true}}
            data-test-input
            @errors={{array "This field is required"}}
            @label="Name"
          />
        </div>
      </template>
    );

    assert.dom('[data-test-input]').hasAttribute('aria-invalid');
    assert.dom('[data-test-id="form-field-feedback"]').hasText('This field is required');
  });

  test('always show error messages when showError is true', async function (assert) {
    await render(
      <template>
        <div class="my-container">
          <FormTextarea
            @showError={{true}}
            data-test-input
            @errors={{array "This field is required"}}
            @label="Name"
          />
        </div>
      </template>
    );

    assert.dom('[data-test-input]').hasAttribute('aria-invalid');
    assert.dom('[data-test-id="form-field-feedback"]').hasText('This field is required');
  });

  test('it triggers actions for onFocusIn, onFocusOut and onChange', async function (assert) {
    const calls: string[] = [];

    const onFocusIn = () => {
      calls.push('onFocusIn');
    };

    const onFocusOut = () => {
      calls.push('onFocusOut');
    };

    const onChange = () => {
      calls.push('onChange');
    };

    await render(
      <template>
        <FormTextarea
          data-test-input
          @onFocusIn={{onFocusIn}}
          @onFocusOut={{onFocusOut}}
          @onChange={{onChange}}
        />
      </template>
    );

    await focus('[data-test-input]');
    await blur('[data-test-input]');
    await fillIn('[data-test-input]', 'Josemar'); // This causes focusIn to trigger as well.
    assert.ok(calls.includes('onFocusIn'));
    assert.ok(calls.includes('onFocusOut'));
    assert.ok(calls.includes('onFocusIn'));
    assert.ok(calls.includes('onChange'));
  });

  test('it adds container class from @containerClass arg', async function (assert) {
    await render(<template><FormTextarea @containerClass="my-container-class" /></template>);

    assert.dom('.my-container-class').exists();
  });
});
