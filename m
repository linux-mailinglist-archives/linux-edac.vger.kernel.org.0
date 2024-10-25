Return-Path: <linux-edac+bounces-2265-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3F9AF6E2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E711F22471
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C24D8A3;
	Fri, 25 Oct 2024 01:34:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625F1173F
	for <linux-edac@vger.kernel.org>; Fri, 25 Oct 2024 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820096; cv=none; b=k8SdXgTtKn7/ACTjoGTgwV6U1gqP/ch73dcQA6qCtJw9IBxJ4xivRXuBt73Kp37RqAGj952g5CHRD3tNkDz7Dk5vnKTOFTgE8SHfS/eUR1iGyqXpqouO+ifQsC0sTrZ4apIvPOfqAHSnwfN0PeK1Z4tlDATmyKVYnfW3xEvy1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820096; c=relaxed/simple;
	bh=TTzDSsWEppcu/nZkSt3d2iocms+cZC1EGEDS8DYsZT0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iQX3YDa/fu+i580vVKT82ZY9pelze2O8fk87d4u2FqtpIlZ+wsz/8IQWBjDTfW7i8o2rzUQkZA9LcdYQlWrjWUO59BZzjCAciQn/dOaWy0jSJ38KvqecJpyxASSx0hPRCa+rgZf1QgyCyTikKI8xjehvxQCG8ocJcT41OFRsYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZQJ31HXjzdkJY;
	Fri, 25 Oct 2024 09:32:19 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 4944018010F;
	Fri, 25 Oct 2024 09:34:50 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 09:34:49 +0800
Subject: Re: [PATCH 1/1] RAS/AMD/FMPM: Fix return value check in
 setup_debugfs()
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	<linux-edac@vger.kernel.org>
References: <20241023070508.275-1-thunder.leizhen@huawei.com>
 <20241024155503.GA965@yaz-khff2.amd.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a9097bce-72f2-07a9-0343-f39ae779f25d@huawei.com>
Date: Fri, 25 Oct 2024 09:34:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241024155503.GA965@yaz-khff2.amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/24 23:55, Yazen Ghannam wrote:
> Hi Zhen Lei,
> 
> Thanks for the patch.
> 
> The subject line does not need to include 1/1 for a single patch.

OK

> 
> On Wed, Oct 23, 2024 at 03:05:08PM +0800, Zhen Lei wrote:
>> Fix the incorrect return value check for debugfs_create_dir() and
>> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
> 
> Yes, the return value check is incorrect. But I think the solution is
> simpler. Please see the patch at the end.

According to the description of debugfs_create_dir(), the modification
scheme you provide is more appropriate. By the way, fmpm_dfs_entries is
unused now, should be removed.

> 
>> when it fails. In addition, fmpm_dfs_dir should be set to NULL after
>> being reclaimed.
>>
> 
> Why is this needed?

Habitual, sorry, I did not analyze the code carefully before, this
operation is not needed here.

> 
>> Fixes: 7d19eea51757 ("RAS/AMD/FMPM: Add debugfs interface to print record entries")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/ras/amd/fmpm.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
>> index 90de737fbc90978..b1cffbde6d319ed 100644
>> --- a/drivers/ras/amd/fmpm.c
>> +++ b/drivers/ras/amd/fmpm.c
>> @@ -956,12 +956,14 @@ static void setup_debugfs(void)
>>  		return;
>>  
>>  	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
>> -	if (!fmpm_dfs_dir)
>> +	if (IS_ERR(fmpm_dfs_dir))
>>  		return;
>>  
>>  	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
>> -	if (!fmpm_dfs_entries)
>> +	if (IS_ERR(fmpm_dfs_entries)) {
>>  		debugfs_remove(fmpm_dfs_dir);
>> +		fmpm_dfs_dir = NULL;
>> +	}
>>  }
>>
> 
> I think the intention here is correct. But the solution is to just
> remove the error checks entirely.
> 
> Thanks,
> Yazen
> 
> 
>>From 75869583bec8eb95d062cecedc4278bead8a293a Mon Sep 17 00:00:00 2001
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Thu, 24 Oct 2024 10:06:54 -0400
> Subject: [PATCH] RAS/AMD/ATL: Simplify debugfs init
> 
> Drop return value checks as debugfs API says most drivers should ignore
> errors. Issues between creation steps are automatically handled by the
> debugfs code.
> 
> Also, add a code comment highlighting why a valid ras debugfs dentry is
> needed.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/amd/fmpm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 90de737fbc90..3965963d9164 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -952,16 +952,15 @@ static void setup_debugfs(void)
>  {
>  	struct dentry *dfs = ras_get_debugfs_root();
>  
> +	/*
> +	 * Ensure there's a ras debugfs directory so the fmpm files aren't populated in
> +	 * the root debugfs directory.
> +	 */
>  	if (!dfs)
>  		return;
>  
>  	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
> -	if (!fmpm_dfs_dir)
> -		return;
> -
>  	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
> -	if (!fmpm_dfs_entries)
> -		debugfs_remove(fmpm_dfs_dir);
>  }
>  
>  static const struct x86_cpu_id fmpm_cpuids[] = {
> 

-- 
Regards,
  Zhen Lei

