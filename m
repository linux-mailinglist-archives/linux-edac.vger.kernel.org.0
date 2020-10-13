Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0453528CCA0
	for <lists+linux-edac@lfdr.de>; Tue, 13 Oct 2020 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgJMLb6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Oct 2020 07:31:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJMLb6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Oct 2020 07:31:58 -0400
Received: from zn.tnic (p200300ec2f0ecc00023049173123656a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:cc00:230:4917:3123:656a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 533331EC0407;
        Tue, 13 Oct 2020 13:31:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602588716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9I4RaOwDoHVHlEbJvk/nT5ibkDIZHATRWwK7VVi/rgs=;
        b=WYJAt2FcJu8mUksVcnc/ijv1WU4Faf5/R+QhN+eFqU47NhGQrQN7zyZils8ObmoBjcO1IJ
        7mIo0oLIinJL2jZpCC9OWxmNx81XZltH6U22EcOHPSnu8x4lYLfyeckjslYk88F4gVq7Yc
        gt5A/lsSrlLiHp0a89eMqRbjdFd1tXA=
Date:   Tue, 13 Oct 2020 13:31:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53
 and A57
Message-ID: <20201013113147.GD28215@zn.tnic>
References: <20200813075721.27981-1-s.hauer@pengutronix.de>
 <20200813075721.27981-2-s.hauer@pengutronix.de>
 <20200826084135.GA22390@zn.tnic>
 <20201013111346.GG11648@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013111346.GG11648@pengutronix.de>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 13, 2020 at 01:13:46PM +0200, Sascha Hauer wrote:
> Have you run checkpatch on a tree with this patch applied? If not, then
> yes, it's undocumented as the docs are added with this patch.

Aha, I'm usually running checkpatch on the patch itself so if this patch
adds it then checkpatch is doing it wrong. Oh well.

> I never heard of such a requirement. How is the length defined? Is it
> only the length of the variable name or is it the length of the name
> including the type? Including the array braces [] or not?

The total textual length.

>  What if a variable shall be initialized with the value of an earlier
> declared variable, do I have to make up variable names with a suitable
> length in that case?

In that case you should order it so that the initialization is correct.

> What if shorter_var_name and even_shorter are of same type, can I
> still write them in a single line?

You simply sort them so that it remains a reversed xmas tree.

> Finally, Is this documented somewhere?

No, would it make any difference if it were?

> I hope that was a joke from you that I didn't understand.

This is the convention that is used in the tip tree and I'm using it in
the EDAC tree too. Just think of it as a subsystem formatting rule.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
