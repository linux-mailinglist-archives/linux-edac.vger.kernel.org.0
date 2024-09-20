Return-Path: <linux-edac+bounces-1900-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698297D472
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3841128639C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061513D510;
	Fri, 20 Sep 2024 10:49:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29255E48
	for <linux-edac@vger.kernel.org>; Fri, 20 Sep 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726829378; cv=none; b=ULpOuNWMyeqMx32JG0nE6uqNA2slIZSoMec85tP9Rf5sCqK67pynLIkhknjYHD1eeSlVZ8o6IXcCrfDQE+MPWBwVGUyLYcs7bLMv0Jo4OBzvHlLUFYm9Y4H6iCW9tWQ9D9rbE/EXjjXcoNXg4WvjSSiP3yddQh0laJ+Bz/BJBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726829378; c=relaxed/simple;
	bh=O1iyWSmvICYpyTIymkA/anLB97fvT84WKC+cyOHOP4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LjIMOZ/DLudFK20IwHj6rSXoovK65dGc+s1/8aqlYeiTDzLxg9L8yj7tL+mTjIMaE5vksv28ZWljv1kXHvQ1t6MmcZ8C4FVyvk1cbGV2J994ao/wMsMLUH8FVHVaspMmSG1SDQl4Sf/YCKIGyyxeemX2b8/wScct6wvv4N5ilJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726829363-1eb14e31a6113f50001-QCVQLf
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id RR8g49eyGhYU0nom (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 20 Sep 2024 18:49:23 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Sep
 2024 18:49:23 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Fri, 20 Sep 2024 18:49:23 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [10.32.65.165] (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Sep
 2024 18:42:13 +0800
Message-ID: <5fa3e397-376b-42c1-9dbe-891e9916987c@zhaoxin.com>
Date: Fri, 20 Sep 2024 18:42:15 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
To: Yazen Ghannam <yazen.ghannam@amd.com>
X-ASG-Orig-Subj: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, Lyle Li <LyleLi@zhaoxin.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
 <20240919140623.GB3717@yaz-khff2.amd.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240919140623.GB3717@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/20/2024 6:49:22 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1726829363
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 987
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130712
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/9/19 22:06, Yazen Ghannam wrote:
> 
>> +void mce_zhaoxin_handle_storm(int bank, bool on)
>> +{
>> +     unsigned long flags;
>> +     u64 val;
>> +
>> +     raw_spin_lock_irqsave(&cmci_discover_lock, flags);
>> +     rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
>> +     if (on) {
>> +             val &= ~(MCI_CTL2_CMCI_EN | MCI_CTL2_CMCI_THRESHOLD_MASK);
>> +             val |= CMCI_STORM_THRESHOLD;
>> +     } else {
>> +             val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
>> +             val |= (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
>> +     }
>> +     wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
>> +     raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>> +}
> 
> Why does this need to be different than mce_intel_handle_storm()?
> 

The reason is actually mentioned in the cover letter: "because Zhaoxin's 
UCR error is not reported through CMCI", and we want to disable CMCI 
interrupt when CMCI storm happened.

Sincerely
TonyWWang-oc


