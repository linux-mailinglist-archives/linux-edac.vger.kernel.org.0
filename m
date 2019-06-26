Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E210565B0
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfFZJdb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 05:33:31 -0400
Received: from foss.arm.com ([217.140.110.172]:57356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZJdb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jun 2019 05:33:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 640EF2B;
        Wed, 26 Jun 2019 02:33:30 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9367F3F718;
        Wed, 26 Jun 2019 02:33:29 -0700 (PDT)
Subject: Re: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-13-rrichter@marvell.com>
 <92eda11f-dad9-bb2b-3a87-80b6c8d8e228@arm.com>
 <20190612184058.2plbdweri6bjmppr@rric.localdomain>
 <c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com>
 <20190620065527.qqulgpk6k5wva4mj@rric.localdomain>
From:   James Morse <james.morse@arm.com>
Message-ID: <043a14f2-3d08-bc81-3a7e-b275179ec1c0@arm.com>
Date:   Wed, 26 Jun 2019 10:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620065527.qqulgpk6k5wva4mj@rric.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 20/06/2019 07:55, Robert Richter wrote:
> On 19.06.19 18:22:32, James Morse wrote:
>>> In any case, this patch cleans up code as old API's counter code is
>>> isolated and moved to common code. Making the counter's work for ghes
>>> is actually a side-effect here. The cleanup is a prerequisit for
>>> follow on patches.
>>
>> I'm all for removing/warning-its-broken it when ghes_edac is in use. But the convincing
>> argument is debian ships a 'current' version of edac-utils that predates 199747106934,
>> (that made all this fake csrow stuff deprecated), and debian's popcon says ~1000 people
>> have it installed.
> 
> All arm64 distribution kernels that I have checked come with:
> 
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_GHES=y
> CONFIG_EDAC_LAYERSCAPE=m
> CONFIG_EDAC_THUNDERX=m
> CONFIG_EDAC_XGENE=m

(distros also enable drivers for hardware no-one has!)

Who uses this? edac-utils, on both arm64 and x86.


>> If you want it fixed, please don't do it as a side effect of cleanup. Fixes need to be a
>> small separate series that can be backported. (unless we're confident no-one uses it, in
>> which case, why fix it?)

> It is not that I am keen on fixing legacy edac sysfs. It just happens
> while unifying the error handlers in ghes_edac and edac_mc. As I see
> you are reluctant on just letting it go, let's just disable
> EDAC_LEGACY_SYSFS for ARM64.

That would break other drivers where those legacy counters expose valid values.

You're painting me as some kind of stubborn villan here. You're right my initial reaction
was 'what for?'. Adding new support for legacy counters that have never worked with
ghes_edac looks like the wrong thing to do.

But unfortunately edac-utils is still using this legacy interface.

If we're going to fix it, could we fix it properly? (separate series that can be
backported to stable).


> Though, I don't agree with it as there
> still could be some userland tools that use this interface that cannot
> be used any longer after a transition from x86 to arm64.

I don't think this is the right thing to do. ghes_edac's behaviour should not change
between architectures.


Where we aren't agreeing is how we fix bugs:

Its either broken, and no-one cares, we should remove it.
Or, we should fix it and those fixes should go to stable.

We can't mix fixes and features in a patch series, as the fixes then can't easily be
backported. If its ever in doubt, the patches should still be as separate fixes so the
maintainer can decide.


Thanks,

James
