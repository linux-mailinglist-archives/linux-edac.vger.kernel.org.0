Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5789492057
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2019 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSJbD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Aug 2019 05:31:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfHSJbD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Aug 2019 05:31:03 -0400
Received: from zn.tnic (p200300EC2F04B7001DE01AE6C2F731B7.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:1de0:1ae6:c2f7:31b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E999F1EC0B07;
        Mon, 19 Aug 2019 11:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566207062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tNYqVxZOI4B4YC2lrHxCTcuCtzHSepwsdy73xSCZc0I=;
        b=KfUSIee3hppbIpUeGdON4+xK8tHIudXJtWEIExqzvM0c7bBxsL75CCcfpkJ0BzpEcM8A76
        +9Mxaf8tLNcbfSvj5z4NSqpIbdR+65G9S32QQHB2iT99yR7OpFGN/bHefbdFXSrYS9EkP9
        YHi4W3S3GPAFxtJK58XKTGWQ2YJv9tA=
Date:   Mon, 19 Aug 2019 11:31:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>
Subject: Re: [PATCH v5 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190819093147.GE4841@zn.tnic>
References: <BN6PR04MB1107CE3C2D666A806E62851B86C10@BN6PR04MB1107.namprd04.prod.outlook.com>
 <20190807144016.GA24328@zn.tnic>
 <BY5PR04MB659914AC91EBB3EAF72977BD86D20@BY5PR04MB6599.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR04MB659914AC91EBB3EAF72977BD86D20@BY5PR04MB6599.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 13, 2019 at 01:05:02AM +0000, Lei Wang wrote:
> Added some more comments for the file:
> 
> /*
>   * dmc520_edac.c, EDAC driver for DMC-520 memory controller
      ^^^^^^^^^^^^^

Filename is redundant.

> These comments tell how to potentially expand the driver functions to 
> support more interrupts besides what are already here.

I can read that - the question is why are they there and for whom? For
your future colleagues who'll take over this driver or what is those
comments' purpose?

> As above comments, this comment is to guide potential future adding to 
> this driver to support other interrupts.

See question above.

> After edac_mc_alloc(), if succeeds, the above code updates dmc520_edac 
> struct data. If moving edac_mc_alloc as suggested, I will need to use 
> local variables to store the data,

Yes, do that pls.

> Do you mean having an array to keep all the irq_id, and then only 
> devm_request_irq on them if all of the platform_get_irq are success?

No, move it before edac_mc_alloc().

In general, do *all* initialization of your hardware first and only
then, when it succeeds, allocate the EDAC structures.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
