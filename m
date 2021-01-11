Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52932F229E
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbhAKWVk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 17:21:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:45580 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbhAKWVk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Jan 2021 17:21:40 -0500
IronPort-SDR: pHPw3qYSbVQ5yv0uGWaWMjyUL4ajqTedgpjq2n3TlqoLFaqgnuH1r4nQJRtRcl/lIdwDI9cRwr
 FzRIyUfRdUDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="178040007"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="178040007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:20:59 -0800
IronPort-SDR: 6pIQeWH++WIe5oa7r6R4Yn0mC8sPjVDU2XZ0A2/jSZOf5nG9czsXeUsatRR7hFe9qglLiP6g72
 UUxZF1tWmcUA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381170169"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:20:58 -0800
Date:   Mon, 11 Jan 2021 14:20:57 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-2-tony.luck@intel.com>
 <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 11, 2021 at 02:11:56PM -0800, Andy Lutomirski wrote:
> 
> > On Jan 11, 2021, at 1:45 PM, Tony Luck <tony.luck@intel.com> wrote:
> > 
> > ﻿Recovery action when get_user() triggers a machine check uses the fixup
> > path to make get_user() return -EFAULT.  Also queue_task_work() sets up
> > so that kill_me_maybe() will be called on return to user mode to send a
> > SIGBUS to the current process.
> > 
> > But there are places in the kernel where the code assumes that this
> > EFAULT return was simply because of a page fault. The code takes some
> > action to fix that, and then retries the access. This results in a second
> > machine check.
> > 
> > While processing this second machine check queue_task_work() is called
> > again. But since this uses the same callback_head structure that
> > was used in the first call, the net result is an entry on the
> > current->task_works list that points to itself.
> 
> Is this happening in pagefault_disable context or normal sleepable fault context?  If the latter, maybe we should reconsider finding a way for the machine check code to do its work inline instead of deferring it.

The first machine check is in pagefault_disable() context.

static int get_futex_value_locked(u32 *dest, u32 __user *from)
{
        int ret;

        pagefault_disable();
        ret = __get_user(*dest, from);
        pagefault_enable();

        return (ret == -ENXIO) ? ret : ret ? -EFAULT : 0;
}

-Tony
