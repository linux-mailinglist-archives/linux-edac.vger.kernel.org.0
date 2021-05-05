Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221E1374946
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhEEUY5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 16:24:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33416 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhEEUY5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 16:24:57 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8329320B7178;
        Wed,  5 May 2021 13:23:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8329320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620246240;
        bh=HgToAWSlai+dg6ZDZ8E8wj78AP4ULaEIQiaDSPYsS0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NI7p8ZsrgpQn7alrUpSeVEJYavh95ehboWTqeZQMTLPQOJGk7xzUB4Qme+rEUGhRA
         wSdWCzTiNJueCZKO/Z6Q3kIWR8JfSusTSTXW/A4hAPsiweloAXWpR4Acj08BXDGPR3
         fe2DUw4LzR4BPa18LqhqjjdHrUGeoHlxLyjGzw7E=
Date:   Wed, 5 May 2021 15:23:57 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>, wangglei <wangglei@gmail.com>
Cc:     "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <20210505202357.GC4967@sequoia>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJL1vU6HNBWPKy8g@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2021-05-05 21:45:01, Borislav Petkov wrote:
> Hi Lei,
> 
> On Wed, May 05, 2021 at 07:02:14PM +0000, Lei Wang (DPLAT) wrote:
> > Hi Boris,
> 
> first of all, please do not top-post.
> 
> > We found a corner case in production environment that there are ~500
> > CE errors per second. The SoC otherwise functions just fine. Making
> > printk ratelimited reduced CE error logging to < 20 per second.
> 
> If you want to avoid CE logs flooding dmesg, there's a couple of things
> you can do:
> 
> 1. Use drivers/ras/cec.c
> 
> 2. Do not load EDAC drivers at all since you don't care about the error
> reports, apparently.

Lei, if you don't care about the CE error messages at all, there's
also an edac_mc_log_ce module parameter that can be used to quiet the
message emitted from edac_ce_error():

 https://www.kernel.org/doc/html/latest/admin-guide/ras.html#module-parameters

> 3. Fix the CE source: replace the DIMMs, etc.
> 
> > Though this is just one case so far, we think moving to
> > printk_ratelimited could benefit broader use as well, by helping
> > control the amount of kernel logging.
> 
> No, this will make EDAC driver loading output incomplete when some of
> the messages are omitted due to the ratelimiting. And no, this is not
> going to happen.

Boris, I agree that a more surgical approach is needed than this if Lei
still needs some traces of the CE error messages in the logs. Would it
be any more acceptable to add an edac_mc_printk_ratelimited() macro,
which uses printk_ratelimited(), and then call that new macro from
edac_ce_error()?

If you still don't want those CE errors ratelimited by default, perhaps
a new, non-default mode (2) could be added to the edac_mc_log_ce module
parameter that uses the ratelimited variant?

Tyler

> 
> HTH.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
