Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533C936F422
	for <lists+linux-edac@lfdr.de>; Fri, 30 Apr 2021 04:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3CsL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Apr 2021 22:48:11 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41556 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229899AbhD3CsK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Apr 2021 22:48:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=kaige.fu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UXDnmhr_1619750830;
Received: from B-J1X9LVDL-1650.local(mailfrom:kaige.fu@linux.alibaba.com fp:SMTPD_---0UXDnmhr_1619750830)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Apr 2021 10:47:11 +0800
Subject: Re: [PATCH] EDAC/mce_amd: Print !SMCA processor warning for 0x19
 family
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org,
        Shannon Zhao <shannon.zhao@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
References: <93c212e8b182843d0a113cb05571416ba19bc355.1619576976.git.kaige.fu@linux.alibaba.com>
 <YIklhWYQL9Cc+8wE@zn.tnic>
From:   Kaige Fu <kaige.fu@linux.alibaba.com>
Message-ID: <30254b2b-1d5c-d918-b300-13ae1a5eb8a1@linux.alibaba.com>
Date:   Fri, 30 Apr 2021 10:47:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIklhWYQL9Cc+8wE@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Borislav, thanks for your comment.


在 2021/4/28 下午5:06, Borislav Petkov 写道:
> On Wed, Apr 28, 2021 at 11:15:06AM +0800, Kaige Fu wrote:
>> KVM doesn't enable SMCA for 0x19 family AMD processors.
>> Consequently, a warning as following will be print when load
>> edac_mce_amd.ko in a virtual machine.
>>
>> "Huh? What family is it: 0x19?!"
>>
>> To make the log more clear, this patch prints !SMCA processor
>> warning for 0x19 family.
> 
> This doesn't make it more clear - it replaces one incorrect statement
> with another.
> 
> You can simply ignore it or not load that module in a guest at all.
> 
