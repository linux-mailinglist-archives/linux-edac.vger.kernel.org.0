Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0713D2680
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jul 2021 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhGVOkk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 10:40:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:46123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhGVOi5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Jul 2021 10:38:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191941924"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="191941924"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:19:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="462806278"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:19:32 -0700
Date:   Thu, 22 Jul 2021 08:19:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 22, 2021 at 06:54:37AM -0700, Jue Wang wrote:
> This patch assumes the UC error consumed in kernel is always the same UC.
> 
> Yet it's possible two UCs on different pages are consumed in a row.
> The patch below will panic on the 2nd MCE. How can we make the code works
> on multiple UC errors?
> 
> 
> > + int count = ++current->mce_count;
> > +
> > + /* First call, save all the details */
> > + if (count == 1) {
> > + current->mce_addr = m->addr;
> > + current->mce_kflags = m->kflags;
> > + current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> > + current->mce_whole_page = whole_page(m);
> > + current->mce_kill_me.func = func;
> > + }
> > ......
> > + /* Second or later call, make sure page address matches the one from first call */
> > + if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> > + mce_panic("Machine checks to different user pages", m, msg);

The issue is getting the information about the location
of the error from the machine check handler to the "task_work"
function that processes it. Currently there is a single place
to store the address of the error in the task structure:

	current->mce_addr = m->addr;

Plausibly that could be made into an array, indexed by
current->mce_count to save mutiple addresses (perhaps
also need mce_kflags, mce_ripv, etc. to also be arrays).

But I don't want to pre-emptively make such a change without
some data to show that situations arise with multiple errors
to different addresses:
1) Actually occur
2) Would be recovered if we made the change.

The first would be indicated by seeing the:

	"Machine checks to different user pages"

panic. You'd have to code up the change to have arrays
to confirm that would fix the problem.

-Tony
