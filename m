Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93811396A8D
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jun 2021 03:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhFABR0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 21:17:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6098 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFABRZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 21:17:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvDg001NgzYp17;
        Tue,  1 Jun 2021 09:13:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 09:15:43 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 09:15:42 +0800
Subject: Re: [PATCH 1/1] EDAC, mellanox: Remove redundant error printing in
 bluefield_edac_mc_probe()
To:     Borislav Petkov <bp@alien8.de>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
References: <20210511121856.5996-1-thunder.leizhen@huawei.com>
 <YLT7JOR3fND5Y3K2@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b48a923a-2ae2-c826-fdcb-0f118bdccfc8@huawei.com>
Date:   Tue, 1 Jun 2021 09:15:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YLT7JOR3fND5Y3K2@zn.tnic>
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



On 2021/5/31 23:05, Borislav Petkov wrote:
> On Tue, May 11, 2021 at 08:18:56PM +0800, Zhen Lei wrote:
>> When devm_ioremap_resource() fails, a clear enough error message will be
>> printed by its subfunction __devm_ioremap_resource().
> 
> In every possible failure case or is there a case where an error won't
> be printed and keeping the dev_err() in the driver doesn't hurt at all?

I had sent a patch for the missing case in __devm_ioremap_resource(), but
it seems I was wrong. Please refer to:
https://lkml.org/lkml/2021/5/17/95

> 

