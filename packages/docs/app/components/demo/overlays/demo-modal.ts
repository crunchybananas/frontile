// BEGIN-SNIPPET demo-overlays.ts
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { later } from '@ember/runloop';

interface DemoModalArgs {}

export default class DemoModal extends Component<DemoModalArgs> {
  @tracked isOpen = false;
  @tracked isLoading = false;
  @tracked size = 'lg';

  @action toggleModal(): void {
    this.isOpen = !this.isOpen;
  }

  @action setSize(size: string): void {
    this.size = size;
  }

  @action save(): void {
    this.isLoading = true;

    later(
      this,
      () => {
        this.isLoading = false;
        this.isOpen = false;
      },
      1000
    );
  }
}
// END-SNIPPET
