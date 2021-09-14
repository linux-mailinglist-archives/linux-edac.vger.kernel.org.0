Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB02240A927
	for <lists+linux-edac@lfdr.de>; Tue, 14 Sep 2021 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhINI3i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Sep 2021 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhINI3i (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Sep 2021 04:29:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDCC061574;
        Tue, 14 Sep 2021 01:28:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1048004bf380b26d2cf776.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:4bf3:80b2:6d2c:f776])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7699A1EC0464;
        Tue, 14 Sep 2021 10:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631608094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a4eAzcmgT+Cbjjd6VWGKBIiTujYg8WfJzuB6hTCYge0=;
        b=l1T5lQUt6p7TqQ2QYh6YIHTDNZbLx5KQRUA/63x2LTVAnIlUUp3NxdLHluIzr7RKuEZ7S0
        hmW69MX2VECRwla3/KAx73SFgDDjgNCCjeNjQiv0BD65WMV2rI/i1k9dTbvfi2hK65gHGR
        7LqZJqXn2VQhbNah1rz0rWeO1O7H7qY=
Date:   Tue, 14 Sep 2021 10:28:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YUBdGBRyMT0LCm1x@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YT8Y5cBiaD3NpAIi@zn.tnic>
 <YT/IJ9ziLqmtqEPu@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YT/IJ9ziLqmtqEPu@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 13, 2021 at 02:52:39PM -0700, Luck, Tony wrote:
> Also mark queue_task_work() as "noinstr" (as reported kernel test robot
> <lkp@intel.com>)

Yeah, that's not enough - I have a patchset in the works for all this so
I'm going to drop your annotation.

> Cc: <stable@vger.kernel.org>
> Fixes: 5567d11c21a1 ("x86/mce: Send #MC singal from task work")

Ah ok, that one makes sense.

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> > What about a Fixes: tag?
> 
> Added a Fixes tag.
> 
> Also added "noinstr" to queue_task_work() per a kernel robot report.
> 
> Also re-wrote the commit comment (based on questions raised against v2)

Thanks - very much appreciated and it reads really good!

> > I guess backporting this to the respective kernels is predicated upon
> > the existence of those other "places" in the kernel where code assumes
> > the EFAULT was because of a #PF.
> 
> Not really. I don't expect to change any kernel code that just bounces
> off the same machine check a few times. This patch does work best in
> conjunction with patches 2 & 3 (unchanged, not reposted here). But it
> will fix some old issues even without those two.

Ok, got it.

/me queues.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
