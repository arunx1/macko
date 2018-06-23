import {Directive, HostBinding} from '@angular/core';

@Directive({
  selector: 'wm-layout-content'
})
export class LayoutContentDirective {

  @HostBinding('class') classes = 'wmHolyGrailBody';

  constructor() {
  }

}