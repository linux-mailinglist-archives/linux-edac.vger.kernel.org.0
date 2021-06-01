Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC58396AA7
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jun 2021 03:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhFABmG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 21:42:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3309 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhFABmG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 21:42:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvF986B4rz1BFXw;
        Tue,  1 Jun 2021 09:35:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 09:40:21 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 09:40:20 +0800
Subject: Re: [PATCH v2 3/3] edac: Use 'ret' instead of 'res' to store the
 return value
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jan Luebbe <jlu@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        "Channagoud Kadabi" <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        York Sun <york.sun@nxp.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210531145302.9655-1-thunder.leizhen@huawei.com>
 <20210531145302.9655-4-thunder.leizhen@huawei.com> <YLT5Y+FRhUWWszOq@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4f96d85f-a7a6-531b-a032-a04e51a218cc@huawei.com>
Date:   Tue, 1 Jun 2021 09:40:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YLT5Y+FRhUWWszOq@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2021/5/31 22:57, Borislav Petkov wrote:
> On Mon, May 31, 2021 at 10:53:02PM +0800, Zhen Lei wrote:
>> Usually 'ret' or 'rc' is used as the abbreviation for 'return code', and
>> 'res' is used as the abbreviation for 'resource'.
> 
> Or "result."

https://www.allacronyms.com/result/abbreviated

It seems 'res' is the right abbreviation for 'result'. But since people see 'res',
it's easier to associate 'resource', it's probably better to use it sparingly.
And it seems that 'ret' and 'rc' are used more frequently.

However, the greens and radishes have their own love. So I'm fine with ignoring
this patch.

> 
> Please refrain from doing pointless patches like that - it is a totally
> unnecessary churn.

OK

> 

