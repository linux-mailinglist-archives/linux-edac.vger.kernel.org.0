Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56E2C11C1
	for <lists+linux-edac@lfdr.de>; Mon, 23 Nov 2020 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgKWRTQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Nov 2020 12:19:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45662 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKWRTQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Nov 2020 12:19:16 -0500
Received: from zn.tnic (p200300ec2f0bbc0000a4f4bc59f4c3b0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bc00:a4:f4bc:59f4:c3b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 586081EC0494;
        Mon, 23 Nov 2020 18:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606151955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yr/jqD5fGpdWOH43HvL0x8EwPmEVGpFEdRBXSVITnNc=;
        b=Y5kF7fvOhnFOMbeTRslgjgL9QqkHIOR2Vu5J575ZCprq2gYgfezlW7hW1SFAkWAOI4vufK
        AZaTWJT9ub9i25+ikbty5oAJ2vQTMhg2QNj9HyJds4O9UoH3V33g1D3NvxnRSTLDN3ageY
        dl/cD5956kfrcGKyoJpUj/9c5eF71w8=
Date:   Mon, 23 Nov 2020 18:19:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paoloni, Gabriele" <gabriele.paoloni@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
Subject: Re: [PATCH 2/4] x86/mce: move the mce_panic() call and kill_it
 assignments at the right places
Message-ID: <20201123171910.GF15044@zn.tnic>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-3-gabriele.paoloni@intel.com>
 <20201123142746.GC15044@zn.tnic>
 <MN2PR11MB4158162EBECE1AEA80D5EC0288FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR11MB4158162EBECE1AEA80D5EC0288FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 23, 2020 at 05:06:31PM +0000, Paoloni, Gabriele wrote:
> From my understanding no_way_out and kill_it are different in principles:
> no_way_out is telling that an error occurred 'somewhere' in some CPU bank
> that requires the system to panic (e.g. PCC=1); kill_it is saying that the execution
> cannot be restarted where it left for the local CPU and hence we need to find
> an alternative solution as part of the recovery action. In practice it seems to
> me that kill_it is used to replace kill_me_maybe with kill_me_now in case
> the exception happened in user mode.

Bah, I got confused, sorry about that - you're right.

Btw, that kill_it should probably be called "kill_current_task" or so to
make it more clear.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
