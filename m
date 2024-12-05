Return-Path: <linux-edac+bounces-2642-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FC89E5248
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 11:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C6D166AF4
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01171D5CFF;
	Thu,  5 Dec 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fmpZEejG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81A1D5AC9;
	Thu,  5 Dec 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394599; cv=none; b=twNJI2lvmCyKPmZ/cV+y5lfw3NRXfk2SS85ng3Qyrumm6xKEUHGyjPZy/NmvcXXlZBl/Pfpg5i2u2KPxoyMbck588Yyi7/nhl4v/EbYL2mqsa3qEWFcgMvPmTEzsfVcMfRqBn0lJwil4IgnUAB58p6Gd2omC85jvkVwezPg9M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394599; c=relaxed/simple;
	bh=QHDM0wNinR00LodXRJjv7/LI1YF1zZjdx17O0E+assg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WFvj6aY7T/W+l5dYPKu5UO0yU5/XNLS/XXtUjtyaBdswJKGV7JLlO0cZ525DMHMRMCzG4JuOgNGDJIe6zr8qkZWZYco5wmJ62qOUAjgRqur+T6KYXCcyUOp1X6upt8ipOoxRkIrWHIZrn8U+GE4c0AmpfTbK+SFBr9/vyg2UqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fmpZEejG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59x9lq031441;
	Thu, 5 Dec 2024 10:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wq1H4m+TvIZrKAm720V3ELgWHc9sgwnhrbPpxtdoHEk=; b=fmpZEejG3/D7/8JB
	IJjRABkH35du9Lhy0R/qb/c5Yi7YqqeEGBsMXbdRjVWcQmATNNDNRtfTOAakPQ4k
	CS5mYBXfi5bRTTMk9H3KkSiBHJeZXd5YolbGuh1nb3LyaZoz4v8+64Cc7TH4j5Zw
	a4p5SCosos82PIkX82mIRrUAR6jSa51OLraZvle1rPVx25+Tf2hr3r6PzycTNJLD
	1tGSxuFwH91Couo+QK890SiM0f+xH1uqueIL6p6g77kA1LbToLJoZ17pV1Pv1dOY
	UDpZEGE49f09N0+DqyuIEcGnvndFIkDsQdgEkIEGeB2GRHKunHkwKKaZEDN9jLeT
	LZHYMA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba140308-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 10:29:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5ATDjT016102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 10:29:13 GMT
Received: from [10.214.66.218] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 02:29:09 -0800
Message-ID: <a47a11be-377f-489f-a4dd-fd9b4ddc1a98@quicinc.com>
Date: Thu, 5 Dec 2024 15:59:06 +0530
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom: llcc/edac: Correct interrupt enable register
 configuration
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <manivannan.sadhasivam@linaro.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <andy.gross@linaro.org>, <vnkgutta@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241119064608.12326-1-quic_kbajaj@quicinc.com>
 <zkqjyuem3ykeona7p7n6ejkndaxrnpfxjbk33nkzqjjyktoqpw@3b77c4jjdqhd>
Content-Language: en-US
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <zkqjyuem3ykeona7p7n6ejkndaxrnpfxjbk33nkzqjjyktoqpw@3b77c4jjdqhd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QL8mNsrzWj-b6NqZe4aW7CL1bxx54ciD
X-Proofpoint-ORIG-GUID: QL8mNsrzWj-b6NqZe4aW7CL1bxx54ciD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050074


On 11/20/2024 5:29 PM, Dmitry Baryshkov wrote:
> On Tue, Nov 19, 2024 at 12:16:08PM +0530, Komal Bajaj wrote:
>> The previous implementation incorrectly configured the cmn_interrupt_2_enable
>> register for interrupt handling. Using cmn_interrupt_2_enable to configure Tag,
>> Data RAM ECC interrupts would lead to issues like double handling of the
>> interrupts (EL1 and EL3) as cmn_interrupt_2_enable is meant to be configured
>> for interrupts which needs to be handled by EL3.
> This reads as if it was possible to write EL3-related register from EL1.
> Is it true?


Both EL1 and EL3 can access the LLCC "cmn_interrupt_2_enable" register, 
but configuring the register from both
EL1 & EL3 shouldn't be done as the register is meant to be configured 
from EL3. There was a bug in HPG which was
fixed recently on not to configure the register from EL1.

Thanks
Komal


>> EL1 LLCC EDAC driver needs to use cmn_interrupt_0_enable register to
>> configure Tag, Data RAM ECC interrupts instead of cmn_interrupt_2_enable.
>>
>> Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/edac/qcom_edac.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
>> index a9a8ba067007..0fd7a777fe7d 100644
>> --- a/drivers/edac/qcom_edac.c
>> +++ b/drivers/edac/qcom_edac.c
>> @@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
>>   	 * Configure interrupt enable registers such that Tag, Data RAM related
>>   	 * interrupts are propagated to interrupt controller for servicing
>>   	 */
>> -	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
>> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
>>   				 TRP0_INTERRUPT_ENABLE,
>>   				 TRP0_INTERRUPT_ENABLE);
>>   	if (ret)
>> @@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
>>   	if (ret)
>>   		return ret;
>>
>> -	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
>> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
>>   				 DRP0_INTERRUPT_ENABLE,
>>   				 DRP0_INTERRUPT_ENABLE);
>>   	if (ret)
>> --
>> 2.46.0
>>

