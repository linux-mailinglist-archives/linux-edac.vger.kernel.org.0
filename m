Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79E4BF88
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jun 2019 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfFSRWi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jun 2019 13:22:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbfFSRWg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 19 Jun 2019 13:22:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF272344;
        Wed, 19 Jun 2019 10:22:35 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19CF3F246;
        Wed, 19 Jun 2019 10:22:34 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com>
Date:   Wed, 19 Jun 2019 18:22:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612184058.2plbdweri6bjmppr@rric.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 12/06/2019 19:41, Robert Richter wrote:
> On 29.05.19 16:13:02, James Morse wrote:
>> On 29/05/2019 09:44, Robert Richter wrote:
>>> The ghes driver is not able yet to count legacy API counters in sysfs,
>>> e.g.:
>>>
>>>  /sys/devices/system/edac/mc/mc0/csrow2/ce_count
>>>  /sys/devices/system/edac/mc/mc0/csrow2/ch0_ce_count
>>>  /sys/devices/system/edac/mc/mc0/csrow2/ch1_ce_count
>>>
>>> Make counting csrows/channels generic so that the ghes driver can use
>>> it too.
>>
>> What for?
> 
> With EDAC_LEGACY_SYSFS enabled those counters are exposed to sysfs,
> but the numbers are wrong (all zero).

Excellent, so its legacy and broken.


>> Is this for an arm64 system? Surely we don't have any systems that used to work with these
>> legacy counters. Aren't they legacy because we want new software to stop using them!
> 
> The option is to support legacy userland. If we want to provide a> similar "user experience" as for x86 the counters should be correct.

The flip-side is arm64 doesn't have the same baggage. These counters have never worked
with this driver (even on x86).

This ghes driver also probes on HPE Server platform, so the architecture isn't really
relevant. (I was curious why Marvell care).


> Of course it is not a real mapping to csrows, but it makes that i/f
> work.

(...which stinks)


> In any case, this patch cleans up code as old API's counter code is
> isolated and moved to common code. Making the counter's work for ghes
> is actually a side-effect here. The cleanup is a prerequisit for
> follow on patches.

I'm all for removing/warning-its-broken it when ghes_edac is in use. But the convincing
argument is debian ships a 'current' version of edac-utils that predates 199747106934,
(that made all this fake csrow stuff deprecated), and debian's popcon says ~1000 people
have it installed.


If you want it fixed, please don't do it as a side effect of cleanup. Fixes need to be a
small separate series that can be backported. (unless we're confident no-one uses it, in
which case, why fix it?)



Thanks,

James
