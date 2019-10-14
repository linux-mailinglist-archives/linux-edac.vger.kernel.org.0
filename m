Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA3D68B4
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbfJNRkg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 13:40:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388646AbfJNRkg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 13:40:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3AAF28;
        Mon, 14 Oct 2019 10:40:35 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3F9F3F6C4;
        Mon, 14 Oct 2019 10:40:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
Date:   Mon, 14 Oct 2019 18:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014173006.GG4715@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 14/10/2019 18:30, Borislav Petkov wrote:
> On Mon, Oct 14, 2019 at 06:19:17PM +0100, James Morse wrote:
>> ghes_edac can only be registered once, later attempts will silently
>> do nothing as the driver is already setup. The unregister path also
>> only expects to be called once, but doesn't check.
>>
>> This leads to KASAN splats if multiple GHES entries are unregistered,
>> as the free()d memory is dereferenced, and if we're lucky, free()d
>> a second time.
>>
>> Link: lore.kernel.org/r/304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com
>>
>> Patch 1 is the minimum needed to prevent the dereference and double
>> free, but this does expose the lack of symmetry. If we unregister
>> one GHES entry, subsequent notifications will be lost.
>> Unregistering is unsafe if another CPU is using the free()d memory in
>> ghes_edac_report_mem_error().
>>
>> To fix this, Patch 2 uses ghes_init as a reference count.
>>
>> We can now unbind all the GHES entries, causing ghes_edac to be

> Thanks for debugging and fixing this but why two patches?
> 
> One is perfectly fine IMO. Or?

They can be merged together if you prefer.

Keeping both avoids the !pvt check in ghes_edac_report_mem_error() going wrong, but I'm
not entirely sure what that is trying to stop...

The possibility of races between notifications and unregister only occurred to me after
testing the first patch, so they ended up as different things in my head: I thought it
deserved its own commit log as its unrelated to the KASAN splat.


> Btw, I admit that the ghes_init thing is ugly as hell. ;-\

> I wonder if it could be ripped out completely and we use only ghes_pvt
> for controlling the single driver instance loading and unloading...

I think you need some kind of reference count to know how many more GHES.x there are out
there that may call unregister, otherwise you race with notifications.


Thanks,

James
