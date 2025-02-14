Return-Path: <linux-edac+bounces-3086-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC1A358EE
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3947A1F13
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490B225784;
	Fri, 14 Feb 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jQZG7ahM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518620B1EC;
	Fri, 14 Feb 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521920; cv=none; b=sXNxClXC4YYeWSUg7JLPmxYVmS61l4Crop8+ZTenYSP5P4ecrXtjIFaXhV3rQWcIwVuQlCqbGXHZZrleueT0OS0G+eb5+2Y1oXfJ3tqW7BOTxSLnQWDVebfFNW4qLGpc+BUbSdxjKUow8BnaSg43HrOBUceOaK+lKhACrRO6Q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521920; c=relaxed/simple;
	bh=wrxwUUkAhXJeqvn8eyUY7RVrx/P2wfSmd3iNNlIyoKo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=k06ymY5ZcvPTxfVP6x+cHu8q/0QFdLr39bEQ/9QUaGwDSAo/UgFlXAlKbVkik2PmYbpDw7X2wW3Xx8CUmQedaoBbpM8/iG02rdxJ9og7SQga3uMUSWq6oRJUNaf5Xjv/Xg3Rd2agqGUeXxhw3WdRV3QU7xCft1LoJIOy3uO4JaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jQZG7ahM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E0S3Ps011919;
	Fri, 14 Feb 2025 08:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/KoK3UD4QT8MmiKa6NY+WGL4M1xiLugkgEW5RKhdL0=; b=jQZG7ahMUopFaQ5O
	tIgVSFelu6P4UOmmRO9iRluxa7BDSZ/jzdre0CehAV6vTEri6DnEvmLvCx1VF+DC
	GySLiM1xMOsg9Kj37RU/VRfSIcoT5TVSJ74d7ovt8604r8LEqWiHTEGCX2aVAXPF
	S/5D3X4Y5DaJlMdLfXDHUH1WvQPPVXo07I41YCvU2ZmfGt1IvZKLRu4zta86mQod
	pB9sd+9/K6ZMo7P4Lb1FQX9Z2ZrU94TS1BzbRX2bvQbFdWa33k0sUPgHlS73PfnG
	UbM4cXaa7duyrwqpbHtkpZcBdFKU2o43NufufF3xv4TM5RtSps8mgJMBevsn5Q6V
	ACwNeA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sfxwap4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:31:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51E8V7rK002196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:31:07 GMT
Received: from [10.218.16.221] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Feb
 2025 00:31:02 -0800
Message-ID: <5b6262a7-b0cd-47d9-b4a2-35b7c949bef1@quicinc.com>
Date: Fri, 14 Feb 2025 14:00:51 +0530
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom: llcc/edac: Correct interrupt enable register
 configuration
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <manivannan.sadhasivam@linaro.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <andy.gross@linaro.org>, <vnkgutta@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241119064608.12326-1-quic_kbajaj@quicinc.com>
 <zkqjyuem3ykeona7p7n6ejkndaxrnpfxjbk33nkzqjjyktoqpw@3b77c4jjdqhd>
 <a47a11be-377f-489f-a4dd-fd9b4ddc1a98@quicinc.com>
Content-Language: en-US
In-Reply-To: <a47a11be-377f-489f-a4dd-fd9b4ddc1a98@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RPHlmm2TzeDOo4W9BAnEbuLqom7gWFtV
X-Proofpoint-GUID: RPHlmm2TzeDOo4W9BAnEbuLqom7gWFtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140062




On 12/5/2024 3:59 PM, Komal Bajaj wrote:
>
> On 11/20/2024 5:29 PM, Dmitry Baryshkov wrote:
>> On Tue, Nov 19, 2024 at 12:16:08PM +0530, Komal Bajaj wrote:
>>> The previous implementation incorrectly configured the 
>>> cmn_interrupt_2_enable
>>> register for interrupt handling. Using cmn_interrupt_2_enable to 
>>> configure Tag,
>>> Data RAM ECC interrupts would lead to issues like double handling of 
>>> the
>>> interrupts (EL1 and EL3) as cmn_interrupt_2_enable is meant to be 
>>> configured
>>> for interrupts which needs to be handled by EL3.
>> This reads as if it was possible to write EL3-related register from EL1.
>> Is it true?
>
>
> Both EL1 and EL3 can access the LLCC "cmn_interrupt_2_enable" 
> register, but configuring the register from both
> EL1 & EL3 shouldn't be done as the register is meant to be configured 
> from EL3. There was a bug in HPG which was
> fixed recently on not to configure the register from EL1.
>
> Thanks
> Komal

Hi Dmitry,
Does this answer your query, or is there anything else you are looking for?

Thanks
Komal

>
>
>>> EL1 LLCC EDAC driver needs to use cmn_interrupt_0_enable register to
>>> configure Tag, Data RAM ECC interrupts instead of 
>>> cmn_interrupt_2_enable.
>>>
>>> Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for 
>>> QCOM SoCs")
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>   drivers/edac/qcom_edac.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
>>> index a9a8ba067007..0fd7a777fe7d 100644
>>> --- a/drivers/edac/qcom_edac.c
>>> +++ b/drivers/edac/qcom_edac.c
>>> @@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct 
>>> llcc_drv_data *drv, struct regmap *llcc_b
>>>        * Configure interrupt enable registers such that Tag, Data 
>>> RAM related
>>>        * interrupts are propagated to interrupt controller for 
>>> servicing
>>>        */
>>> -    ret = regmap_update_bits(llcc_bcast_regmap, 
>>> drv->edac_reg_offset->cmn_interrupt_2_enable,
>>> +    ret = regmap_update_bits(llcc_bcast_regmap, 
>>> drv->edac_reg_offset->cmn_interrupt_0_enable,
>>>                    TRP0_INTERRUPT_ENABLE,
>>>                    TRP0_INTERRUPT_ENABLE);
>>>       if (ret)
>>> @@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct 
>>> llcc_drv_data *drv, struct regmap *llcc_b
>>>       if (ret)
>>>           return ret;
>>>
>>> -    ret = regmap_update_bits(llcc_bcast_regmap, 
>>> drv->edac_reg_offset->cmn_interrupt_2_enable,
>>> +    ret = regmap_update_bits(llcc_bcast_regmap, 
>>> drv->edac_reg_offset->cmn_interrupt_0_enable,
>>>                    DRP0_INTERRUPT_ENABLE,
>>>                    DRP0_INTERRUPT_ENABLE);
>>>       if (ret)
>>> -- 
>>> 2.46.0
>>>


