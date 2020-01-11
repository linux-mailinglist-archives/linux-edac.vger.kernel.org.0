Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481EB138167
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jan 2020 14:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgAKNGJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Jan 2020 08:06:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52220 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgAKNGJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 11 Jan 2020 08:06:09 -0500
Received: from zn.tnic (p200300EC2F1E140059EC870F21D98201.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1400:59ec:870f:21d9:8201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E4FB1EC085F;
        Sat, 11 Jan 2020 14:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578747967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BYvSwdrZZUXL1ebcYH13oLjjpeCBly4UESLGD5QNBXs=;
        b=O/hmB+8EWlsUFmi5xI6cO2XZ2qbhHJgUKS7HWj7i1PCw+PwhEL9DwTQMg47asDXDVh+stV
        anYjxYAFUMvb6mt0YUyjM8hRbFDRtWKZe5S7F5H3rJ6cBgh0hrkKVB9vIik+x1pgFtQB3z
        66jwk6wTb2fwJC21Xmds++W5RuFNbWk=
Date:   Sat, 11 Jan 2020 14:06:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 1/6] x86/mce: Take action on UCNA/Deferred errors again
Message-ID: <20200111130604.GB23583@zn.tnic>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-2-jschoenh@amazon.de>
 <20200110095004.GD19453@zn.tnic>
 <20200110184533.GB20511@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110184533.GB20511@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 10, 2020 at 10:45:33AM -0800, Luck, Tony wrote:
> That's a tricky question. We have changing behavior (UCNA pages offlined,
> then a few kernel versions stopped doing this, now we are going to start
> doing it again. But is it really a _BUG_ that needs backporting to stable?
> I'm leaning towards "no it isn't".

I think the same, so let's not. We can always backport it later, if it
turns out that it is needed.

> But could perhaps be convinced to change my mind if somebody has a
> good reason for wanting it there.

Yah.

> Is there something to put in the tags to stop this being autoselected
> for backport because it has a Fixes: tag?

I don't think so.

What we could do is write the "Fixes:" tag in free text in the commit
message so that tools don't pick up on it.

I'll reply to the other thing below in a separate mail.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
