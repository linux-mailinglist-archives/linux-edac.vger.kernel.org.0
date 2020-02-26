Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD017020D
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 16:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgBZPOe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Feb 2020 10:14:34 -0500
Received: from foss.arm.com ([217.140.110.172]:37256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgBZPOe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Feb 2020 10:14:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260B430E;
        Wed, 26 Feb 2020 07:14:34 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530F33F819;
        Wed, 26 Feb 2020 07:14:33 -0800 (PST)
Subject: Re: [PATCH] trace: ras: print the raw data of arm processor error
 info
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191214121109.8349-1-xiexiuqi@huawei.com>
 <20200109114603.GC5603@zn.tnic>
 <3086a22d-6d66-df74-5878-60a8fc0f1499@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e391ed52-d861-0149-33eb-f55122b6bd6c@arm.com>
Date:   Wed, 26 Feb 2020 15:14:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3086a22d-6d66-df74-5878-60a8fc0f1499@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Xie,

On 13/01/2020 14:10, Xie XiuQi wrote:
> What do you think of this patch?
> 
> On 2020/1/9 19:46, Borislav Petkov wrote:
>>>  );
>>>  
>>>  /*

What patch?!

(digs in the headers)
https://lore.kernel.org/linux-edac/20191214121109.8349-1-xiexiuqi@huawei.com/

>>> -- 
>> That's for ARM folks to decide whether they wanna shuffle raw error
>> records into userspace like that. CCed.

Hmm, this dumps more of 'CPER_SEC_PROC_ARM' to user-space. But not all of it ... (ugh,
this is the thing with three variable length fields in it!) I would like to be able to
parse these in the kernel eventually, but that doesn't matter right now.

I agree privileged user-space should be able to collect all the CPER for some tool to
analyse it. (what else would we do with 'vendor specific error info'?). I'm not totally
convinced tracepoints are the right thing for big blobs of data like this, but its what
we're using today.


I'll show my ignorance about trace points:

How does rasdaemon react to you expanding the trace point like this? I recall they are
self-describing, if user-space doesn't hard code the layout...

You export what may be kernel pointers with the virtual fault address. Is there any way an
unprivileged user can get hold of these?
(its somewhat pointless as user-space can't know what that pointer means)



Thanks,

James
