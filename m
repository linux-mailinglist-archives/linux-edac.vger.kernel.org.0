Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68239BF8
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFHJGF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 Jun 2019 05:06:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46438 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfFHJGE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 8 Jun 2019 05:06:04 -0400
Received: from zn.tnic (p200300EC2F288A00DCF654BEDE068B01.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:8a00:dcf6:54be:de06:8b01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 095CF1EC0235;
        Sat,  8 Jun 2019 11:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559984763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=znhinQl17PEsTheLSRwexWszGv20Z4hEeaGt0gI6Nko=;
        b=rDiolTE6ydti3CyGiAtroz5OJOVaWOubsBimpUVEegmDId1qWwoJ7x+iP551w4VLHzKBTd
        dg2oefQPYs6UbnPnx7TV/Vc0PwiHgZtr+eKPnxLqA+dswznVYCOu6beQjP7s07I3zHcVn6
        GSxxdYgVnWYG5OXTBzYlMbIff5gVbak=
Date:   Sat, 8 Jun 2019 11:05:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Message-ID: <20190608090556.GA32464@zn.tnic>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
 <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
 <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jun 08, 2019 at 10:16:11AM +1000, Benjamin Herrenschmidt wrote:
> Those IP blocks don't need any SW coordination at runtime. The drivers
> don't share data nor communicate with each other. There is absolultely
> no reason to go down that path.

Let me set one thing straight: the EDAC "subsystem" if you will - or
that pile of code which does error counting and reporting - has its
limitations in supporting one EDAC driver per platform. And whenever we
have two drivers loadable on a platform, we have to do dirty hacks like

  301375e76432 ("EDAC: Add owner check to the x86 platform drivers")

What that means is, that if you need to call EDAC logging routines or
whatnot from two different drivers, there's no locking, no nothing. So
it might work or it might set your cat on fire.

IOW, having multiple separate "drivers" or representations of RAS
functionality using EDAC facilities is something that hasn't been
done. Well, almost. highbank_mc_edac.c and highbank_l2_edac.c is one
example but they make sure they don't step on each other's toes by using
different EDAC pieces - a device vs a memory controller abstraction.

And now the moment all of a sudden you decide you want for those
separate "drivers" to synchronize on something, you need to do something
hacky like the amd_register_ecc_decoder() thing, for example, because we
need to call into the EDAC memory controller driver to decode a DRAM ECC
error properly, while the rest of the error types get decoded somewhere
else...

Then there comes the issue with code reuse - wouldn't it be great if a
memory controller driver can be shared between platform drivers instead of
copying it in both?

We already do that - see fsl_ddr_edac.c which gets shared between PPC
*and* ARM. drivers/edac/skx_common.c is another example for Intel chips.

Now, if you have a platform with 10 IP blocks which each have RAS
functionality, are you saying you'll do 10 different pieces called

<platform_name>_<ip_block#>_edac.c

?

And if <next_platform> has an old IP block with the old RAS
functionality, you load <platform_name>_<ip_block>_edac.c on the new
platform too?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
