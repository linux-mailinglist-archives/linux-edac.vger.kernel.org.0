Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018405A0832
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 06:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiHYEu5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 00:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHYEu4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 00:50:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248F5A817;
        Wed, 24 Aug 2022 21:50:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P4gbrc030385;
        Thu, 25 Aug 2022 04:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RotjSUX4x9EYEKnrM3t8TrLIfGmaXJTtR+qodsF/qZo=;
 b=HKvWNgHoAL2cj5JX9EyGg8aRmqrD5QM/cQiPJuUUECy8NfCz//U5nNVsypoG5aqlUOPh
 9A69+mZ5jHn+LdpNi/W64iYq7VwNEQrGW2/wGY3nRhybUxNs3T2w7DbOX6BlMRgW6akO
 EaqktOrz5XHzNW30lkOn3JihBxtMq1tkuej4xx2RI7kLzjnZ3oSOITpcveNQS7iR8Tu4
 m4Vi7mTzYImfSL1rww2untsdMz+rBIMDVpkbKJBkuncmSHObR1lExRdYqrNPvffR5Y4C
 AsTu8A0ghTwUu25pKQm/9AxxOY2hE8gHpeVCCtARJZ+V0LFTccexxGKzT/dbQ49qpFKs xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pnng4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 04:50:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27P4ofaK006759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 04:50:41 GMT
Received: from [10.50.48.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 21:50:37 -0700
Message-ID: <1013c5e6-4027-5294-ff2d-2157073c4779@quicinc.com>
Date:   Thu, 25 Aug 2022 10:20:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/5] soc: qcom: llcc: Pass LLCC version based register
 offsets to EDAC driver
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
 <20220825043859.30066-3-manivannan.sadhasivam@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220825043859.30066-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YO8xtF_K96lielcZr8ttbmQbABxfPLgY
X-Proofpoint-GUID: YO8xtF_K96lielcZr8ttbmQbABxfPLgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=898 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 8/25/2022 10:08 AM, Manivannan Sadhasivam wrote:
> The LLCC EDAC register offsets varies between each SoCs. Until now, the
> EDAC driver used the hardcoded register offsets. But this caused crash
> on SM8450 SoC where the register offsets has been changed.
>
> So to avoid this crash and also to make it easy to accommodate changes for
> new SoCs, let's pass the LLCC version specific register offsets to the
> EDAC driver.
>
> Currently, two set of offsets are used. One is starting from LLCC version
> v1.0.0 used by all SoCs other than SM8450. For SM8450, LLCC version
> starting from v2.1.0 is used.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/soc/qcom/llcc-qcom.c       | 66 ++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h | 30 ++++++++++++++
>   2 files changed, 96 insertions(+)

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


Thanks,
Sai
