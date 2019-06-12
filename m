Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1036442439
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407586AbfFLLmd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 07:42:33 -0400
Received: from casper.infradead.org ([85.118.1.10]:58138 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405753AbfFLLmd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Jun 2019 07:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bwcoiqvF2SoNHiwEbIFT93eXz9rwnHVmrzehb7eUxsc=; b=YYw1CK+HomH1bUQdmOFtr1LLKo
        nrI2pdZN1vJJdQLLReKvjE3gL7yk3BQbgk0EU5kvhYjFeSQ8AThy/qMchnF7lwPMA1vpKALnA4dIN
        01Nb2u1tOwdct1BpWL4ME+XvkeFN581/KnIZSaTeDgl3AUzKZzYXIjjVgEHTueO9gr6Evdd72hqab
        4/hL8rJUI/Got9CYd0zzpnEOojiS3ake9Qpn1JHduKs5utZTX0ePgiJB8SFrMdw0T1uFIVzH2kDhH
        eYtn8yJ0G9qRHi5H8iMjCv5kBFLJhmIjmxjtNprdsFixXVJE7/5e07m7FbaPn+NxMb/LF/heEHWX9
        72SZQ56g==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb1e0-0001Dc-CP; Wed, 12 Jun 2019 11:42:20 +0000
Date:   Wed, 12 Jun 2019 08:42:13 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
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
Message-ID: <20190612084213.4fb9e054@coco.lan>
In-Reply-To: <20190612110039.GH32652@zn.tnic>
References: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
        <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
        <20190608090556.GA32464@zn.tnic>
        <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
        <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
        <20190611115651.GD31772@zn.tnic>
        <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
        <20190612034813.GA32652@zn.tnic>
        <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
        <20190612074242.53a4cf56@coco.lan>
        <20190612110039.GH32652@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 12 Jun 2019 13:00:39 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Jun 12, 2019 at 07:42:42AM -0300, Mauro Carvalho Chehab wrote:
> > That's said, from the admin PoV, it makes sense to have a single
> > daemon that collect errors from all error sources and take the
> > needed actions.  
> 
> Doing recovery actions in userspace is too flaky. Daemon can get killed
> at any point in time and there are error types where you want to do
> recovery *before* you return to userspace.

Yeah, some actions would work a lot better at Kernelspace. Yet, some
actions would work a lot better if implemented on userspace.

For example, a server with multiple network interfaces may re-route
the traffic to a backup interface if the main one has too many errors.

This can easily be done on userspace.

> Yes, we do have different error reporting facilities but I still think
> that concentrating all the error information needed in order to do
> proper recovery action is the better approach here. And make that part
> of the kernel so that it is robust. Userspace can still configure it and
> so on.

If the error reporting facilities are for the same hardware "group"
(like the machine's memory controllers), I agree with you: it makes
sense to have a single driver. 

If they are for completely independent hardware then implementing
as separate drivers would work equally well, with the advantage of
making easier to maintain and make it generic enough to support
different vendors using the same IP block.

Thanks,
Mauro
