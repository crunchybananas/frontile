import { LinkTo } from '@ember/routing';
import type { TOC } from '@ember/component/template-only';

const Navigation: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex flex-col mb-6" ...attributes>
    <div class="flex overflow-x-auto whitespace-nowrap">
      <LinkTo @route="index" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Home
      </LinkTo>
      <LinkTo @route="buttons" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Buttons
      </LinkTo>
      <LinkTo @route="core" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Core
      </LinkTo>
      <LinkTo @route="forms" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Forms
      </LinkTo>
      <LinkTo @route="forms-legacy" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Forms (Legacy)
      </LinkTo>
      <LinkTo @route="notifications" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Notifications
      </LinkTo>
      <LinkTo @route="overlays" @activeClass="border-primary border-b-4" class="px-2 py-2">
        Overlays
      </LinkTo>
    </div>
  </div>
</template>;

export default Navigation;
