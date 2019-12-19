Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36C125B5E
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 07:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfLSGVY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Dec 2019 01:21:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfLSGVY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Dec 2019 01:21:24 -0500
Received: from zn.tnic (p200300EC2F0B1C00F1A577DA89A48CEF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:1c00:f1a5:77da:89a4:8cef])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12A111EC0591;
        Thu, 19 Dec 2019 07:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576736483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=steoryErl3lLrePbu9jWvjYCeP3FpAY53rDyYMrb8r8=;
        b=B1pvdwoLIo/ycXAo+zotyuEdABWv7Cyj8C1eOb62tARv8nZnZrRxzlXv94d3kt5KmRjgn/
        VfhYxGP4bLYWe0j/uy7+CFTrQ1vdoB8Bbs0eQG3gD6ViLTOamhGs7kJyj5FHPCYBoxMqaa
        hViiA1kbHG5UOB/hgA9TjOsRXrh1Zs4=
Date:   Thu, 19 Dec 2019 07:21:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/aspeed: Remove unneeded semicolon
Message-ID: <20191219062122.GB32039@zn.tnic>
References: <1576735835-114453-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576735835-114453-1-git-send-email-mafeng.ma@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 19, 2019 at 02:10:35PM +0800, Ma Feng wrote:
> Fixes coccicheck warning:
> 
> drivers/edac/aspeed_edac.c:246:2-3: Unneeded semicolon
> drivers/edac/aspeed_edac.c:255:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

https://lkml.kernel.org/r/1576648806-1114-1-git-send-email-vulab@iscas.ac.cn

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
