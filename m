Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2CA3705
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2019 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfH3Mpb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Aug 2019 08:45:31 -0400
Received: from foss.arm.com ([217.140.110.172]:59676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfH3Mpb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 30 Aug 2019 08:45:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD94337;
        Fri, 30 Aug 2019 05:45:30 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911AE3F246;
        Fri, 30 Aug 2019 05:45:27 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1
 EDAC
To:     Rob Herring <robh@kernel.org>, "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, benh@amazon.com,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
References: <20190805143911.12185-1-hhhawa@amazon.com>
 <20190805143911.12185-2-hhhawa@amazon.com> <20190821191704.GA32425@bogus>
 <1d23d7c5-cd7b-1512-5300-d43e82ba6dc1@amazon.com>
 <CAL_Jsq+8jGbR4u7FA8r0gP5i2H+nSgOkGU_5mfiL=i=c0sOW8A@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d46ac081-1867-2997-e2a3-bcfea42b74f3@arm.com>
Date:   Fri, 30 Aug 2019 13:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+8jGbR4u7FA8r0gP5i2H+nSgOkGU_5mfiL=i=c0sOW8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi guys,

On 27/08/2019 14:49, Rob Herring wrote:
> On Mon, Aug 26, 2019 at 9:49 AM Hawa, Hanna <hhhawa@amazon.com> wrote:
>> On 8/21/2019 10:17 PM, Rob Herring wrote:
>>> Why is this even in DT? AFAICT, this is all just CortexA57 core features
>>> (i.e. nothing Amazon specific). The core type and the ECC capabilities
>>> are discoverable.
>>
>> Added to the DT in order to easily enable/disable the driver.
> 
> That alone is not reason enough to put it in DT. From a DT
> perspective, I have no idea what the whims of a OS maintainer are
> regarding whether they want all this to be 1 driver or 2 drivers.
> (IMO, it should be 1 as this is ECC for an A57. For a core and memory
> controller, then 2 seems appropriate.)
> 
>> You are
>> correct that they are CortexA57 core features and nothing Amazon
>> specific, but it's IMPLEMENTATION DEFINED, meaning that in different
>> cortex revisions (e.g. A57) the register bitmap may change. Because of
>> that we added an Amazon compatible which corresponds to the specific
>> core we are using.

I think its that the instruction encoding is in the imp-def space that is important.

CPU-implementers can add whatever registers they find useful here. A57 and A72 both
implemented some ECC registers here. (They are not guaranteed to be the same, but I can't
find any differences).

We need some information from DT because the TRM doesn't say what happens when you read
from these registers on an A57 that doesn't have the 'optional ECC protection'. It could
take an exception due to an unimplemented system register.

The imp-def instruction space may also be trapped by a higher exception level. KVM does
this, and emulates these registers as if they were all undefined.


Thanks,

James
