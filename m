Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691FA73EC5A
	for <lists+linux-edac@lfdr.de>; Mon, 26 Jun 2023 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFZVBP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZVBM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 17:01:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10812A
        for <linux-edac@vger.kernel.org>; Mon, 26 Jun 2023 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687813270; x=1719349270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WM3nbA/uvPCxbGngo/9f4EodwInsjPe0izPdAUEJodA=;
  b=ixSG8Lg3CQE8MzMt0SL5L7uFjTT1uOpNqAcUcQZGDKEzqUp3PisgPY1J
   rskytvnMpGGqjFrVUwLxByjqN0H5gJ5jr8lVjhKFyWrco7a4BAeoqZ9X6
   ccl+3g1LYj8XFX+7zqyjI5sHoMnKU+z9lmY+lpvgep6+Glagfgz3jd48I
   cDPQM61mtB3wrxbfkeRRB8CZx6mY5scJRQnoiAw0rq8ImwpCFb3qJXNCr
   1aM0XHdc4GI1lb6jArXxogS5IFyYZ6nc2llANdKRJRuQuIScnlogQ4lnF
   8V+NcAXA/gsn9hK+wLVNrUJC+fjcNe37HLx/o2hj9vmHUU5lhgzuyPdt7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="391790848"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="391790848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 14:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781594224"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="781594224"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 14:01:10 -0700
Date:   Mon, 26 Jun 2023 14:01:09 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        aris@redhat.com
Subject: Re: [PATCH v2] mce: prevent concurrent polling of MCE events
Message-ID: <ZJn8lbn5DzV0k+UR@agluck-desk3>
References: <20230626203712.GW4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626203712.GW4090740@cathedrallabs.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 26, 2023 at 04:37:12PM -0400, Aristeu Rozanski wrote:

> This patch fixes this by introducing synchronization during polling only for
> the affected microarchitectures. This can be improved further in the future if
> Intel implements a way to determine which package a certain CPU belongs to.

It is already possible to associate a CPU with a package. The problem
here is knowing which CPUs are sharing which banks.

> --- linus-2.6.orig/arch/x86/kernel/cpu/mce/core.c	2023-06-26 12:37:12.972386600 -0400
> +++ linus-2.6/arch/x86/kernel/cpu/mce/core.c	2023-06-26 12:47:21.895072048 -0400
> @@ -1618,7 +1618,9 @@ static void mce_timer_fn(struct timer_li
>  	iv = __this_cpu_read(mce_next_interval);
>  
>  	if (mce_available(this_cpu_ptr(&cpu_info))) {
> +		bool locked = intel_cmci_poll_lock();

Is mce_timer_fn() used on AMD? I think it is (mcheck_cpu_init() calls
__mcheck_cpu_setup_timer() apparently unconditionally). So this code is
OK if CONFIG_X86_MCE_INTEL=n because that's an empty stub. But with
both CONFIG_X86_MCE_INTEL=y and CONFIG_X86_MCE_AMD=y you'll call this
function on AMD systems.

Or is this OK because this will always return false on AMD?

-Tony
