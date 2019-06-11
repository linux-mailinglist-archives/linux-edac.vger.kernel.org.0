Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3493CCB5
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbfFKNMh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 09:12:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389077AbfFKNMg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 09:12:36 -0400
Received: from zn.tnic (p200300EC2F0A6800DC92A88D55C2D513.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:dc92:a88d:55c2:d513])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E82661EC0911;
        Tue, 11 Jun 2019 15:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560258755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EJ7VR9sUEWWF+ZecbxZGX04se8PAYDXjUb4dY5s/kD8=;
        b=KCHvj3ZYpkLfnoRKsXFvWYlmUSfvoaj1TEiKYWgNhqglSi/LYCDwov/V5k+8SIjqzvJoMI
        qIddH3YStkbgi4BPh7zrK+4/pIcOUOr/iFNHx27X3sBpwtEhkx8MCdrSE3yRUHWd8GXORE
        2cxFoWi7Lw3vA5Z/gUeITH0YYX8UOo0=
Date:   Tue, 11 Jun 2019 15:12:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        YueHaibing <yuehaibing@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] EDAC: aspeed: Remove set but not used variable 'np'
Message-ID: <20190611131229.GF31772@zn.tnic>
References: <20190525144153.2028-1-yuehaibing@huawei.com>
 <04f103fb-54b1-4911-8164-44b20bfd1e72@www.fastmail.com>
 <960D5667-41E7-47F3-9C0A-726CA919B82D@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <960D5667-41E7-47F3-9C0A-726CA919B82D@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 29, 2019 at 03:10:54AM +0000, Stefan Schaeckeler (sschaeck) wrote:
> On  Tuesday, May 28, 2019 at 6:27 PM, Andrew Jeffery wrote:
> > On Sun, 26 May 2019, at 00:12, YueHaibing wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > >
> > > drivers/edac/aspeed_edac.c: In function aspeed_probe:
> > > drivers/edac/aspeed_edac.c:284:22: warning: variable np set but not
> > > used [-Wunused-but-set-variable]
> > >
> > > It is never used and can be removed.
> > >
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
