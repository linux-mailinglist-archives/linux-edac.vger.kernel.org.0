Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA02463C8
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHQJwI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 05:52:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38240 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgHQJwH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Aug 2020 05:52:07 -0400
Received: from zn.tnic (p200300ec2f26be0071e1cf3fa1f5ba15.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:71e1:cf3f:a1f5:ba15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7072E1EC026E;
        Mon, 17 Aug 2020 11:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597657926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7WEhDtOpHgB6ZDw7sEsLsnf2zJDtK9jInhSYuTQntfI=;
        b=BpDbODW6po4EessYTVOW0Y1TD7TOIWqu0denCgIRuqNND/JNRjpQrUilarAnAac1E4byk2
        rvcbx34cf/jdykExec0uG8URTAJ5qvLGgVQ99gCWJx+fR0GZLPKFc9z6qAv5TKnbpMmNXf
        dKcvm+aLyPlZllJ8uEmRFiSFasff43M=
Date:   Mon, 17 Aug 2020 11:53:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     york.sun@nxp.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/1] edac: fsl_ddr_edac: fix expected data message
Message-ID: <20200817095302.GD549@zn.tnic>
References: <20200724111846.24432-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724111846.24432-1-gregor.herburger@ew.tq-group.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jul 24, 2020 at 01:18:46PM +0200, Gregor Herburger wrote:
> In some cases a wrong 'Expected Data' is calculated and reported.

In some cases? Which cases?

You need to expand that sentence with more details as to what the
problem is because I'm not getting any smarter from it.

> When comparing Expected/Captured Data this looks like dual bit errors when
> only a single bit error occurred.
> 
> On my aarch64 machine it prints something similar to this:
> [  311.103794] EDAC FSL_DDR MC0: Faulty Data bit: 36
> [  311.108490] EDAC FSL_DDR MC0: Expected Data / ECC:   0xffffffef_ffffffff / 0x80000059
> [  311.116135] EDAC FSL_DDR MC0: Captured Data / ECC:   0xffffffff_ffffffef / 0x59

Is that output before or after your change?

0xffffffef is with bit 4 XORed and cap_high was -1 before, cap_low is -1
too. The expected data syndrome has bit 31 set?!

Yeah, I'm confused. Please explain the issue in greater detail, try
structuring it this way:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
