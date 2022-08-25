Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A55A082C
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 06:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiHYEp5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 00:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHYEp4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 00:45:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA66C6F57C;
        Wed, 24 Aug 2022 21:45:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P3QlqC019611;
        Thu, 25 Aug 2022 04:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ar+1si/4BsXhRaVZTB1vuVwqkv6GqAoH/CexYZSG88g=;
 b=lLjWVgohMoBdcvUh8556td4qmnAOp+b84Gf0jwfNDvQ3NH8DjSXOgDplAWZJOvEKQn5U
 ESsyenrI92vWUlXxXZon9JXzodTft3DJqd7gP2d14oAWqtELQei8wMgL4LWw6CzsqPa8
 Rvu6I/wy0ZycmdaqbgwYjgDSuan/taZIX4b0kB6D6/DPZ6N2mI04+F+pfhJwWIRyFPHL
 auP8eJQ05gn+Ka3h6Csk39oY8/bga2JW4ktpZyBO2Q6d2T03rG0QHSnMwYs2KIkZ5Ni4
 QYBiCl5EVptQmwOKUVCp0JUXUJtfQq8nvFXCjT48yAU7wBBTU4RkeP9TcNQiM9500rll Zg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j5w5jgm8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 04:45:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27P4jhEV028596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 04:45:43 GMT
Received: from [10.50.48.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 21:45:36 -0700
Message-ID: <8e4c6449-e6d0-46fe-f413-46d2445ea82f@quicinc.com>
Date:   Thu, 25 Aug 2022 10:15:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 4/5] EDAC/qcom: Remove extra error no assignment in
 qcom_llcc_core_setup()
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
 <20220825043859.30066-5-manivannan.sadhasivam@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220825043859.30066-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _F2XWZIq6V5_Se4-3VjkpusH5_BmvUsI
X-Proofpoint-GUID: _F2XWZIq6V5_Se4-3VjkpusH5_BmvUsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208250017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 8/25/2022 10:08 AM, Manivannan Sadhasivam wrote:
> If the ret variable is initialized with -EINVAL, then there is no need to
> assign it again in the default case of qcom_llcc_core_setup().

Nit: I think you meant in qcom_llcc_clear_error_status().

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/edac/qcom_edac.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index 04df70b7fea3..0b6ca1f20b51 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -126,7 +126,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
>   static int
>   qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>   {
> -	int ret = 0;
> +	int ret = -EINVAL;
>   
>   	switch (err_type) {
>   	case LLCC_DRAM_CE:
> @@ -158,7 +158,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>   			return ret;
>   		break;
>   	default:
> -		ret = -EINVAL;
>   		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
>   			    err_type);
>   	}

