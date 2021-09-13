Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C654408824
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbhIMJ0X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Sep 2021 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhIMJ0X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Sep 2021 05:26:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B0C061574;
        Mon, 13 Sep 2021 02:25:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0973004765224e3bd861c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7300:4765:224e:3bd8:61c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C98591EC0521;
        Mon, 13 Sep 2021 11:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631525100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dPlZ7SwE2Bck0JaPAUxS3dOshX7CdpAXQTGsFhy+ZN8=;
        b=CrcQIu9kedVB9sb4JyFABo6gii9pMiXOCa5WgEHeSa+HfSIVmKmOhr1PrBthWgOJsMQi8Q
        WIfU7PTfFMNNHJKhI41PPESZULMA5qNgKzTRcqziplz5wmINqGqGPsxffVUrRiqFrO4uKu
        PcAP0kyAu+n2zR9bOZWqoebweEDwTPE=
Date:   Mon, 13 Sep 2021 11:24:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YT8Y5cBiaD3NpAIi@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818002942.1607544-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 17, 2021 at 05:29:40PM -0700, Tony Luck wrote:
> Recovery action when get_user() triggers a machine check uses the fixup
> path to make get_user() return -EFAULT.  Also queue_task_work() sets up
> so that kill_me_maybe() will be called on return to user mode to send
> a SIGBUS to the current process.
> 
> But there are places in the kernel where the code assumes that this
> EFAULT return was simply because of a page fault. The code takes some
> action to fix that, and then retries the access. This results in a second
> machine check.
> 
> While processing this second machine check queue_task_work() is called
> again. But since this uses the same callback_head structure that was used
> in the first call, the net result is an entry on the current->task_works
> list that points to itself. When task_work_run() is called it loops
> forever in this code:
> 
>         do {
>                 next = work->next;
>                 work->func(work);
>                 work = next;
>                 cond_resched();
>         } while (work);
> 
> Add a counter (current->mce_count) to keep track of repeated machine
> checks before task_work() is called. First machine check saves the address
> information and calls task_work_add(). Subsequent machine checks before
> that task_work call back is executed check that the address is in the
> same page as the first machine check (since the callback will offline
> exactly one page).
> 
> Expected worst case is two machine checks before moving on (e.g. one user
> access with page faults disabled, then a repeat to the same addrsss with
> page faults enabled). Just in case there is some code that loops forever
> enforce a limit of 10.
> 
> Cc: <stable@vger.kernel.org>

What about a Fixes: tag?

I guess backporting this to the respective kernels is predicated upon
the existence of those other "places" in the kernel where code assumes
the EFAULT was because of a #PF.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
