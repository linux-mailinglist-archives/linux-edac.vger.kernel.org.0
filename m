Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25D2C12E6
	for <lists+linux-edac@lfdr.de>; Mon, 23 Nov 2020 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbgKWSHP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Nov 2020 13:07:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbgKWSHO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Nov 2020 13:07:14 -0500
Received: from zn.tnic (p200300ec2f0bbc00fb0727400affb1c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bc00:fb07:2740:aff:b1c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AB741EC0528;
        Mon, 23 Nov 2020 19:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606154833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEs5mQQvcD8tVSRySCC+ykee+b35dM0fmdnL/2Hjyyo=;
        b=UIvKRxjceURtInk5ckDLGrh0DBwPF5YKoVfLXE2pXPLFtm4Qh97HNNtknQZVkrBV+BQem+
        KA5nWqOaay57UNvNSYCn3IJveto85T3kd5AJ0EWttHz8aiKFA0QzeHdc16YbNtRlgOwQxH
        4TJj9kyul2p4pWqLulMfTVtMayFr9nA=
Date:   Mon, 23 Nov 2020 19:07:14 +0100
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
Message-ID: <20201123180714.GH15044@zn.tnic>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-3-gabriele.paoloni@intel.com>
 <20201123142746.GC15044@zn.tnic>
 <MN2PR11MB4158162EBECE1AEA80D5EC0288FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
 <20201123171910.GF15044@zn.tnic>
 <MN2PR11MB4158D04F8ABD74C313667CF088FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR11MB4158D04F8ABD74C313667CF088FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 23, 2020 at 05:40:21PM +0000, Paoloni, Gabriele wrote:
> Well it is not the easiest code to decode 😊

Tell me about it - that's decades worth of crap being piled ontop. :-)

> Sure I can add another patch to the set to rename it.

Yeah, only if you really want to - that was more a note-to-self to take
care of it eventually.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
