Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76F5A082F
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 06:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiHYEtE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 00:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHYEtE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 00:49:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692559E2D6;
        Wed, 24 Aug 2022 21:49:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P4hYB8003105;
        Thu, 25 Aug 2022 04:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IB70aANIC2fSKXnaGIFcckoPqLOJIOSIfm9bksCmVgs=;
 b=WRf8lYeQGSASYIm7HmxAEcklZ7v1XkxeaVDyyD+c36DraYn0BAyl4Ijknd+J+wOIUa12
 /7R82DNcNXiozfu/pwIMbxkNoo6bexTgv0aJrTGliSXlWhnox8TtFeFEhQ3nOlsAP7dL
 5NJiW+3nboos6i9Zv5ePT4NPVPgnInf9vQEQqNufIu3RXL5vluTY2R08a3E5vUct2Lzq
 ooe0cjMtLllu/DYrret/8wQZhYbpd5faiLVXleREeWEtEdzhy7FnYXOGHV+LxPGPazf8
 ysXG45tb77bSbOMz6EXrer9zzHwP+AzGyd4P8flgz7DrTKqO1KVO0/fJ4JGtu3EfCyrc 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pjnmed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 04:48:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27P4mpH4013401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 04:48:51 GMT
Received: from [10.50.48.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 21:48:47 -0700
Message-ID: <90296ab2-7531-8fd2-a541-ac6189f29988@quicinc.com>
Date:   Thu, 25 Aug 2022 10:18:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/5] soc: qcom: llcc: Rename reg_offset structs to
 reflect LLCC version
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
 <20220825043859.30066-2-manivannan.sadhasivam@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220825043859.30066-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YDASyFU35BecWanbmCARMdGQSTWIXiLR
X-Proofpoint-GUID: YDASyFU35BecWanbmCARMdGQSTWIXiLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=995
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250017
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
> The register offsets used by the LLCC block retains its layout for multiple
> versions. For instance, starting from version v1.0.0 to v2.0.1 the offsets
> are same. And starting from v2.1.0, the offsets changed.
>
> But the current reg_offset naming convention is confusing. So to reflect
> this change correctly in driver, let's encode the start version from which
> the offsets got changed in reg_offset struct name. This will be
> llcc_v1_reg_offset for v1.0.0 and llcc_v2_1_reg_offset for v2.1.0.
> This will allow multiple SoCs to use the same reg_offset clearly.
>
> And in the future if the offsets got changed again, then that specific
> version could be encoded in the struct name.
>
> Suggested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


Thanks,
Sai
