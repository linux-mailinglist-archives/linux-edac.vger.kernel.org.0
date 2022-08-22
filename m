Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E659BEBC
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHVLoJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHVLoI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 07:44:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C002DA86;
        Mon, 22 Aug 2022 04:44:07 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MBILC8022750;
        Mon, 22 Aug 2022 11:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FfFr/mE7a1nK9PXKqC/BIVCKw0tS51bSlSevwXM8D34=;
 b=FknQ8C1pSmNcMjxi2hlqeH36Fb0ldXNWYP/aXqybd4lBaN0BRn8951dwdN17d05n4ZMV
 qiqs6Nqe/PLSAabVV0Pm2KOOnUqcLfN1LAmLXK9cf5E4tzeTc1QciTJGOlvdQvRjJFAc
 XKFuxBNlp+fbRvTXw7Ry2SbYIz5y3zlo7VxB+Pkx9e+hwt3OZzlrGEEJ/hv0O384suZ8
 EOzKOtaIoYulyHrvXj4iU+RFq19r+1mxsV9LNmJ9uwPY4bRINss5Irxm6aut5hHOaThI
 T6uvVt6yG7CuPCz5O99dBdUMUXdSZk0irNSxKVONQVSiqnAQuAMHUw4R2QohqkGcypRj ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwpc0a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 11:43:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27MBhiGH013744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 11:43:44 GMT
Received: from [10.50.23.205] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 22 Aug
 2022 04:43:41 -0700
Message-ID: <097c66fc-62fa-9dde-99f3-8a1e7370b506@quicinc.com>
Date:   Mon, 22 Aug 2022 17:13:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add myself as the maintainer for
 qcom_edac driver
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
 <20220812060602.7672-4-manivannan.sadhasivam@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220812060602.7672-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ss9OQck3H_vocES-RaQQ-cAxjp-FLB0O
X-Proofpoint-GUID: ss9OQck3H_vocES-RaQQ-cAxjp-FLB0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_06,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=805
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 8/12/2022 11:36 AM, Manivannan Sadhasivam wrote:
> The current maintainers have left Qualcomm and their email addresses were
> bouncing. Since I couldn't get hold of them now, I'm volunteering myself
> to maintain this driver.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 491c7842419a..775f81644bfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7143,8 +7143,7 @@ S:	Maintained
>   F:	drivers/edac/pnd2_edac.[ch]
>   
>   EDAC-QCOM
> -M:	Channagoud Kadabi <ckadabi@codeaurora.org>
> -M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	linux-edac@vger.kernel.org
>   S:	Maintained

Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
