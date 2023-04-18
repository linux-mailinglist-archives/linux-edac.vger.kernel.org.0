Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D943F6E6C05
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 20:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjDRSYC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjDRSYB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 14:24:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C2976BE;
        Tue, 18 Apr 2023 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681842240; x=1713378240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pRPyD6+WTQL2wAAqK/kit61fm9+alLRGx6xYjjpFuI8=;
  b=cYNXaWxpdW2wgI+5X2DytRRxLMBxS7eQYhcYDyh7+l7okwN0DZT+SQVe
   ikSgCoY5FkCVMnhHMPo8F/dwVPTkA4wUwz3E2M2wbbaOoumliIfl9hYEk
   s8pKSRqoC66dwr0UIlG7IA6RWnlCsJSYejygcC9alUL+7UrnCiy8JawNg
   ovpvZjM5tyeSxbxP45ANCu8LcpYezqollpAOOL/scFEt4SLgDNUEJ6bUx
   FAgTn9edmJCmDa5ocsrVIYdQytvxChsrBCTRwsOmTc9wb4KaiHCvK8P5z
   grqW6t/KUEUytAj7mcIne05zWX/s2ZfmQSSCN2cgPw6LTiWO2Uvm47hw/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325587922"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="325587922"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 11:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684696494"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="684696494"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 11:24:00 -0700
Date:   Tue, 18 Apr 2023 11:23:58 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Check that memory address is usable for recovery
Message-ID: <ZD7gPkfWQeEeEfBe@agluck-desk3.sc.intel.com>
References: <20230322005131.174499-1-tony.luck@intel.com>
 <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
 <ZD7TBZex278dSYmc@agluck-desk3.sc.intel.com>
 <5f833d37-e961-73c4-3629-74884e8b6c59@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f833d37-e961-73c4-3629-74884e8b6c59@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 18, 2023 at 01:51:37PM -0400, Yazen Ghannam wrote:
> I agree. And I think all these checks should be baked into the severity.
> We'll need additional, fine-grained severity levels though.
> 
> The "m.cs" and "m.kflags" checks could also be baked in.
> 
> Instead of just one AR severity:
> 	...
> 	MCE_AR_SEVERITY,
> 	MCE_PANIC_SEVERITY,
> 
> replace it with specific cases:
> 	...
> 	MCE_AR_USER_RECOV,
> 	MCE_AR_USER_KILL,
> 	MCE_AR_KERNEL_COPYIN,
> 	MCE_AR_KERNEL_RECOV,
> 	MCE_PANIC_SEVERITY,
> 
> Then the #MC handler can look like this:
> 
> 	if (worst < MCE_AR_USER_RECOV)
> 		goto out;
> 
> 	if (severity == MCE_AR_USER_RECOV)
> 		queue_task_work(&m, msg, kill_me_maybe);
> 
> 	if (severity == MCE_AR_USER_KILL)
> 		force_sig(SIGBUS);
> 
> 	if (severity == MCE_AR_KERNEL_COPYIN)
> 		queue_task_work(&m, msg, kill_me_never);
> 	
> 	if (severity == MCE_AR_KERNEL_RECOV) {
> 		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
> 			mce_panic("Failed kernel mode recovery");
> 	}
> 
> I can take a shot at this if it seems reasonable.

That looks much cleaner. There may be some extra MCE_AR_KERNEL* options
in the future (I'd like someday to address COPYOUT when the corrupt
kernel data is in the page cache). But I don't think the number of cases
is going to explode into dozens of cases.

> What do you think?

Brave person ... you are going to have to tinker with
arch/x86/kernel/cpu/mce/severity.c !  Good luck.

-Tony
