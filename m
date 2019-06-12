Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD4424DD
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391809AbfFLL6J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 07:58:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:58006 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387878AbfFLL6J (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 07:58:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CBvfmS019047;
        Wed, 12 Jun 2019 06:57:42 -0500
Message-ID: <7705227ea831793cc9e45af32e0da8f5547cb14d.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>,
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
Date:   Wed, 12 Jun 2019 21:57:40 +1000
In-Reply-To: <20190612084213.4fb9e054@coco.lan>
References: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
         <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
         <20190608090556.GA32464@zn.tnic>
         <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
         <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
         <20190611115651.GD31772@zn.tnic>
         <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
         <20190612034813.GA32652@zn.tnic>
         <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
         <20190612074242.53a4cf56@coco.lan> <20190612110039.GH32652@zn.tnic>
         <20190612084213.4fb9e054@coco.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2019-06-12 at 08:42 -0300, Mauro Carvalho Chehab wrote:
> > Yes, we do have different error reporting facilities but I still
> > think
> > that concentrating all the error information needed in order to do
> > proper recovery action is the better approach here. And make that
> > part
> > of the kernel so that it is robust. Userspace can still configure
> > it and
> > so on.
> 
> If the error reporting facilities are for the same hardware "group"
> (like the machine's memory controllers), I agree with you: it makes
> sense to have a single driver. 
> 
> If they are for completely independent hardware then implementing
> as separate drivers would work equally well, with the advantage of
> making easier to maintain and make it generic enough to support
> different vendors using the same IP block.

Right. And if you really want a platform orchestrator for recovery in
the kenrel, it should be a separate one, that consumes data from the
individual IP block drivers that report the raw errors anyway.

But for the main case that really needs to be in the kernel, which is
DRAM, the recovery can usually be contained to the MC driver anyway.

Cheers,
Ben.


