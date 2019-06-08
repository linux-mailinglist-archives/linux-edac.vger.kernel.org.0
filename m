Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B91399EB
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 02:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfFHAWx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 20:22:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:50020 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbfFHAWx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 20:22:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x580MMHP007800;
        Fri, 7 Jun 2019 19:22:23 -0500
Message-ID: <a0913966c27ee0be42796b1e49d871e7e858f6b7.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     James Morse <james.morse@arm.com>,
        "Shenhar, Talel" <talel@amazon.com>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>, Borislav Petkov <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Date:   Sat, 08 Jun 2019 10:22:20 +1000
In-Reply-To: <25efb27c-b725-137d-5735-b3ab88323846@arm.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
         <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
         <20190531051400.GA2275@cz.tnic>
         <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
         <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
         <71da083e-1a74-cf86-455d-260a34ee01fd@amazon.com>
         <25efb27c-b725-137d-5735-b3ab88323846@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2019-06-07 at 16:11 +0100, James Morse wrote:
> I'm coming at this from somewhere else. This stuff has to be considered all the way
> through the system. Just because each component supports error detection, doesn't mean you
> aren't going to get silent corruption. Likewise if another platform picks up two piecemeal
> edac drivers for hardware it happens to have in common with yours, it doesn't mean we're
> counting all the errors. This stuff has to be viewed for the whole platform.

Sure but you don't solve that problem by having a magic myplatform.c
overseer. And even if you do, it can perfectly access the individual IP
block drivers, finding them via phandles in the DT for example etc...
without having to make those individual drivers dependent on some over
arching machine wide probing mechanism.

> But this doesn't give you a device you can bind a driver to, to kick this stuff off.
> This (I assume) is why you added a dummy 'edac_l1_l2' node, that just probes the driver.
> The hardware is to do with the CPU and caches, 'edac_l1'_l2' doesn't correspond to any
> distinct part of the soc.
> 
> The request is to use the machine compatible, not a dummy node. This wraps up the firmware
> properties too, and any other platform property we don't know about today.
> 
> Once you have this, you don't really need the cpu/cache integration annotations, and your
> future memory-controller support can be picked up as part of the platform driver.
> If you have otherwise identical platforms with different memory controllers, OF gives you
> the API to match the node in the DT.

Dummy nodes are pefectly fine, and has been from the early days of Open
Firmware. That said, these aren't so much dummy as a way to expose the
control path to the caches. The DT isn't perfect in its structure and
the way caches and CPUs are represented makes it difficult to represent
arbitrary control path to them without extra nodes, which is thus what
people do.

Cheers,
Ben.

