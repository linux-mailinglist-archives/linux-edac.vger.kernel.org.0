Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA722371CB
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFFKdg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 06:33:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfFFKdf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Jun 2019 06:33:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14912341;
        Thu,  6 Jun 2019 03:33:35 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5103F690;
        Thu,  6 Jun 2019 03:33:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     "Hawa, Hanna" <hhhawa@amazon.com>, Borislav Petkov <bp@alien8.de>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
Date:   Thu, 6 Jun 2019 11:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hawa,

On 06/06/2019 08:53, Hawa, Hanna wrote:
> On 5/31/2019 8:14 AM, Borislav Petkov wrote:
>> On Fri, May 31, 2019 at 01:15:33AM +0000, Herrenschmidt, Benjamin wrote:
>>> This isn't terribly helpful, there's nothing telling anybody which of
>>> those files corresponds to an ARM SoC :-)
>>
>> drivers/edac/altera_edac.c is one example.
>>
>> Also, James and I have a small writeup on how an arm driver should look
>> like, we just need to polish it up and post it.
>>
>> James?
>>
>>> That said ...
>>>
>>> You really want a single EDAC driver that contains all the stuff for
>>> the caches, the memory controller, etc... ?
>>
>> Yap.
> 
> Disagree. The various drivers don't depend on each other.
> I think we should keep the drivers separated as they are distinct and independent IP blocks.

But they don't exist in isolation, they both depend on the integration-choices/firmware
that makes up your platform.

Other platforms may have exactly the same IP blocks, configured differently, or with
different features enabled in firmware. This means we can't just probe the driver based on
the presence of the IP block, we need to know the integration choices and firmware
settings match what the driver requires.

(Case in point, that A57 ECC support is optional, another A57 may not have it)

Descriptions of what firmware did don't really belong in the DT. Its not a hardware property.

This is why its better to probe this stuff based on the machine-compatible/platform-name,
not the presence of the IP block in the DT.


Will either of your separate drivers ever run alone? If they're probed from the same
machine-compatible this won't happen.


How does your memory controller report errors? Does it send back some data with an invalid
checksum, or a specific poison/invalid flag? Will the cache report this as a cache error
too, if its an extra signal, does the cache know what it is?

All these are integration choices between the two IP blocks, done as separate drivers we
don't have anywhere to store that information. Even if you don't care about this, making
them separate drivers should only be done to make them usable on other platforms, where
these choices may have been different.


Thanks,

James
