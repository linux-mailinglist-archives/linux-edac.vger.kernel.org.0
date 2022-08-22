Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA359BF16
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiHVL7m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiHVL7h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 07:59:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04871F2C0;
        Mon, 22 Aug 2022 04:59:36 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MBiqwm009852;
        Mon, 22 Aug 2022 11:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uIwJ+Bk8F6uzVsRjs358UWzLQJT7nWg+K+T6V5EH3rE=;
 b=SM0sJcsTgeRfHnP7vHape1PwdqPcCBtvEKq8ocgicqwFoMLOxA56Uyu839f/zyX3u9PQ
 KecdHcK80SoMtiZjkzND3nxr5jP/IB4KeOQautCp71w1yHT2SJXWG3p/+kOccV/OPqSv
 zgGjcjsq6MPDCEGm4D7qMO3tYsd+gtBD7vbgdx0RIN2WqwfQag72N6VZPLB6oqbWcPeu
 qSffJT+E9Bn7XzeEnuf9INKJGK46uwdo/7kX6GZJ5GHT6AwBg28fp1lgqgcDtMrBfED1
 Giz1u8BVVVDfkPDjtEFdCoXZMWOg4yzego6IsSsvc804MtUP2+rHkWrB5Kb0bavodHCl Tg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwp42r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 11:59:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27MBxMcJ030521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 11:59:22 GMT
Received: from [10.50.23.205] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 22 Aug
 2022 04:59:19 -0700
Message-ID: <396e6b2e-11d1-a11d-206a-cfd69f6cd358@quicinc.com>
Date:   Mon, 22 Aug 2022 17:29:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/3] soc: qcom: llcc: Pass SoC specific EDAC register
 offsets to EDAC driver
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
 <20220812060602.7672-2-manivannan.sadhasivam@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220812060602.7672-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sT-azsaa04ZTxOosqKzqStNCImk0ceA_
X-Proofpoint-ORIG-GUID: sT-azsaa04ZTxOosqKzqStNCImk0ceA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_06,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208220050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mani,

On 8/12/2022 11:36 AM, Manivannan Sadhasivam wrote:
> The LLCC EDAC register offsets varies between each SoCs. Until now, the
> EDAC driver used the hardcoded register offsets. But this caused crash
> on SM8450 SoC where the register offsets has been changed.
>
> So to avoid this crash and also to make it easy to accomodate changes for
> new SoCs, let's pass the SoC specific register offsets to the EDAC driver.
>
> Currently, two set of offsets are used. One is SM8450 specific and another
> one is common to all SoCs.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

<snip> ...

>   static const struct qcom_llcc_config sm8350_cfg = {
> @@ -309,6 +370,7 @@ static const struct qcom_llcc_config sm8350_cfg = {
>   	.size           = ARRAY_SIZE(sm8350_data),
>   	.need_llcc_cfg	= true,
>   	.reg_offset	= llcc_v1_2_reg_offset,
> +	.edac_reg	= &common_edac_reg,
>   };
>   
>   static const struct qcom_llcc_config sm8450_cfg = {
> @@ -316,6 +378,7 @@ static const struct qcom_llcc_config sm8450_cfg = {
>   	.size           = ARRAY_SIZE(sm8450_data),
>   	.need_llcc_cfg	= true,
>   	.reg_offset	= llcc_v21_reg_offset,
> +	.edac_reg	= &sm8450_edac_reg,
>   };
>

Can we have LLCC version specific register offsets instead of SoC specific similar to reg_offset callbacks?
For SM8450, it would be llcc_v21_edac_reg and for others llcc_v1_2_edac_reg instead of common_edac_reg.
common_edac_reg is very general and is not exactly common for all, its just common for SoCs with same LLCC.

Version based is more applicable as multiple SoCs might use same LLCC versions and would reduce SoC specific data
which would be needed for every SoC in case some newer LLCC comes out. I know you could just call sm8450_edac_reg
for lets say sm8550 or so on to reduce duplication but that won't look good.


Thanks,
Sai
