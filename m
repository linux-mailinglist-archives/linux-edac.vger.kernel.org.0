Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DCE562C
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfJYVxj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Oct 2019 17:53:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJYVxi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 25 Oct 2019 17:53:38 -0400
Received: from zn.tnic (p200300EC2F0D3C004597AB7732076DF8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3c00:4597:ab77:3207:6df8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88CEF1EC0CF6;
        Fri, 25 Oct 2019 23:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572040417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1XzEIJ2Aij+O1b/FperTnyAwAtRoYUY3zHWpOIg/zwQ=;
        b=klIBso3/J/ahcYo1mvFm6+oVSDl+1NmdHZlWqCtkLn70/8O3vMkRDRTRRXqHshBb8bJduy
        cZOt2TqblbloRFXf9/1hVT7m1irHgxykhtyA1V+Sei/sxYkOQQNwr/nMM8Qq4XVPTzJ90d
        eRB02idCz+E/HzJrA5X/5AGFbp1cx7M=
Date:   Fri, 25 Oct 2019 23:53:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Message-ID: <20191025215333.GH6483@zn.tnic>
References: <20191025211226.2444-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025211226.2444-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 25, 2019 at 09:13:14PM +0000, Robert Richter wrote:
> The ghes registration and refcount is broken in several ways:

...

> Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
> Fixes: 1e72e673b9d1 ("EDAC/ghes: Fix Use after free in ghes_edac remove path")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>

More staring at the rest later, just to point out that the SOB chain is
wrong: my and James' SOB must be Co-developed-by: or Originally-by: or
so. Or even as freetext in the commit message:

"Based on patches by ... "

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
