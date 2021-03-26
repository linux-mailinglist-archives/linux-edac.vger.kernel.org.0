Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94A34B243
	for <lists+linux-edac@lfdr.de>; Fri, 26 Mar 2021 23:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZWnS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Mar 2021 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhCZWnR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Mar 2021 18:43:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D92C0613AA;
        Fri, 26 Mar 2021 15:43:16 -0700 (PDT)
Received: from zn.tnic (p200300ec2f075f009ccde034de5c142d.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:5f00:9ccd:e034:de5c:142d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE2E01EC0513;
        Fri, 26 Mar 2021 23:43:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616798594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KDXcvgtG0h83c1r3w5F4A7Z5EVH9x/tB4a4LIq1DDBo=;
        b=fTwGM6kvZtMJ1IbJUYe6rAFQ2lleiR2MHmBQRUY33SUeJVMPUwOCj/vTkO6kgUghH/DRjl
        w5IBIBotWb5lYjhixoZED/DDoVXPCbkvGnnAXRc2kWcKiGWLrWDvavPhrflA8biCQMEySB
        9bwybzp7wb4ogFIAWm+1iDwS6iWErxk=
Date:   Fri, 26 Mar 2021 23:43:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     William Roche <william.roche@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
Message-ID: <20210326224310.GL25229@zn.tnic>
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
 <20210326190242.GI25229@zn.tnic>
 <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 26, 2021 at 11:24:43PM +0100, William Roche wrote:
> What we want is to make cec_add_elem() to return !0 value only
> when the given pfn triggered an action, so that its callers should
> log the error.

No, this is not what the CEC does - it collects those errors and when it
reaches the threshold for any pfn, it offlines the corresponding page. I
know, the comment above talks about:

  * That error event entry causes cec_add_elem() to return !0 value and thus
  * signal to its callers to log the error.

but it doesn't do that. Frankly, I don't see the point of logging the
error - it already says

	pr_err("Soft-offlining pfn: 0x%llx\n", pfn);

which pfn it has offlined. And that is probably only mildly interesting
to people - so what, 4K got offlined, servers have so much memory
nowadays.

The only moment one should start worrying is if one gets those pretty
often but then you're probably better off simply scheduling maintenance
and replacing the faulty DIMM - problem solved.

> What I'm expecting from ras_cec is to "hide" CEs until they reach the
> action threshold where an action is tried against the impacted PFN,

That it does.

> and it's now the time to log the error with the entire notifiers
> chain.

And I'm not sure why we'd want to do that. It simply offlines the page.

But maybe you could explain what you're trying to achieve...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
