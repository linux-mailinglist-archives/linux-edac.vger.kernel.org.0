Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D86276377
	for <lists+linux-edac@lfdr.de>; Thu, 24 Sep 2020 00:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWWC7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 18:02:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:27537 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWWC7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Sep 2020 18:02:59 -0400
IronPort-SDR: Y7ZgzXRxYLa/xUHPJzg/RtzjlDzjt0KaCN7PAkDS7jPdN0SK/Y9U0lTx/Yj1YE9e8BdgQlBsl9
 jNxWZou5ZIvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="160318146"
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="160318146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 15:02:58 -0700
IronPort-SDR: qNh7V87aQ7Xy3N/+6fQlspqXIOsKIvIBhJYVmTuAOINcdBbjGqDUyjgCc88ffU+q7W8Aff/OiX
 W9HV+wVrvF/w==
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="486618606"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 15:02:58 -0700
Date:   Wed, 23 Sep 2020 15:02:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     minyard@acm.org
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20200923220257.GA20839@agluck-desk2.amr.corp.intel.com>
References: <20200923115742.4634-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923115742.4634-1-minyard@acm.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 23, 2020 at 06:57:42AM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If kdump is enabled, the handling of shooting down CPUs does not use the
> RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.
> 
> For normal errors that is fine.  MCEs, however, interrupt all CPUs at
> the same time so they are already running in an NMI, so sending them an
> NMI won't do anything.  The MCE code in wait_for_panic() is set up to
> receive the RESET_VECTOR because it enables irqs, but it won't work on
> the NMI-only case.

MCE and NMI are separate exception types ... so not accurate to say
"already running in an NMI". Better to say somehting like: MCE has higher
priority than NMI so the NMI is blocked until the MCE is over.

> There is already code in place to scan for the NMI callback being ready,
> simply call that from the MCE's wait_for_panic() code so it will pick up
> and handle it if an NMI shootdown is requested.  This required
> propagating the registers down to wait_for_panic().

The code might look a little prettier if you put "regs" at the start
of the argument list instead of at the end. Especially for the functions
that have string message arguments.

> Reported-by: Wu Bo <wubo40@huawei.com>
> Cc: hidehiro.kawai.ez@hitachi.com
> Cc: linfeilong@huawei.com
> Cc: liuzhiqiang26@huawei.com
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Tested-by: Wu Bo <wubo40@huawei.com>
> ---
> Wu Bo found this doing kdumps because the IPMI driver saves panic
> information to the IPMI event log during a panic.  But it was getting
> interrupts at the same time because the other cores had interrupts
> enabled, causing the process to take a long time.
> 
> Having interrupt enabled during a kdump shutdown and while the new kdump
> kernel is running is obviously a bad thing and can cause other problems,
> too.  I think this is the right fix, but I'm not an expert in this code.

I'm also uncertain if this is the best/right approach. Interaction between
NMI, MCE, etc. is something of a rats nest. Perhaps Andy Lutomirksi may
have ideas.

-Tony
