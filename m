Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A22804ED
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgJARQL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 13:16:11 -0400
Received: from foss.arm.com ([217.140.110.172]:40646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARQL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 1 Oct 2020 13:16:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A118B1063;
        Thu,  1 Oct 2020 10:16:10 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DAA23F6CF;
        Thu,  1 Oct 2020 10:16:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
To:     Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic> <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
 <20200909120203.GB12237@zn.tnic>
 <50714e083d55491a8ccf5ad847682d1e@huawei.com>
 <20200917084038.GE31960@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <91e71fe9-b002-0f1f-3237-62cea49e083a@arm.com>
Date:   Thu, 1 Oct 2020 18:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917084038.GE31960@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi guys,

On 17/09/2020 09:40, Borislav Petkov wrote:
> On Thu, Sep 10, 2020 at 03:29:56PM +0000, Shiju Jose wrote:

> You can't know what exactly you wanna do if you don't have a use case
> you're trying to address.
> 
>> According to the ARM Processor CPER definition the error types
>> reported are Cache Error, TLB Error, Bus Error and micro-architectural
>> Error.
> 
> Bus error sounds like not even originating in the CPU but the CPU only
> reporting it. Imagine if that really were the case, and you go disable
> the CPU but the error source is still there. You've just disabled the
> reporting of the error only and now you don't even know anymore that
> you're getting errors.
> 
>> Few thoughts on this,
>> 1. Not sure will a CPU core would work/perform as normal after disabling
>> a functional unit?
> 
> You can disable parts of caches, etc, so that you can have a somewhat
> functioning CPU until the replacement maintenance can take place.

This is implementation-specific stuff that only firmware can do...


>> 2. Support in the HW to disable a function unit alone may not available.
> 
> Yes.
> 
>> 3. If it is require to store and retrieve the error count based on
>> functional unit, then CEC will become more complex?
> 
> Depends on how it is designed. That's why we're first talking about what
> needs to be done exactly before going off and doing something.
> 
>> This requirement is the part of the early fault prediction by taking
>> action when large number of corrected errors reported on a CPU core
>> before it causing serious faults.
> 
> And do you know of actual real-life examples where this is really the
> case? Do you have any users who report a large error count on ARM CPUs,
> originating from the caches and that something like that would really
> help?
> 
> Because from my x86 CPUs limited experience, the cache arrays are mostly
> fine and errors reported there are not something that happens very
> frequently so we don't even need to collect and count those.
> 
> So is this something which you need to have in order to check a box
> somewhere that there is some functionality or is there an actual
> real-life use case behind it which a customer has requested?

If the corrected-count is available somewhere, can't this policy be made in user-space?


Thanks,

James
