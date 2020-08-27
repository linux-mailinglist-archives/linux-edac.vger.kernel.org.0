Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8245D2543E7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Aug 2020 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgH0KkK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Aug 2020 06:40:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgH0KkK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 06:40:10 -0400
Received: from zn.tnic (p200300ec2f104500a980b16b3f9103d9.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4500:a980:b16b:3f91:3d9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 400221EC037C;
        Thu, 27 Aug 2020 12:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598524804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8mEIx/a3yrzoKPFt6Yw2usL4Qm923jMWVkTk06lBsNQ=;
        b=L//sqCAwjZGwmVXuFDW8sL4eoTT4XyJZgIGi5kN0gd9QXF1ygzZ0qlS5ou+49LLJbAVwD+
        wSC9yFS7ImOYWMXM7BQ1ljuYJwbN4qBZf6TFkzI5EBeEUo1hLvBRVxldj6poARf1eDIfrI
        QBEgMqCnez+tMgf4g1JTbGkCx5nVkNw=
Date:   Thu, 27 Aug 2020 12:40:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] edac: nxp: Add L1 and L2 error detection for
 A53 and A72 cores
Message-ID: <20200827104000.GB30897@zn.tnic>
References: <20200709082215.12829-1-alison.wang@nxp.com>
 <92811e33-2f57-244b-4b50-c2831b09b835@arm.com>
 <VI1PR04MB4062A3BF31A7002AD45E5200F4570@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <f962eb83-da13-a5de-9f06-b1b987f1e621@arm.com>
 <VI1PR04MB4062B4701339466752BFDDE9F4540@VI1PR04MB4062.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4062B4701339466752BFDDE9F4540@VI1PR04MB4062.eurprd04.prod.outlook.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 26, 2020 at 03:03:15AM +0000, Alison Wang wrote:
> [Alison] I have a look at this patch. This patch doesn't complete all
> the functions in my patch.

Yep, but pls work together to see if a single driver can support your hw
too.

> It is just to report errors, but error injection function is all
> removed.

Right, because you can't use that on this hw, apparently.

Also note that you should disable error injection in production for
obvious reasons. Thus all the error injection stuff in EDAC is behind
CONFIG_EDAC_DEBUG which should be off in production kernels.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
