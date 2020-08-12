Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5544C24247D
	for <lists+linux-edac@lfdr.de>; Wed, 12 Aug 2020 06:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgHLEIu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Aug 2020 00:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgHLEIt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Aug 2020 00:08:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD502C061787
        for <linux-edac@vger.kernel.org>; Tue, 11 Aug 2020 21:08:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so469890pjb.4
        for <linux-edac@vger.kernel.org>; Tue, 11 Aug 2020 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=//mkLAI7oVv7tPrVMf+q8zyv+BuUYqKH5dh+Sj+3EdQ=;
        b=KArapE08iPWlLOYUz2a0GNX7Ix7FzJv4LF6e5BhqlwnkTAOHeijkXm9JE9MkqtROia
         kkR7rHoqSxMX9dXKZDo5fkG/b4gytlCLRiIZRJdE/7EKm7E2jRklbIE4PMfjuyRX12wI
         EozimkgeeX5LuNNaSdkLQ1OZ1nxu1yUMP0UsH4FRGENPKQ4QBfLLMy1tVCJ/DaPRlS9m
         +Pb5GJjH0HO6joiolWK612WMIqhBkLjDfx6VMGLFJtxmD9cSnJiEcWDmOvJBISdS+Azl
         o7WMqYzzqDskQ/IQ1zU234P7lZveJlVl3fypg1aHcmXNYeGyWj7Vafsetu+dAvnhY9Ls
         vzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=//mkLAI7oVv7tPrVMf+q8zyv+BuUYqKH5dh+Sj+3EdQ=;
        b=qCW2cXuq2fSPd5wS18IJ3bdp/6d4rkdHJrwo+NXK6B7M271qmqdYD4hR5dkcbIySLR
         tLP63LLpK3BpAWvahZv+O801EwwScascDJU3orEIk2esYuVm76ASIhADw1QXMUOH3TCD
         aJ1EQz/p4hmfMkX+niAcczie8Tbha3Nuuy1yI5gqUC3V/WzQu8J4BvRAGVsFmDKTJlol
         K849UqfvcuC+/A60i5F/AI9owglvVixsl0bZq34KDgGv7HjI33aP00bPBUNfVXPrpepF
         M4wShzpGV85jp/SqMpMUxOw9GuU0fShx55LOZ4AnwkCbpb6G1pwl5g6VZ08d6MzLHJVK
         U1tA==
X-Gm-Message-State: AOAM533uszHJ+wHYfgk3NcXLg4ycpAVj4bSNBSqtq7OsLpr3JVUF9Q8p
        VhfyaMGeQ68FlANsvqFnhOzP4A==
X-Google-Smtp-Source: ABdhPJx61Guq7ex+BBKhltb8y5VOD7ZmMFyE70VC5rtkvlzNYy6g5mXP9vY5H1z1vwQvMDcDPACnEA==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr3863312plj.64.1597205329263;
        Tue, 11 Aug 2020 21:08:49 -0700 (PDT)
Received: from [10.91.184.177] ([103.136.220.70])
        by smtp.gmail.com with ESMTPSA id z9sm609425pfn.59.2020.08.11.21.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 21:08:48 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] x86/MCE/AMD, EDAC/mce_amd
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxian.1@bytedance.com
References: <20200809043559.9740-1-zhoufeng.zf@bytedance.com>
 <20200810190958.GA3406209@yaz-nikka.amd.com>
From:   zhoufeng <zhoufeng.zf@bytedance.com>
Message-ID: <191bc22e-c1d3-16c3-8ec0-96f3db7c8e24@bytedance.com>
Date:   Wed, 12 Aug 2020 12:08:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200810190958.GA3406209@yaz-nikka.amd.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Ok, as more AMD servers are used in bytedance, we hope to issue a patch 
to the community as soon as possible. Thank you very much.

ÔÚ 2020/8/11 ÉÏÎç3:10, Yazen Ghannam Ð´µÀ:
> On Sun, Aug 09, 2020 at 12:35:59PM +0800, Feng zhou wrote:
>> From: zhoufeng <zhoufeng.zf@bytedance.com>
>>
>> The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
>> later systems. This function is used in amd64_edac_mod to do
>> system-specific decoding for DRAM ECC errors. The function takes a
>> "NodeId" as a parameter.
>>
>> In AMD documentation, NodeId is used to identify a physical die in a
>> system. This can be used to identify a node in the AMD_NB code and also
>> it is used with umc_normaddr_to_sysaddr().
>>
>> However, the input used for decode_dram_ecc() is currently the NUMA node
>> of a logical CPU. so this will cause the address translation function to
>> fail or report incorrect results.
>>
>> Signed-off-by: zhoufeng <zhoufeng.zf@bytedance.com>
>> ---
>>   drivers/edac/mce_amd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index 325aedf46ff2..73c805113322 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -996,7 +996,7 @@ static void decode_smca_error(struct mce *m)
>>   	}
>>   
>>   	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
>> -		decode_dram_ecc(cpu_to_node(m->extcpu), m);
>> +		decode_dram_ecc(topology_physical_package_id(m->extcpu), m);
> This will break on Naples systems, because the NodeId and the physical
> package ID will not match.
>
> I can send a patch soon that will work for Naples, Rome, and later
> systems.
>
> Thanks,
> Yazen
