Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF83F3C96
	for <lists+linux-edac@lfdr.de>; Sat, 21 Aug 2021 23:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhHUVwX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Aug 2021 17:52:23 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58374 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhHUVwX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 21 Aug 2021 17:52:23 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHYtT-00EmKv-4C; Sat, 21 Aug 2021 21:51:11 +0000
Date:   Sat, 21 Aug 2021 21:51:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Jue Wang <juew@google.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        X86-ML <x86@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YSF1T85pnplkm0Xo@zeniv-ca.linux.org.uk>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic>
 <20210820202346.GA1623796@agluck-desk2.amr.corp.intel.com>
 <CA+8MBb+M5JoDGONxZuMHZb8VU4DmG=zsv_0JuBhnzn6T=eSKEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8MBb+M5JoDGONxZuMHZb8VU4DmG=zsv_0JuBhnzn6T=eSKEA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 09:51:41PM -0700, Tony Luck wrote:
> On Fri, Aug 20, 2021 at 1:25 PM Luck, Tony <tony.luck@intel.com> wrote:
> > Probably the same for the two different addresses case ... though I'm
> > not 100% confident about that. There could be some ioctl() that peeks
> > at two parts of a passed in structure, and the user might pass in a
> > structure that spans across a page boundary with both pages poisoned.
> > But that would only hit if the driver code ignored the failure of the
> > first get_user() and blindly tried the second. So I'd count that as a
> > critically bad driver bug.
> 
> Or maybe driver writers are just evil :-(
> 
> for (i = 0; i < len; i++) {
>        tx_wait(10);
>        get_user(dsp56k_host_interface.data.b[1], bin++);
>        get_user(dsp56k_host_interface.data.b[2], bin++);
>        get_user(dsp56k_host_interface.data.b[3], bin++);
> }

Almost any unchecked get_user()/put_user() is a bug.  Fortunately, there's
not a lot of them
<greps>
93 for put_user() and 73 for get_user().  _Some_ of the former variety might
be legitimate, but most should be taken out and shot.

And dsp56k should be taken out and shot, period ;-/  This is far from the
worst in there...
