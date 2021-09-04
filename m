Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5267400B2D
	for <lists+linux-edac@lfdr.de>; Sat,  4 Sep 2021 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhIDLhf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 4 Sep 2021 07:37:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36694 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhIDLhe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 4 Sep 2021 07:37:34 -0400
Received: from zn.tnic (p200300ec2f1bee0072f9cf00d8ebb3d8.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:ee00:72f9:cf00:d8eb:b3d8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE21A1EC05E9;
        Sat,  4 Sep 2021 13:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630755392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bNz2wO5A10EBoDUwbw7sbTcYANL0Xzq9LCPwpzZpHNw=;
        b=W5Zq+r+m6/GFifoxZCo4ZkmG2c0mX/ffe2Ey6XHiAcci1nxZgyKfM5pcnFR0zEXV2uNaAe
        7Kg27wPmIm5i7kHvTjn7eoJEU4p5R1UGMEVgdHRaX2WyKcoF92cOq4w6qucUFN41A1VvAn
        /um2yHxk6sl7xtwlD/C4vqxF5eN4ooc=
Date:   Sat, 4 Sep 2021 13:36:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Baker <len.baker@gmx.com>
Cc:     Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] EDAC/mc: Prefer strscpy or scnprintf over strcpy
Message-ID: <YTNaOsF3cRpL7065@zn.tnic>
References: <20210903150539.7282-1-len.baker@gmx.com>
 <3a035a3ec4571a622ce640e042f9a119@perches.com>
 <20210904094451.GA2998@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210904094451.GA2998@titan>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Sep 04, 2021 at 01:23:03PM +0200, Len Baker wrote:
> I can remove the macro and add a comment with some explanation.

No, please leave the macro.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
