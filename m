Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1844C04
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 21:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfFMTSw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 15:18:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTSw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 15:18:52 -0400
Received: from zn.tnic (p200300EC2F06D500AC63EB441B910094.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d500:ac63:eb44:1b91:94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE67D1EC0985;
        Thu, 13 Jun 2019 21:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560453531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tGmweZyu+PJItjJOWXyB3Q5UWVPPfVhUCDHjLGlC4e8=;
        b=EECThUP9l5MNSE5Dx0ZCv3Gj5Hwy0Zo+VMfoVxBCfaomOnlGPCYhA/k/b4Y57U/kMX5czN
        /aSCgjI5GoU0S734WSVMewokbnVCNp5bHabyblgeNrZ0Ys11sx/24eWsBJoUqOMVfhPWtG
        QRwsT9bwsVqoxiiPcJiuTNf+ctiibf4=
Date:   Thu, 13 Jun 2019 21:18:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Message-ID: <20190613191843.GG11598@zn.tnic>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 13, 2019 at 06:06:22PM +0100, James Morse wrote:
> edac_raw_mc_handle_error() prints it out,

Of course it does, sorry for not seeing it. ;-\

> We could replace edac_raw_mc_handle_error()'s use of e->grain with e->grain_bits, which
> would also make Robert's life easier when trying to merge those paths, but that's a more
> invasive change.
> 
> I did did it like this to make it the minimum change if it was going as a fix. If we're
> confident that no-one has-noticed/cared this can be papered over as part of Robert's
> series, otherwise it will conflict.

Yeah, lemme take your patch as is and we can still improve on that whole
flow once the dust of all that cleanup settles.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
