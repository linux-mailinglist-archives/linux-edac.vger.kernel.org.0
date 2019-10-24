Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0307EE3496
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393740AbfJXNpZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 09:45:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393677AbfJXNpY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 24 Oct 2019 09:45:24 -0400
Received: from zn.tnic (p200300EC2F0F6D006C14721BC32EDA46.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6d00:6c14:721b:c32e:da46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62C761EC0CB2;
        Thu, 24 Oct 2019 15:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571924719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZDDiIZV3N/1CCiWoHasK1HUYfVsvlhqlkoWiG1CA6ws=;
        b=Of9iK+JsmYNONFtkeLUj9egCEHJpdvzCfczMFWtS3SdEVJQxU8uZqj3e8xgaMRKMikxKsf
        SJ5k3neCBb/U7AEz9snyj06KhRrwswAPd2pZjSveI/Wend8ho72MXkzdeo/tLbKrb0AxL3
        DMbvcueT96ApYV6uTfXPCcXaflemDkE=
Date:   Thu, 24 Oct 2019 15:45:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-edac@vger.kernel.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Stefan Schaeckeler <sschaeck@cisco.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC: Aspeed: Use devm_platform_ioremap_resource() in
 aspeed_probe()
Message-ID: <20191024134511.GA1942@zn.tnic>
References: <baabb9e9-a1b2-3a04-9fb6-aa632de5f722@web.de>
 <CACPK8XfUJ5VGpTS3gwxSVZbdWZKPH6PwT2JKGGJ2yzoXYKdtZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPK8XfUJ5VGpTS3gwxSVZbdWZKPH6PwT2JKGGJ2yzoXYKdtZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 23, 2019 at 06:23:53AM +0000, Joel Stanley wrote:
> On Sat, 21 Sep 2019 at 16:47, Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 21 Sep 2019 18:32:46 +0200
> >
> > Simplify this function implementation by using a known wrapper function.
> >
> > This issue was detected by using the Coccinelle software.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Joel Stanley <joel@jms.id.au>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
