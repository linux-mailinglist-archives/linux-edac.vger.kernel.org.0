Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF05EF2CDA
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKGKxR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 05:53:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48532 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKGKxQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 05:53:16 -0500
Received: from zn.tnic (p200300EC2F0EAD00D550E8D60855E7CD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:d550:e8d6:855:e7cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66C821EC09A3;
        Thu,  7 Nov 2019 11:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573123995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1Q+VyZD3LJu0YtwqTTs/qZamw+Jc53jZHHOGHzHlKIg=;
        b=gZ/rBTwSpHeiaZMApeke0gJtcetXESaheIlHnpcYNskpjZ1HtQq/1xcQyyShHan/8tD8bo
        LT9U8v77yk9Ka9doLx+x7NvUkeJmFYBczG/xzSYlwN6TbLvEf50tgW4W7Gxyb7/G9rhahx
        s1ssJiEnquJcGad08DrPPttq4v4jjv8=
Date:   Thu, 7 Nov 2019 11:53:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early
 boot
Message-ID: <20191107105310.GD19501@zn.tnic>
References: <157252708836.3876.4604398213417262402.stgit@buzz>
 <20191031142955.GA23693@nazgul.tnic>
 <ad7a25d9-1ca5-0791-ae0a-63c524040bcb@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad7a25d9-1ca5-0791-ae0a-63c524040bcb@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 01, 2019 at 04:39:17PM +0300, Konstantin Khlebnikov wrote:
> I tried 5.4 once but there was no warning.
> Code in 4.19 and in mainline almost the same.

Yes, but early boot code has changed a lot since 4.19. If you can't
trigger it on 5.4, then I'll drop the BUG splat from your commit message
and change it to talk about replacing the IPI-sending function, which is
a good cleanup in itself.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
