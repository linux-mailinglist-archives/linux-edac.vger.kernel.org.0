Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABB59FAE2
	for <lists+linux-edac@lfdr.de>; Wed, 24 Aug 2022 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiHXNIJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Aug 2022 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiHXNIH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Aug 2022 09:08:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E41979ED;
        Wed, 24 Aug 2022 06:08:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCsvBx011129;
        Wed, 24 Aug 2022 13:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C92YZM5cMwhgJYVIBus9Pp9OYPmeR5q17ZO5INhcwRU=;
 b=gyO8gvuRd9gCF2iVgxlf6EF3EJuyaZRfBA+bRBYb1AkgkYo1yS9hH3yTHzq4ISdwN2ER
 x+z3z7xqnlHcdN8zz9+OvXQQyT90jQ0MNI117wSOGToj4Zby81t6kZyhWkjtwePQs7mo
 n4YJpVjmqfrIsQNpS8lzs7hqNs2/+zsPSSBq4lAH6IjoXVu+NweJ2WU68hto43vS9x4B
 RL3dfcr7eDL6TIBE9+IvtfizTvERmMTsngOwqtSXhTFYhDLGYzlpGqrQfl0TGNWsFGl5
 +usInS+az2ro6Nj/Fg9ZbvQKB55QFxuP3gwauSLYwd8cVQdg3VBj888eudaOi4Corb8Z GQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52phbbxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 13:07:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27OD7h1X013123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 13:07:43 GMT
Received: from [10.50.48.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 06:07:39 -0700
Message-ID: <8a8d52db-b489-61ae-4057-3af1e91b638b@quicinc.com>
Date:   Wed, 24 Aug 2022 18:37:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/3] soc: qcom: llcc: Pass SoC specific EDAC register
 offsets to EDAC driver
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
 <20220812060602.7672-2-manivannan.sadhasivam@linaro.org>
 <396e6b2e-11d1-a11d-206a-cfd69f6cd358@quicinc.com>
 <20220823153152.GA6371@thinkpad>
 <c96016c8-8992-6c8a-b7c1-0ab3722986e0@quicinc.com>
 <20220824125759.GA4767@thinkpad>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220824125759.GA4767@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iCPcglIdwttX5mgPguRrMmMBm9dWFkZ9
X-Proofpoint-GUID: iCPcglIdwttX5mgPguRrMmMBm9dWFkZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 8/24/2022 6:27 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 24, 2022 at 10:43:51AM +0530, Sai Prakash Ranjan wrote:
>> On 8/23/2022 9:01 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Aug 22, 2022 at 05:29:13PM +0530, Sai Prakash Ranjan wrote:
>>>> Hi Mani,
>>>>
>>>> On 8/12/2022 11:36 AM, Manivannan Sadhasivam wrote:
>>>>> The LLCC EDAC register offsets varies between each SoCs. Until now, the
>>>>> EDAC driver used the hardcoded register offsets. But this caused crash
>>>>> on SM8450 SoC where the register offsets has been changed.
>>>>>
>>>>> So to avoid this crash and also to make it easy to accomodate changes for
>>>>> new SoCs, let's pass the SoC specific register offsets to the EDAC driver.
>>>>>
>>>>> Currently, two set of offsets are used. One is SM8450 specific and another
>>>>> one is common to all SoCs.
>>>>>
>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> <snip> ...
>>>>
>>>>>     static const struct qcom_llcc_config sm8350_cfg = {
>>>>> @@ -309,6 +370,7 @@ static const struct qcom_llcc_config sm8350_cfg = {
>>>>>     	.size           = ARRAY_SIZE(sm8350_data),
>>>>>     	.need_llcc_cfg	= true,
>>>>>     	.reg_offset	= llcc_v1_2_reg_offset,
>>>>> +	.edac_reg	= &common_edac_reg,
>>>>>     };
>>>>>     static const struct qcom_llcc_config sm8450_cfg = {
>>>>> @@ -316,6 +378,7 @@ static const struct qcom_llcc_config sm8450_cfg = {
>>>>>     	.size           = ARRAY_SIZE(sm8450_data),
>>>>>     	.need_llcc_cfg	= true,
>>>>>     	.reg_offset	= llcc_v21_reg_offset,
>>>>> +	.edac_reg	= &sm8450_edac_reg,
>>>>>     };
>>>>>
>>>> Can we have LLCC version specific register offsets instead of SoC specific similar to reg_offset callbacks?
>>>> For SM8450, it would be llcc_v21_edac_reg and for others llcc_v1_2_edac_reg instead of common_edac_reg.
>>>> common_edac_reg is very general and is not exactly common for all, its just common for SoCs with same LLCC.
>>>>
>>> I thought about it but I was not sure if rest of the SoCs are using version
>>> v1.2. I know that reg_offset uses v1.2 but I was skeptical and hence used the
>>> SoC specific offsets.
>>>
>>> Can you confirm if rest of the SoCs are using v1.2?
>> LLCC versioning follows w.x.y.z format and w and y are major and minor versions based
>> on which the naming for reg_offsets is chosen.
>>
>> Now in above reg_offsets, llcc_v1_2 is not v1.2, it means v1.0 or v2.0 where 1, 2 is a major version
>> and 0 is a minor version. llcc_v21 is actually v2.1 where 2 is a major and 1 is a minor version.
>> I know the naming is pretty bad, should probably replace llcc_v1_2 with llcc_v1_0_v2_0 and
>> llcc_v21 with llcc_v2_1? Note here minor version is important because SM8350 is v2.0 and uses
>> old reg offsets.
>>
> Yeah it is confusing. I think we should just use the base LLCC version
> that got changed with the previous one and add a comment on top of the
> definition. For instance, all of the SoCs before SM8450 should use
> llcc_v1_reg_offset since the LLCC version starts from v1.0.0 and SM8450 should
> use llcc_v2_1_reg_offset since it supports the LLCC reg offset that got changed
> since v2.1.0. Thoughts?

Ya sounds good, only exception is SM8350 which is v2.0 but will be using v1 in naming but I guess its OK.

Thanks,
Sai

> Thanks,
> Mani
>
>> So coming to your query now, all other SoCs except SM8450(which uses v2.1) are using LLCC v1.0
>> or v2.0, so it is valid to use the same logic as reg_offsets for edac_reg.
>>
>> Thanks,
>> Sai
>>
>>> Thanks,
>>> Mani
>>>
>>>> Version based is more applicable as multiple SoCs might use same LLCC versions and would reduce SoC specific data
>>>> which would be needed for every SoC in case some newer LLCC comes out. I know you could just call sm8450_edac_reg
>>>> for lets say sm8550 or so on to reduce duplication but that won't look good.
>>>>
>>>>
>>>> Thanks,
>>>> Sai

