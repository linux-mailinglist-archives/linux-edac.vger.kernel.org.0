Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22982BB182
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgKTRdp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 12:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgKTRdp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Nov 2020 12:33:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16912C0613CF;
        Fri, 20 Nov 2020 09:33:45 -0800 (PST)
Received: from zn.tnic (p200300ec2f11ba0074b4ba83d21d5a9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:ba00:74b4:ba83:d21d:5a9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAC031EC047E;
        Fri, 20 Nov 2020 18:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605893623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7F9wI7CLFPCOZwx9Gq9w3Uf3TTwIQ/yoyoiY54mFMwc=;
        b=eoSRNg9f849ehHv3xGJYKPUwgqQzvgHmW7lKHsCIFqrfDmNeUkmPVAFCScVoXap8S9wcHN
        MZXugY1CfEtoa20sZ9IsRmILPzCdAoaqry1lgq5ZZAeC4rVUsXXFkcTCncO/V034l+TGaC
        8GfrS7IGDONOtL5YFMq22/w5zjXjg4c=
Date:   Fri, 20 Nov 2020 18:33:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paoloni, Gabriele" <gabriele.paoloni@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
Subject: Re: [PATCH 1/4] x86/mce: do not overwrite no_way_out if mce_end()
 fails
Message-ID: <20201120173342.GF712@zn.tnic>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-2-gabriele.paoloni@intel.com>
 <20201120170737.GD712@zn.tnic>
 <MN2PR11MB4158BE8B738CF6F6BF9B850D88FF0@MN2PR11MB4158.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR11MB4158BE8B738CF6F6BF9B850D88FF0@MN2PR11MB4158.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 20, 2020 at 05:31:32PM +0000, Paoloni, Gabriele wrote:
> I mean that on this CPU thread at this point mce_start() already cached
> global_nwo and hence could accumulate fatal severities of other CPUs.
> 
> Now here if mce_end() fails we only consider the local 'worst' severity
> and we overwrite those already cached.

Yap, we're on the same page. :)

> If ok I will fix the grammar and rewrite this code in v2.

Sure, lemme go through the rest first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
