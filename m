Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520A23C3A4
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbfFKFvN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 01:51:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:36313 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403745AbfFKFvL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 01:51:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5B5oe0m029024;
        Tue, 11 Jun 2019 00:50:41 -0500
Message-ID: <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>
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
Date:   Tue, 11 Jun 2019 15:50:40 +1000
In-Reply-To: <20190608090556.GA32464@zn.tnic>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
         <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
         <20190531051400.GA2275@cz.tnic>
         <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
         <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
         <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
         <20190608090556.GA32464@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 2019-06-08 at 11:05 +0200, Borislav Petkov wrote:
> On Sat, Jun 08, 2019 at 10:16:11AM +1000, Benjamin Herrenschmidt wrote:
> > Those IP blocks don't need any SW coordination at runtime. The drivers
> > don't share data nor communicate with each other. There is absolultely
> > no reason to go down that path.
> 
> Let me set one thing straight: the EDAC "subsystem" if you will - or
> that pile of code which does error counting and reporting - has its
> limitations in supporting one EDAC driver per platform. And whenever we
> have two drivers loadable on a platform, we have to do dirty hacks like
> 
>   301375e76432 ("EDAC: Add owner check to the x86 platform drivers")
> 
> What that means is, that if you need to call EDAC logging routines or
> whatnot from two different drivers, there's no locking, no nothing. So
> it might work or it might set your cat on fire.

Should we fix that then instead ? What are the big issues with adding
some basic locking ? being called from NMIs ?

If the separate drivers operate on distinct counters I don't see a big
problem there.

> IOW, having multiple separate "drivers" or representations of RAS
> functionality using EDAC facilities is something that hasn't been
> done. Well, almost. highbank_mc_edac.c and highbank_l2_edac.c is one
> example but they make sure they don't step on each other's toes by using
> different EDAC pieces - a device vs a memory controller abstraction.

That sounds like a reasonable requirement.

> And now the moment all of a sudden you decide you want for those
> separate "drivers" to synchronize on something, you need to do something
> hacky like the amd_register_ecc_decoder() thing, for example, because we
> need to call into the EDAC memory controller driver to decode a DRAM ECC
> error properly, while the rest of the error types get decoded somewhere
> else...
> 
> Then there comes the issue with code reuse - wouldn't it be great if a
> memory controller driver can be shared between platform drivers instead of
> copying it in both?
> 
> We already do that - see fsl_ddr_edac.c which gets shared between PPC
> *and* ARM. drivers/edac/skx_common.c is another example for Intel chips.
> 
> Now, if you have a platform with 10 IP blocks which each have RAS
> functionality, are you saying you'll do 10 different pieces called
> 
> <platform_name>_<ip_block#>_edac.c
> 
> ?
> 
> And if <next_platform> has an old IP block with the old RAS
> functionality, you load <platform_name>_<ip_block>_edac.c on the new
> platform too?

I'n not sure why <platform_name> ...

Anyway, let's get back to the specific case of our Amazon platform here
since it's a concrete example.

Hanna, can you give us a reasonably exhaustive list of how many such
"drivers" we'll want in the EDAC subsystem and whether you envision any
coordination requirement between them or not ?

Cheers,
Ben.



