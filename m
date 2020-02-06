Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA50154476
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2020 14:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBFNEF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Feb 2020 08:04:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgBFNEF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Feb 2020 08:04:05 -0500
Received: from zn.tnic (p200300EC2F0B4B00F16B0FD9F8D3445C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:f16b:fd9:f8d3:445c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9191D1EC0C99;
        Thu,  6 Feb 2020 14:04:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580994243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jNRDagDrRXUl7qpfZYRSxpBc7LLhg9JtbpshSqi/CdA=;
        b=lxM1UwofXjFQ5hlb5iIvGOJ6D3m30qvc6zo2mj8HcgcGZXu1ZZ9TKGt7sFXprhMqpA3hL0
        fM9AxPqNXgXYKSvXTp1w+bqyccKT5kymlMCXQ0HbNoPyBw5NOA9Vs1lmg9WTrOVad4Geew
        haXFydqMREm48NofAm9mXQF18B06MsA=
Date:   Thu, 6 Feb 2020 14:03:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
Message-ID: <20200206130358.GD9741@zn.tnic>
References: <20200205125831.20430-1-prarit@redhat.com>
 <20200206110811.GC9741@zn.tnic>
 <1f3f5f54-eb31-1e2a-27be-7ed4cb3dc2d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f3f5f54-eb31-1e2a-27be-7ed4cb3dc2d3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 06, 2020 at 07:53:34AM -0500, Prarit Bhargava wrote:
> Yeah :/  I couldn't think of a better one.  Maybe "Block spurious corrected
> errors on some Intel processors"?  Any other suggestion?

"Do not log ..."

> Alexander, cc'd, is being hit by this in the wild.

Do say that in the commit message.

> >> Signed-off-by: Alexander Krupp <centos@akr.yagii.de>
> > 
> > What's that Signed-off-by: tag supposed to mean?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You missed this one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
