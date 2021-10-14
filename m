Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C704E42E11F
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhJNSYq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJNSYq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Oct 2021 14:24:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DBBC061570;
        Thu, 14 Oct 2021 11:22:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c720076278dcac58b4415.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:7627:8dca:c58b:4415])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 254D11EC01A8;
        Thu, 14 Oct 2021 20:22:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634235758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hc/czkblm90nyAaSHB84LYcbQ9F8p2MEH3ltwTTSbeM=;
        b=YmRXcxDB85kE+taKi6h2OcamDiviZwlqU1utqYK61z0vV1wy3Y7FpcFAYCPor887fgf2cN
        7Gurp7eC0mOajbDGrn99vbhByWOWZUgTV0flObZIHbfcsZeKlYHag4G7e0PaHUoJIBFTr2
        jUvKzCmAfYYZtPGX3QSrJ6kP7qANvo4=
Date:   Thu, 14 Oct 2021 20:22:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated
 before error simulation
Message-ID: <YWh1bc6Lol65f0RH@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic>
 <78bec0e8-a64a-466c-4245-2386de7db5c9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78bec0e8-a64a-466c-4245-2386de7db5c9@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 11, 2021 at 04:12:14PM -0500, Koralahalli Channabasappa, Smita wrote:
> I do not have the bank number in order to look up the IPID for that bank.
> I couldn't know the bank number because mce-inject files are synchronized
> in a way that once the bank number is written the injection starts.
> Can you please suggest what needs to be done here?
>
> Also, the IPID register is read only from the OS, hence the user provided
> IPID values could be useful for "sw" error injection types. For "hw" error
> injection types we need to read from the registers to determine the IPID
> value.
> 
> Should there be two cases where on a "sw" injection use the user provided
> IPID value whereas on "hw" injection read from registers?

Right, that's a good point. So the way I see it is, we need to decide
what is allowed for sw injection and what for hw injection, wrt to IPID
value.

I think for sw injection, we probably should say that since this is
sw only and its purpose is to test the code only, there should not be
any limitations imposed by the underlying machine. Like using the bank
number, for example.

So what you do now for sw injection:

		if (val && inj_type == SW_INJ)
			m->ipid = val;

should be good enough. User simply sets some IPID value and that value
will be used for the bank which is written when injecting.

Now, for hw injection, you have two cases:

1. The bank is unpopulated so setting the IPID there doesn't make any sense.

2. The bank *is* populated and the respective IPID MSR has a value
describing what that bank is.

And in that case, does it even make sense to set the IPID? I don't think
so because that IP block's type - aka IPID - has been set already by
hardware/firmware.

So the way I see it, it makes no sense whatsoever to set the IPID of a
bank during hw injection.

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
