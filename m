Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A6925195F
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHYNSe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 09:18:34 -0400
Received: from foss.arm.com ([217.140.110.172]:58534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHYNS2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Aug 2020 09:18:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16C11FB;
        Tue, 25 Aug 2020 06:18:16 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14F93F66B;
        Tue, 25 Aug 2020 06:18:15 -0700 (PDT)
Subject: Re: [EXT] Re: [PATCH] edac: nxp: Add L1 and L2 error detection for
 A53 and A72 cores
To:     Alison Wang <alison.wang@nxp.com>, "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200709082215.12829-1-alison.wang@nxp.com>
 <92811e33-2f57-244b-4b50-c2831b09b835@arm.com>
 <VI1PR04MB4062A3BF31A7002AD45E5200F4570@VI1PR04MB4062.eurprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f962eb83-da13-a5de-9f06-b1b987f1e621@arm.com>
Date:   Tue, 25 Aug 2020 14:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4062A3BF31A7002AD45E5200F4570@VI1PR04MB4062.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Alison,

On 25/08/2020 03:31, Alison Wang wrote:
>> On 09/07/2020 09:22, Alison Wang wrote:
>>> Add error detection for A53 and A72 cores. Hardware error injection is
>>> supported on A53. Software error injection is supported on both.
>>
> <snip>
>>
>> As we can't safely write to these registers from linux, so I think this means all
>> the error injection and maybe SMC stuff can disappear.

> I agreed with your opinion that CPUACTLR_EL1 and L2ACTLR can't be written in Linux.

Well, we can't do what the TRM tells us we must before writing to that register.


> So the error injection can't be done in Linux. Do you mean the error injection can
> only be done in firmware before Linux boots up? If so, the system is running with error
> injection enabled all the time, it may be not a good idea too. Any suggestion?

These registers are expected to have one value, forever. The errata document sometimes
tells us to to set or clear one of these bits to workaround an issue. Because they can
only be written to when the system is idle, typically during boot, this is firmware's
responsibility.

I expect firmware to set the bits in ACTLR_EL3, to prevent lower exception levels from
touching any of these registers.


I don't know how the error injection on A53 or A72 works, so I don't know if you can leave
it enabled all the time. The bit you are setting is described as RES0 by the A53 and A72
TRMs. I suspect I had the wrong TRM open, as my 'L1DEIEN' comment seems to be what your
CPUACTLR_EL1[6] is called on A35. (35, 53? Guess how that happened!)

A35's error injection says:
| While this bit is set, double-bit errors are injected on all writes to the L1 D-cache
| data RAMs for the first word of each 32-byte region.

You certainly can't leave this sort of thing enabled! And you can't change it at runtime,
so we can't use it.


I think features like this are intended to be used to check the integration, not to test
the software.


After I sent the original comments on this, I found Sascha's version, which has these
issues resolved:
https://lore.kernel.org/linux-arm-kernel/20200813075721.27981-1-s.hauer@pengutronix.de/

I think this version should work on your platform too.


Thanks,

James
