Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1972B13932C
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2020 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgAMOKR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Jan 2020 09:10:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgAMOKR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Jan 2020 09:10:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B278465F1C7162D1F9F;
        Mon, 13 Jan 2020 22:10:14 +0800 (CST)
Received: from [127.0.0.1] (10.133.229.220) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 22:10:12 +0800
Subject: Re: [PATCH] trace: ras: print the raw data of arm processor error
 info
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
CC:     <tony.luck@intel.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191214121109.8349-1-xiexiuqi@huawei.com>
 <20200109114603.GC5603@zn.tnic>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <3086a22d-6d66-df74-5878-60a8fc0f1499@huawei.com>
Date:   Mon, 13 Jan 2020 22:10:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200109114603.GC5603@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.229.220]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

What do you think of this patch?

On 2020/1/9 19:46, Borislav Petkov wrote:
>>  );
>>  
>>  /*
>> -- 
> That's for ARM folks to decide whether they wanna shuffle raw error
> records into userspace like that. CCed.

