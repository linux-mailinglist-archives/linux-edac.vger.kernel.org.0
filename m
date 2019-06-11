Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF04B3C4F4
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbfFKHWM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 03:22:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:40104 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404144AbfFKHWM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 03:22:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5B7LdBB000541;
        Tue, 11 Jun 2019 02:21:40 -0500
Message-ID: <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
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
Date:   Tue, 11 Jun 2019 17:21:39 +1000
In-Reply-To: <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
         <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
         <20190531051400.GA2275@cz.tnic>
         <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
         <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
         <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
         <20190608090556.GA32464@zn.tnic>
         <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2019-06-11 at 15:50 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2019-06-08 at 11:05 +0200, Borislav Petkov wrote:
> > On Sat, Jun 08, 2019 at 10:16:11AM +1000, Benjamin Herrenschmidt wrote:
> > > Those IP blocks don't need any SW coordination at runtime. The drivers
> > > don't share data nor communicate with each other. There is absolultely
> > > no reason to go down that path.
> > 
> > Let me set one thing straight: the EDAC "subsystem" if you will - or
> > that pile of code which does error counting and reporting - has its
> > limitations in supporting one EDAC driver per platform. And whenever we
> > have two drivers loadable on a platform, we have to do dirty hacks like
> > 
> >   301375e76432 ("EDAC: Add owner check to the x86 platform drivers")
> > 
> > What that means is, that if you need to call EDAC logging routines or
> > whatnot from two different drivers, there's no locking, no nothing. So
> > it might work or it might set your cat on fire.
> 
> Should we fix that then instead ? What are the big issues with adding
> some basic locking ? being called from NMIs ?
> 
> If the separate drivers operate on distinct counters I don't see a big
> problem there.

So looking again ... all the registration/removal of edac devices seem
to already be protected by mutexes, so that's not a problem.

Tell me more about what specific races you think we might have here,
I'm not sure I follow...

Cheers,
Ben.


