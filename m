Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3456E6AEF
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 19:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDRR1z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDRR1o (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 13:27:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E9B768;
        Tue, 18 Apr 2023 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681838855; x=1713374855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXgDRy7QEJxBTFnmKuyXp+5XXVFQ7tDgBlizVK+nwUo=;
  b=j9UqY3v7p6N2pQfWwuI+ZeOQdtUTTVmnGCzuNl8PYuO7BTquzmRjCzEZ
   ievHX9nT4dsES8T/Oy6VqlL+WnqUTTc2KhcigTudECvkn+AKXV5t9wds4
   pXQFa4o/zvCWyBMVHxdKPvakKzifR6AvreB7d3e6lel78EPoPU9aA4ipj
   cYG6aQ5/X1ltgbSNWNjHZNSh5bMeu+4ntOyiiyKYlqu3ypvVSbG7uua1M
   RHEav/e0KOY0OeOAydkvxjvOz+X/aFr3jpam3EBM1rLg6TkQASbEJjrxx
   /Bb0RMTTEGX4cuG2WQNaNYPCcKRhKu0I9H6xZs3vcCrqEkS/F8mc6gd6s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="347993626"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="347993626"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684665437"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="684665437"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:27:34 -0700
Date:   Tue, 18 Apr 2023 10:27:33 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Check that memory address is usable for recovery
Message-ID: <ZD7TBZex278dSYmc@agluck-desk3.sc.intel.com>
References: <20230322005131.174499-1-tony.luck@intel.com>
 <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 18, 2023 at 12:41:17PM -0400, Yazen Ghannam wrote:
> On 3/21/23 20:51, Tony Luck wrote:
> > uc_decode_notifier() includes a check that "struct mce"
> > contains a valid address for recovery. But the machine
> > check recovery code does not include a similar check.
> > 
> > Use mce_usable_address() to check that there is a valid
> > address.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/kernel/cpu/mce/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 2eec60f50057..fa28b3f7d945 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -1533,7 +1533,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
> >  		/* If this triggers there is no way to recover. Die hard. */
> >  		BUG_ON(!on_thread_stack() || !user_mode(regs));
> >  
> > -		if (kill_current_task)
> > +		if (kill_current_task || !mce_usable_address(&m))
> >  			queue_task_work(&m, msg, kill_me_now);
> >  		else
> >  			queue_task_work(&m, msg, kill_me_maybe);
> 
> I think it should be like this:
> 
> 	if (mce_usable_address(&m))
> 		queue_task_work(&m, msg, kill_me_maybe);
> 	else
> 		queue_task_work(&m, msg, kill_me_now);
> 
> A usable address should always go through memory_failure() so that the page is
> marked as poison. If !RIPV, then memory_failure() will get the MF_MUST_KILL
> flag and try to kill all processes after the page is poisoned.
> 
> I had a similar patch a while back:
> https://lore.kernel.org/linux-edac/20210504174712.27675-3-Yazen.Ghannam@amd.com/
> 
> We could also get rid of kill_me_now() like you had suggested.

Can we also get rid of "kill_current_task"? It is only set when there is
no valid return address:

        if (!(m.mcgstatus & MCG_STATUS_RIPV))
                kill_current_task = 1;

kill_me_maybe() does an equivalent check:

	if (!p->mce_ripv)
                flags |= MF_MUST_KILL;

Which only leaves this check to resolve in some way:

        if (worst != MCE_AR_SEVERITY && !kill_current_task)
                goto out;

-Tony
