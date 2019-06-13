Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA30C44F66
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 00:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfFMWlj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 18:41:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfFMWlj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 18:41:39 -0400
Received: from zn.tnic (p200300EC2F06D5002DB642DF7EFF7228.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d500:2db6:42df:7eff:7228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9A3B1EC02FE;
        Fri, 14 Jun 2019 00:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560465698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WfzsL+AaFm5RhSxHdkxpaSHWOSODR4/juwvc4V00ep0=;
        b=V2vmxWVLsxcTtuvpApEGbLr/SgLYjYwgCVAXL3WQHnNfVQl3WWoEt1LcglkN67VsWWwxRd
        rrs4M/1LgF8htotxRFIBjwLNEYvjcm6WnmT6PftV4DnAeXmuuw9m9Mi5MVi20A5ojBQPTg
        hoEVYd0oHd+OPi0RahL3Z/7ORRjcww4=
Date:   Fri, 14 Jun 2019 00:41:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Message-ID: <20190613224130.GI11598@zn.tnic>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 13, 2019 at 09:07:38PM +0000, Robert Richter wrote:
>  grain_bits = fls_long(e->grain) + 1;

For 4K grain this makes grain_bits == 12.

> In ras_event.h the grain then is calculated different to edac_mc
> again:
> 
>  1 << __entry->grain_bits

and this makes it 4096.

Looks ok to me.

But if in James' example, physical_address_mask is 0xfffffffffffff000,
doing

  grain_bits = fls_long(~mem_err->physical_addr_mask);

would make it 11 because ~mem_err->physical_addr_mask (negated) should
be 0xfff.

Is that what you mean?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
