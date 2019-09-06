Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF8ABDB6
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2019 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbfIFQ3F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Sep 2019 12:29:05 -0400
Received: from foss.arm.com ([217.140.110.172]:59034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389180AbfIFQ3F (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Sep 2019 12:29:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2701570;
        Fri,  6 Sep 2019 09:29:04 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B94C3F59C;
        Fri,  6 Sep 2019 09:29:01 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1
 EDAC
To:     Rob Herring <robh@kernel.org>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
 <d46ac081-1867-2997-e2a3-bcfea42b74f3@arm.com>
 <CAL_Jsq+95qZyHWT_A-=L+SSbR0vmMqQDq8N2XcxwFJVG2HCthA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <21050550-7629-e8f7-2d30-16c1858cf3cc@arm.com>
Date:   Fri, 6 Sep 2019 17:28:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+95qZyHWT_A-=L+SSbR0vmMqQDq8N2XcxwFJVG2HCthA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rob,

On 30/08/2019 22:50, Rob Herring wrote:
> So KVM provides a semi-CortexA57? Code that runs on real h/w won't as a guest.

KVM provides the architectural bits of Cortex-A57's EL1, when running on A57.

Code that depends on EL2, won't run as a guest. Code that depends on some
non-architectural behaviour of A57 won't work in a guest, (e.g. the PMU)
Features the hypervisor doesn't completely support may get hidden. The aim is to provide
an virtual CPU, it might not be exactly the same as the one you're running on.

Hypervisors have to disable access to the imp-def registers as they may allow the guest to
break its confinement. (e.g. messing with the L2 timing)

Code using imp-def instructions at EL1 needs to know they aren't trapped/disabled by a
higher exception level. If someone wants to emulate these, something would need a model of
what those imp-def instructions do.


Thanks,

James
