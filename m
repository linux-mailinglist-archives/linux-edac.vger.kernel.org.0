Return-Path: <linux-edac+bounces-2429-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B59BBBF8
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 18:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC581C2179D
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C8B1C4A25;
	Mon,  4 Nov 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="HZU/vwnq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4B33FE;
	Mon,  4 Nov 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741502; cv=none; b=tnJTelJhJa7/yedjGA/DsMdKWlyiI9yfLozPbaoUAcIeWbQ5K1Wxrg2Ehi58SFcFiLMmHLFt2omB66txUbfe3A0LRot85SB+kyeBur3390X8pnID2OOlcwKuEJeyP6NnMCufGt4cdmDu4NwpQHu5x5LAx6BX8xk43xYXARW0JYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741502; c=relaxed/simple;
	bh=bYzYZdsD09k9H9vNOFAKrDzxYOLUH/boa/o6ZxGnDUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAWAAcy1dfLa6pDNmJkgICJqnHg3MjxEeqDOAstz8IUIEXleCiQjpe68yUlTATFR9/Zu57ocSbrD0Eu6XB0tUCaSsgoBjoXEw1TH+7FXU0KdCwqr5z7mwi1S8VjXPAIFrgUhVnrRmZPgc2lscgR+T6e4ahNbBipLtCkjEIZDCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=HZU/vwnq; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 4A43o4Pd018918;
	Mon, 4 Nov 2024 16:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=xbU1LFREWTfRbTBmJqp9eANiCr7DLO90j6gn0Jv/yAQ=; b=HZU/vwnqpigv
	LNtbFEBYtSHEgXPNM8z0wpE8vUGQzfQh4wSe2GuG/dnuhgNcv1mofIF1mXmA5N64
	Z5HM4QwKf8kV7V1b+sVOclIMAN3sZPcehezSDUWJ3VGb75wHBHEkCjxVq7q0e3pI
	YK5s9gyeYixxaDLCVIEqiztU/bocZbhBZj+PlRqxY9Mx1fjsPaKLYdXpPOT/oBA3
	sIlL9kVaahF8wQRYuSTRJZ+M0ufmkqsuZgOLxTx+m8gsr6w+P+o5X5uYzJiLb8hb
	1YMU1EzOivLe+9Q6g3/emJrFOGnqHZlDOLlnG8lfyF6yalv3wY48vUSq+owgBVm7
	Wp5QdZTOOA==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 42ncx5y93w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 16:15:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Fndfu031127;
	Mon, 4 Nov 2024 08:15:50 -0800
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 42nj28jx6x-1;
	Mon, 04 Nov 2024 08:15:50 -0800
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id ED0D733D2E;
	Mon,  4 Nov 2024 16:15:49 +0000 (GMT)
Message-ID: <b990a1a9-97e5-469a-8469-0ea5bdc0fc03@akamai.com>
Date: Mon, 4 Nov 2024 11:15:49 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/ie31200: Add Kaby Lake-S dual-core host bridge ID
To: Borislav Petkov <bp@alien8.de>
Cc: James Ye <jye836@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240824120622.46226-1-jye836@gmail.com>
 <20241104160425.GEZyjwiRx74PEqiZRl@fat_crate.local>
Content-Language: en-US
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <20241104160425.GEZyjwiRx74PEqiZRl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_14,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040137
X-Proofpoint-GUID: HrqapkTOmbBlp8XH--qhC1zyleWft4dA
X-Proofpoint-ORIG-GUID: HrqapkTOmbBlp8XH--qhC1zyleWft4dA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 mlxlogscore=866 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040137

On 11/4/24 11:04 AM, Borislav Petkov wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> Jason,
> 
> ack/nak?
> 



Sorry, seems fine...

Acked-by: Jason Baron <jbaron@akamai.com>


Thanks,

-Jason


> On Sat, Aug 24, 2024 at 10:06:22PM +1000, James Ye wrote:
>> Add device ID for dual-core Kaby Lake-S processors e.g. i3-7100.
>>
>> Signed-off-by: James Ye <jye836@gmail.com>
>> ---
>>   drivers/edac/ie31200_edac.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
>> index 9ef13570f2e5..4fc16922dc1a 100644
>> --- a/drivers/edac/ie31200_edac.c
>> +++ b/drivers/edac/ie31200_edac.c
>> @@ -19,7 +19,8 @@
>>    * 0c04: Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller
>>    * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
>>    * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
>> - * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>> + * 590f: Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>> + * 5918: Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>>    * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
>>    * 191f: 6th Gen Core Quad-Core Processor Host Bridge/DRAM Registers
>>    * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
>> @@ -67,7 +68,8 @@
>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x190F
>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1918
>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x191F
>> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x5918
>> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x590f
>> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_12 0x5918
>>   
>>   /* Coffee Lake-S */
>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
>> @@ -88,6 +90,7 @@
>>   	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
>>   	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
>>   	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
>> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_12) ||                       \
>>   	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
>>   	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
>>   
>> @@ -587,6 +590,7 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
>>   	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>>   	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>>   	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_12),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>>   	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>>   	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>>   	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>> -- 
>> 2.46.0
>>
>>
> 

