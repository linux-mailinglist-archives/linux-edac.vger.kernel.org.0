Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4F4479B
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393153AbfFMRAt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 13:00:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:49136 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbfFLX4n (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 19:56:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CNuKVE016725;
        Wed, 12 Jun 2019 18:56:21 -0500
Message-ID: <78de2a9768cfd7d871d3b61f64ce18aefc8c3293.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
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
Date:   Thu, 13 Jun 2019 09:56:20 +1000
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
         <20190612074242.53a4cf56@coco.lan> <20190612110039.GH32652@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2019-06-12 at 13:00 +0200, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 07:42:42AM -0300, Mauro Carvalho Chehab wrote:
> > That's said, from the admin PoV, it makes sense to have a single
> > daemon that collect errors from all error sources and take the
> > needed actions.
> 
> Doing recovery actions in userspace is too flaky. Daemon can get killed
> at any point in time

So what ? If root kills your RAS daemon, then so be it. That has never
been a problem on POWER8/POWER9 server platforms and those have some of
the nastiest RAS in town.

You can kill PID 1 too you know ... 

>  and there are error types where you want to do recovery *before* you return to userspace.

Very few (precise examples please) and I yet have to see why those need
some kind of magic coordinator.

> Yes, we do have different error reporting facilities but I still think
> that concentrating all the error information needed in order to do
> proper recovery action is the better approach here. And make that part
> of the kernel so that it is robust. Userspace can still configure it and
> so on.

Ben.


