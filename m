Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C428133EDA
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2020 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgAHKGR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jan 2020 05:06:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAHKGQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Jan 2020 05:06:16 -0500
Received: from zn.tnic (p4FED3198.dip0.t-ipconnect.de [79.237.49.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 335B91EC0315;
        Wed,  8 Jan 2020 11:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578477975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HRy92KTbbU70jc0LLnw8pGWEknrWuFHy3eJP7nHa+Fk=;
        b=qWL7A4sqv5HWOIPWSeYhHYjsonqCIVGtM1N0zOa2ySvWNP5L+jB7cDGCfLIkmn6RjncJ7x
        5ws1bYGo7NvXrhW7j0RZleURnOKeHx/nKbTiN6cGsqPxOKiXlCdJb3+1YbyWNduQ1n2XRt
        RIGsM3ERe5ODQmDXtlCVI+lYB9aCaTU=
Date:   Wed, 8 Jan 2020 11:03:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Message-ID: <20200108100356.GA27363@zn.tnic>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de>
 <20200103220328.GF5099@zn.tnic>
 <BN6PR12MB16670832D78F2799730FB95FF83E0@BN6PR12MB1667.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR12MB16670832D78F2799730FB95FF83E0@BN6PR12MB1667.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 08, 2020 at 04:24:33AM +0000, Ghannam, Yazen wrote:
> I've encountered an issue where EDAC didn't load (either due to a
> bug or missing hardware enablement) and the MCE got swallowed by the
> mcelog notifier. The mcelog utility wasn't in use, so there was no
> record of the MCE.

Can you reproduce this using the injector?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
