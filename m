Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745364679B
	for <lists+linux-edac@lfdr.de>; Thu,  8 Dec 2022 04:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLHDQa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Dec 2022 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLHDQZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Dec 2022 22:16:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038C89314;
        Wed,  7 Dec 2022 19:16:24 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B81EOuu017898;
        Thu, 8 Dec 2022 03:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fX9YysgAjbQPemKghGo5CL+0ytYkO+4l+kV31uhGsG0=;
 b=Urw0C2+aeizUx2Zszr36k6rSw/beM+AEbzuA1EvVFqoqx4puJ6rJ2IyrOJiyTLAh/zoj
 dKHYZCqmdlDwP4r8xJLN0WPmzamhV6ktGDYw6TtcKPOlmgUwWYaYLen4b7mEiN/pD/8W
 PrY/2yzGZo7loUUUIPn72heOEsX/I2rIcPU+As6/QW8oaa4rZVPTCUUmRxLz/6O03myU
 oo9EDsyxmcDcrrHvJUltWuAtovrArCg0ajH8lf6cb9/WwWHX4ImsWMEE/0UdX73+NWkX
 kaHV6pDtdkNaVfjxGPYW4F1hgmtjV7B3nYD1nBmd2cm5jWcVvrNGS4q66jT1pc9xffoI fA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3macsyutqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 03:15:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B83FuGW019830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 03:15:56 GMT
Received: from [10.50.39.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 19:15:51 -0800
Message-ID: <5b731ae4-ae5f-af2a-3357-e5e33612a977@quicinc.com>
Date:   Thu, 8 Dec 2022 08:45:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 01/12] dt-bindings: arm: msm: Update the maintainers for
 LLCC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
CC:     <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <quic_ppareek@quicinc.com>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
 <20221207135922.314827-2-manivannan.sadhasivam@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20221207135922.314827-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q2Xqh7G8GZ_wd3d2in99MUSLewY4YCQm
X-Proofpoint-ORIG-GUID: Q2Xqh7G8GZ_wd3d2in99MUSLewY4YCQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=893 priorityscore=1501 phishscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080025
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mani,

On 12/7/2022 7:29 PM, Manivannan Sadhasivam wrote:
> Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
> maintaining with a new identity. So his entry needs to be removed.
> 
> Also, Sai Prakash Ranjan's email address should be updated to use
> quicinc domain.
> 
> Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> index 38efcad56dbd..d1df49ffcc1b 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> @@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Last Level Cache Controller
>   
>   maintainers:
> -  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
> -  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>   

Thanks for updating, I believe you can add yourself as well now since
you maintain LLCC driver.

Either way,

Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


Thanks,
Sai

