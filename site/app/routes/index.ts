import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';
import RouterService from '@ember/routing/router-service';
import * as buttons from '@frontile/buttons';

export default class IndexRoute extends Route {
  @service router!: RouterService;

  redirect(): void {
    this.router.replaceWith('docs');
  }

  // Embroider's tree shaking is removing pkg main entry point as was not used,
  // but it is used in template imports
  something(): object {
    return {
      buttons
    };
  }
}
